//
//  MGTranscriptHeaderContext.m
//  Merge
//
//  Created by Andrew Richardson on 12-07-30.
//
//

#import "MGTranscriptHeaderContext.h"
#import <ChatKit/CKTranscriptHeaderView.h>
#import <QuartzCore/QuartzCore.h>
#import <substrate.h>

extern BOOL _CKSMSShouldLogForType(int type);

static BOOL replacedCKShouldLog(int type)
{
//    if (type == 18)
//        return YES;
    return NO;
}

static const NSTimeInterval MGTranscriptHeaderViewAutoHideDelay = 3.0;

NSString *const CKContentEntryViewDidBeginEditingNotification = @"CKContentEntryViewDidBeginEditingNotification";
NSString *const CKContentEntryViewDidEndEditingNotification = @"CKContentEntryViewDidEndEditingNotification";

@interface MGTranscriptHeaderContext () {
    int contentOffsetIgnoreCount;
}

@property (nonatomic, readwrite) BOOL headerVisible;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipeUpHeaderGesture;

- (void)hideHeaderAnimated;

@end

@implementation MGTranscriptHeaderContext

+ (void)initialize
{
    InstallUncaughtExceptionHandler();
    
    executeDebugBlock(^{
        MSHookFunction(_CKSMSShouldLogForType, replacedCKShouldLog, NULL);
    });
}

+ (BOOL)shouldOverrideHeader
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

- (void)dealloc
{
    [self cancelDelayedHideRequests];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_headerView release];
    [_scrollView release];
    [_swipeUpHeaderGesture release];
    
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        // show header on initial load
        _headerVisible = YES;
    }
    return self;
}

- (UISwipeGestureRecognizer *)swipeUpHeaderGesture
{
    if (!_swipeUpHeaderGesture) {
        _swipeUpHeaderGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(headerDidSwipeUp:)];
        _swipeUpHeaderGesture.direction = UISwipeGestureRecognizerDirectionUp;
    }
    
    return _swipeUpHeaderGesture;
}

- (void)headerDidSwipeUp:(UISwipeGestureRecognizer *)gesture
{
    [self hideHeaderAnimated];
}

- (void)setKeyboardVisible:(BOOL)keyboardVisible
{
    if (_keyboardVisible != keyboardVisible) {
        _keyboardVisible = keyboardVisible;
        DLog(@"keyboardVisible: %d", keyboardVisible);
        if (keyboardVisible)
        {
            [self hideHeaderAnimated];
            [self beginIgnoringContentOffsetChanges];
        }
        else
        {
            [self showHeaderAnimated];
            [self endIgnoringContentOffsetChanges];
        }
    }
}

- (void)setHeaderView:(CKTranscriptHeaderView *)headerView
{
    if (_headerView != headerView) {
        [_headerView release];
        _headerView = [headerView retain];
        
        [_headerView addGestureRecognizer:self.swipeUpHeaderGesture];
        
        // use previous header offset with new header
        self.headerOffset = (self.headerVisible ? 0.0 : -[self effectiveHeaderHeight]);
//        [self _applyHeaderOffsetToHeaderView];
    }
}

- (void)setIgnoringContentOffsetChangesDueToKeyboard:(BOOL)ignore
{
    if (ignore != _ignoringContentOffsetChangesDueToKeyboard)
    {
        _ignoringContentOffsetChangesDueToKeyboard = ignore;
        if (ignore)
            [self beginIgnoringContentOffsetChanges];
        else
            [self endIgnoringContentOffsetChanges];
    }
}

- (BOOL)shouldAlwaysShowHeaderAtContentOffset:(CGFloat)offset
{
    BOOL shouldShow = (offset <= 2*[self effectiveHeaderHeight]);
    
    return shouldShow;
}

- (void)hideHeaderAnimated
{
    [self setHeaderVisible:NO animated:YES];
}

- (void)showHeaderAnimated
{
    [self setHeaderVisible:YES animated:YES];
}

- (void)setHeaderVisible:(BOOL)visible animated:(BOOL)animated
{
    [self setHeaderVisible:visible animated:animated force:NO completion:nil];
}

- (void)setHeaderVisible:(BOOL)visible animated:(BOOL)animated force:(BOOL)force completion:(void (^)(BOOL finished))completion
{
    [self cancelDelayedHideRequests];
//    _headerVisible = visible;
    
//    if (visible)
//        self.headerView.hidden = NO;
    
    if (!visible && !force) {
        // don't hide if header is in always-visible area
        BOOL shouldHide = (self.scrollView.contentOffset.y >= 2*[self effectiveHeaderHeight]);
        if (!shouldHide)
            return;
    }
    
    CGFloat newY = (visible ? 0.0f : -[self effectiveHeaderHeight]);
    
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    DLog(@"visible: %d, animationsEnabled: %d, old offset: %f, new offset: %f", visible, animationsEnabled, self.headerView.frame.origin.y, newY);
    
    [UIView setAnimationsEnabled:YES];
    [UIView animateWithDuration:(animated ? 0.25 : 0.0)
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedDuration
                     animations:^{
                         self.headerOffset = newY;
                     } completion:^(BOOL finished) {
//                         if (finished) {
//                             self.headerView.hidden = !visible;
//                         }
                         DLog(@"completed animation, visible: %d", visible);
                         [self updateVisibleOffsetForActiveHeaderOffset];
                         if (visible) {
                             [self hideHeaderAfterDelay:MGTranscriptHeaderViewAutoHideDelay];
                         }
                         if (completion) {
                             completion(finished);
                         }
                     }];
    [UIView setAnimationsEnabled:animationsEnabled];
}

