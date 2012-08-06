// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

#import <ChatKit/CKTranscriptController.h>
#import <ChatKit/CKTranscriptHeaderView.h>
#import <substrate.h>
#import <QuartzCore/QuartzCore.h>
#import <ChatKit/CKTranscriptTableView.h>
#import <ChatKit/UIPlacardButton.h>
#import <objc/runtime.h>
#import "MGTranscriptHeaderContext.h"
#import <ChatKit/CKContentEntryView.h>

%hook CKContentEntryView

- (void)textContentViewDidBeginEditing:(id)textContentView
{
    %orig;
    [[NSNotificationCenter defaultCenter] postNotificationName:CKContentEntryViewDidBeginEditingNotification object:self];
}

%new(v@:@)
- (void)textContentViewDidEndEditing:(id)textContentView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CKContentEntryViewDidEndEditingNotification object:self];
}

%end

%hook CKTranscriptHeaderView

- (id)initWithFrame:(CGRect)frame isPhoneTranscript:(BOOL)transcript displayLoadPrevious:(BOOL)previous isGroupMessage:(BOOL)message
{
    self = %orig;
    
    self.backgroundColor = [CKTranscriptController tableColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    self.clipsToBounds = NO;
    
    if (previous) {
        UIPlacardButton *button = MSHookIvar<id>(self, "_loadMoreButton");
        [button removeFromSuperview];
        
        CGRect bounds = self.frame;
        bounds.size.height = [CKTranscriptHeaderView defaultHeight];
        self.frame = bounds;
    }
    
    return self;
}

- (void)layoutSubviews
{
    %orig;
    
    CGRect bounds = self.frame;
    bounds.size.height = [CKTranscriptHeaderView defaultHeight];
    self.frame = bounds;
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

%end

static NSString *const CKTranscriptTableViewLayoutBlockKey = @"layoutBlock";

%hook CKTranscriptTableView

- (void)layoutSubviews
{
    %orig;
    
    void (^updateBlock)(CKTranscriptTableView *) = objc_getAssociatedObject(self, CKTranscriptTableViewLayoutBlockKey);
    if (updateBlock)
        updateBlock(self);
}

%end

@interface CKTranscriptController ()
-(void)updateHeaderView;
-(MGTranscriptHeaderContext *)headerContext;
@end

static const NSTimeInterval MGTranscriptHeaderViewAutoHideDelay = 3.0;

%hook CKTranscriptController

%new(@@:)
-(MGTranscriptHeaderContext *)headerContext
{
    static NSString *const MGTranscriptHeaderContextKey = @"headerContext";
    
    MGTranscriptHeaderContext *context = objc_getAssociatedObject(self, MGTranscriptHeaderContextKey);
    if (!context) {
        context = [[MGTranscriptHeaderContext new] autorelease];
        
        CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
        if (header) {
            context.headerView = header;
        }
        
        objc_setAssociatedObject(self, MGTranscriptHeaderContextKey, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return context;
}

%new(v@:)
-(void)updateHeaderView
{
    CGFloat offset = self.transcriptTable.contentOffset.y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
//    CGRect frame = header.frame;
//    frame.origin = offset;
//    header.frame = frame;
    
    CGFloat relativeHeaderOffset = header.frame.origin.y + offset;
    
    header.layer.shadowOpacity = MIN((relativeHeaderOffset / header.frame.size.height), 1.0);
//    [self.transcriptTable bringSubviewToFront:header];
    
    UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
    if (header) {
        insets.top = header.frame.size.height;
    }
    else {
        insets.top = 0;
    }
    self.transcriptTable.scrollIndicatorInsets = insets;
}

- (void)loadView
{
    %orig;
    
    __block CKTranscriptController *blockSelf = self;
    void (^updateBlock)(CKTranscriptTableView *) = ^(CKTranscriptTableView *tableView) {
        [blockSelf updateHeaderView];
    };
    objc_setAssociatedObject(self.transcriptTable, CKTranscriptTableViewLayoutBlockKey, updateBlock, OBJC_ASSOCIATION_COPY);
    
    [[self headerContext] setScrollView:self.transcriptTable];
}

- (void)viewWillAppear:(BOOL)animated
{
    %orig;
    
//    [[self headerContext] updateHeaderOffsetForContentOffset:self.transcriptTable.contentOffset.y force:YES];
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    
//    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
//    
//    CGRect headerFrame = header.frame;
//    headerFrame.origin.y = self.transcriptTable.contentOffset.y;
//    header.frame = headerFrame;
    
//    MGTranscriptHeaderContext *context = [self headerContext];
//    [context setHeaderVisible:context.headerVisible animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    %orig;
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    NSLog(@"viewDidAppear, visibleOffset: %f, contentOffset: %f", [[self headerContext] visibleOffset], self.transcriptTable.contentOffset.y);
}

- (void)_setupTranscriptHeader {
    %log;
    %orig;
    
//    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
//    
//    CGRect headerFrame = header.frame;
//    headerFrame.origin.y = self.transcriptTable.contentOffset.y;
//    header.frame = headerFrame;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    MGTranscriptHeaderContext *context = [self headerContext];
    [context beginIgnoringContentOffsetChanges];
    context.rotatingHeaderOffset = context.headerView.frame.origin.y;
    
    %orig;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    %orig;
    [[self headerContext] endIgnoringContentOffsetChanges];
    MGTranscriptHeaderContext *context = [self headerContext];
    CGRect frame = context.headerView.frame;
    frame.origin.y = context.rotatingHeaderOffset;
    context.headerView.frame = frame;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    [[self headerContext] updateHeaderOffsetForContentOffset:self.transcriptTable.contentOffset.y force:YES];
    MGTranscriptHeaderContext *context = [self headerContext];
    CGRect frame = context.headerView.frame;
    frame.origin.y = context.rotatingHeaderOffset;
    context.headerView.frame = frame;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

- (void)_showTranscriptHeaderView {
    %orig;
    %log;
    
    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
    if (header) {
        MGTranscriptHeaderContext *context = [self headerContext];
        context.headerView = header;
//    [context setHeaderVisible:YES animated:NO];
//        [context hideHeaderAfterDelay:MGTranscriptHeaderViewAutoHideDelay];
        
//    CGRect headerFrame = header.frame;
//    headerFrame.origin.y = self.transcriptTable.contentOffset.y;
//    header.frame = headerFrame;
        
//        self.transcriptTable.tableHeaderView = nil;
        
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button && header.hasMoreMessages && !button.superview) {
            [self.transcriptTable addSubview:button];
//            self.transcriptTable.tableHeaderView = button;
            
            CGPoint center = button.center;
            center.y = [CKTranscriptHeaderView defaultHeight] / 2;
            center.x = self.transcriptTable.frame.size.width / 2;
            button.center = center;
        }
        
//        self.transcriptTable.tableHeaderView = nil;
        [header removeFromSuperview];
        [self.view addSubview:header];
        
        UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
        insets.top = header.frame.size.height;
        self.transcriptTable.scrollIndicatorInsets = insets;
    }
}

- (void)_hideTranscriptHeaderView {
    %log;
    
    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
    if (header) {
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button)
            [button removeFromSuperview];
    }
    [self headerContext].headerView = nil;
    
    UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
    insets.top = 0;
    self.transcriptTable.scrollIndicatorInsets = insets;
    
    %orig;
}

- (void)_updateTranscriptHeaderView
{
    %log;
    %orig;
    
//    CKTranscriptHeaderView *header = [self headerContext].headerView;
//    self.transcriptTable.tableHeaderView = nil;
//    [header removeFromSuperview];
//    [self.view addSubview:header];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
//    CGRect oldHeaderFrame = header.frame;
    
    BOOL prevEditing = [self.transcriptTable isEditing];
    
    if (editing && !prevEditing) {
        [context beginIgnoringContentOffsetChanges];
    }
    
    if (header) {
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button) {
            button.hidden = editing;
        }
    }
    
    %log;
    %orig;
    
//    header.frame = oldHeaderFrame;
//    header.hidden = editing;
    if (!editing) {
        BOOL shouldShow = [context shouldAlwaysShowHeaderAtContentOffset:self.transcriptTable.contentOffset.y];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:header];
            [context setHeaderVisible:shouldShow animated:NO];
        }];
        
//        if (prevEditing) {
            [context performSelector:@selector(endIgnoringContentOffsetChanges) withObject:nil afterDelay:0.5];
//        }
    }
    
//    if (!editing) {
//        [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
//    }
}

- (void)reload:(BOOL)reload
{
    %orig;
    %log;
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
}

%new(v@:@)
-(void)scrollViewDidScroll:(UIScrollView *)sv {
    CGFloat newOffset = sv.contentOffset.y;
    MGTranscriptHeaderContext *context = [self headerContext];
    
    if (!sv.decelerating) {
        context.decelerationDirection = UIScrollViewDirectionNone;
    }
    
    [context updateHeaderOffsetForContentOffset:newOffset force:NO];
    
    context.lastKnownOffset = newOffset;
}

%new(v@:@)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sv
{
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = UIScrollViewDirectionNone;
}

%new(v@:@{CGPoint=ff}^{CGPoint=ff})
- (void)scrollViewWillEndDragging:(UIScrollView *)sv withVelocity:(CGPoint)velocity targetContentOffset:(CGPoint *)targetContentOffset
{
    CGFloat targetY = (*targetContentOffset).y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = (velocity.y > 0 ? UIScrollViewDirectionDown : UIScrollViewDirectionUp);
    context.deceleratingTargetOffset = targetY;
}

%end