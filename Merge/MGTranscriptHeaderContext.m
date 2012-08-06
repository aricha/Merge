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
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(textViewDidBeginEditing:)
                       name:CKContentEntryViewDidBeginEditingNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(textViewDidEndEditing:)
                       name:CKContentEntryViewDidEndEditingNotification
                     object:nil];
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

- (void)textViewDidBeginEditing:(NSNotification *)note
{
    [self hideHeaderAnimated];
    self.ignoringContentOffsetChangesDueToKeyboard = YES;
}

- (void)textViewDidEndEditing:(NSNotification *)note
{
    [self showHeaderAnimated];
    self.ignoringContentOffsetChangesDueToKeyboard = NO;
}

- (void)setHeaderView:(CKTranscriptHeaderView *)headerView
{
    if (_headerView != headerView) {
        [_headerView release];
        _headerView = [headerView retain];
        
        [_headerView addGestureRecognizer:self.swipeUpHeaderGesture];
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
//    if (self.scrollView.contentOffset.y >= 2*[self effectiveHeaderHeight]) {
        [self setHeaderVisible:NO animated:YES];
//    }
}

- (void)showHeaderAnimated
{
    [self setHeaderVisible:YES animated:YES];
}

- (void)setHeaderVisible:(BOOL)visible
{
    [self setHeaderVisible:visible animated:NO];
}

- (void)setHeaderVisible:(BOOL)visible animated:(BOOL)animated
{
    [self cancelDelayedHideRequests];
    _headerVisible = visible;
    
//    if (visible)
//        self.headerView.hidden = NO;
    
    if (!visible) {
        // don't hide if header is in always-visible area
        BOOL shouldHide = (self.scrollView.contentOffset.y >= 2*[self effectiveHeaderHeight]);
        if (!shouldHide)
            return;
    }
    
    CGFloat newY = (visible ? 0.0f : -[self effectiveHeaderHeight]);
    
    BOOL animationsEnabled = [UIView areAnimationsEnabled];
    NSLog(@"visible: %d, animationsEnabled: %d, old offset: %f, new offset: %f", visible, animationsEnabled, self.headerView.frame.origin.y, newY);
    
    [UIView setAnimationsEnabled:YES];
    [UIView animateWithDuration:(animated ? 0.25 : 0.0)
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionOverrideInheritedDuration
                     animations:^{
                         CGRect frame = self.headerView.frame;
                         frame.origin.y = newY;
                         self.headerView.frame = frame;
                         
                     } completion:^(BOOL finished) {
//                         if (finished) {
//                             self.headerView.hidden = !visible;
//                         }
                         NSLog(@"completed animation, visible: %d", visible);
                         [self updateVisibleOffsetForActiveHeaderOffset];
                         if (visible) {
                             [self hideHeaderAfterDelay:MGTranscriptHeaderViewAutoHideDelay];
                         }
                     }];
//    [UIView setAnimationsEnabled:animationsEnabled];
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
                
        CGRect frame = self.headerView.frame;
        frame.origin.y = newHeaderOffset;
        self.headerView.frame = frame;
    }
    
    if (newOffset > [self effectiveHeaderHeight])
        [self hideHeaderAfterDelay:MGTranscriptHeaderViewAutoHideDelay];
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