- (void)cancelDelayedHideRequests
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hideHeaderAnimated)
                                               object:nil];
}

- (void)hideHeaderAfterDelay:(NSTimeInterval)delay
{
    [self cancelDelayedHideRequests];
    [self performSelector:@selector(hideHeaderAnimated) withObject:nil afterDelay:delay];
}

- (CGFloat)effectiveHeaderHeight
{
    CGFloat height = 0.0f;
    if (self.headerView)
    {
        height = self.headerView.bounds.size.height + HEADER_SHADOW_PADDING;
    }
    
    return height;
}

- (void)updateVisibleOffsetForActiveHeaderOffset
{
    CGFloat contentOffset = self.scrollView.contentOffset.y;
    
    self.visibleOffset = [self _calculateVisibleOffsetForContentOffset:contentOffset];
}

- (CGFloat)_calculateVisibleOffsetForContentOffset:(CGFloat)contentOffset
{
    CGFloat headerOffset = self.headerView.frame.origin.y;
    CGFloat headerHeight = [self effectiveHeaderHeight];
    CGFloat visibleOffset;
    
    if (headerOffset > -headerHeight)
        visibleOffset = MAX(contentOffset + headerOffset, 0.0);
    else
        visibleOffset = MAX(contentOffset - HEADER_TOP_SCROLL_PADDING - headerHeight, 0.0);
    
    return visibleOffset;
}

- (CGFloat)updateVisibleOffsetForNewContentOffset:(CGFloat)newOffset force:(BOOL)force
{
    if (!force && contentOffsetIgnoreCount > 0)
        return self.visibleOffset;
    
    CGFloat prevHeaderOffset = self.headerView.frame.origin.y;
    CGFloat prevContentOffset = self.lastKnownOffset;
    
    if (force || (prevHeaderOffset >= 0 && newOffset < prevContentOffset) || newOffset > prevContentOffset)
    {
        self.visibleOffset = [self _calculateVisibleOffsetForContentOffset:prevContentOffset];
    }
    
    return self.visibleOffset;
}

- (void)updateHeaderOffsetForContentOffset:(CGFloat)newOffset force:(BOOL)force
{
    if (newOffset <= 2*[self effectiveHeaderHeight]) {
        [self cancelDelayedHideRequests];
        force = YES;
    }
    
//    CGFloat prevHeaderOffset = self.headerOffset;
//    DLog(@"newContentOffset: %f, force: %d, headerOffset: %f, ignoreCount: %d", newOffset, force, self.headerOffset, contentOffsetIgnoreCount);
    
    if (!force && contentOffsetIgnoreCount > 0)
        return;
        
    BOOL directionValid = YES;
    BOOL forceVisibleOffsetUpdate = NO;
    
    if (self.decelerationDirection != UIScrollViewDirectionNone)
    {
        // check if the scroll view is bouncing
        if (self.decelerationDirection == UIScrollViewDirectionDown &&
            newOffset > self.deceleratingTargetOffset)
        {
            directionValid = NO;
        }
        else if (self.decelerationDirection == UIScrollViewDirectionUp &&
                 newOffset < self.deceleratingTargetOffset)
        {
            directionValid = NO;
        }
        else if (newOffset == self.deceleratingTargetOffset)
        {
            forceVisibleOffsetUpdate = YES;
        }
        
//        if (!directionValid)
//            NSLog(@"direction not valid, target offset: %f, scroll direction: %d, new offset: %f", self.deceleratingTargetOffset, self.decelerationDirection, newOffset);
    }
    
    if (directionValid) {
        [self updateVisibleOffsetForNewContentOffset:newOffset force:(force || forceVisibleOffsetUpdate)];
    }
    
    if (force || directionValid)
    {
        CGFloat newHeaderOffset = MIN(MAX(self.visibleOffset - newOffset, -[self effectiveHeaderHeight]), 0.0);
        self.headerOffset = newHeaderOffset;
    }
    
//    DLog(@"set headerOffset to %f for newContentOffset: %f, force: %d, prev headerOffset: %f, ignoreCount: %d", self.headerOffset, newOffset, force, prevHeaderOffset, contentOffsetIgnoreCount);
    
    if (newOffset > [self effectiveHeaderHeight])
        [self hideHeaderAfterDelay:MGTranscriptHeaderViewAutoHideDelay];
}

//- (CGFloat)headerOffset
//{
//    return self.headerView.frame.origin.y;
//}

- (void)setHeaderOffset:(CGFloat)offset
{
    _headerOffset = offset;
    
    [self _applyHeaderOffsetToHeaderView];
}

- (void)_applyHeaderOffsetToHeaderView
{
    if (self.headerView)
    {
        CGRect frame = self.headerView.frame;
        frame.origin.y = self.headerOffset;
        self.headerView.frame = frame;
        
        _headerVisible = (self.headerOffset > -[self effectiveHeaderHeight]);
    }
}

- (void)beginIgnoringContentOffsetChanges
{
    if (contentOffsetIgnoreCount == 0)
    {
        [self cancelDelayedHideRequests];
    }
    
    contentOffsetIgnoreCount++;
}

- (void)endIgnoringContentOffsetChanges
{
    if (contentOffsetIgnoreCount > 0)
        contentOffsetIgnoreCount--;
}

@end
