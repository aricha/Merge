#line 1 "/Users/andrewr114/Dropbox/Development/Merge/Merge/Merge.xm"



#import <ChatKit/CKTranscriptController.h>
#import <ChatKit/CKTranscriptHeaderView.h>
#import <substrate.h>
#import <QuartzCore/QuartzCore.h>
#import <ChatKit/CKTranscriptTableView.h>
#import <ChatKit/UIPlacardButton.h>
#import <objc/runtime.h>
#import "MGTranscriptHeaderContext.h"
#import <ChatKit/CKContentEntryView.h>

#include <substrate.h>
@class CKTranscriptTableView; @class CKTranscriptHeaderView; @class CKContentEntryView; @class CKTranscriptController; 

#line 14 "/Users/andrewr114/Dropbox/Development/Merge/Merge/Merge.xm"



static void (*__ungrouped$CKContentEntryView$textContentViewDidBeginEditing$)(CKContentEntryView*, SEL, id);static void $_ungrouped$CKContentEntryView$textContentViewDidBeginEditing$(CKContentEntryView* self, SEL _cmd, id textContentView) {
    __ungrouped$CKContentEntryView$textContentViewDidBeginEditing$(self, _cmd, textContentView);
    [[NSNotificationCenter defaultCenter] postNotificationName:CKContentEntryViewDidBeginEditingNotification object:self];
}



static void $_ungrouped$CKContentEntryView$textContentViewDidEndEditing$(CKContentEntryView* self, SEL _cmd, id textContentView) {
    [[NSNotificationCenter defaultCenter] postNotificationName:CKContentEntryViewDidEndEditingNotification object:self];
}






static id (*__ungrouped$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$)(CKTranscriptHeaderView*, SEL, CGRect, BOOL, BOOL, BOOL);static id $_ungrouped$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(CKTranscriptHeaderView* self, SEL _cmd, CGRect frame, BOOL transcript, BOOL previous, BOOL message) {
    self = __ungrouped$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(self, _cmd, frame, transcript, previous, message);
    
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


static void (*__ungrouped$CKTranscriptHeaderView$layoutSubviews)(CKTranscriptHeaderView*, SEL);static void $_ungrouped$CKTranscriptHeaderView$layoutSubviews(CKTranscriptHeaderView* self, SEL _cmd) {
    __ungrouped$CKTranscriptHeaderView$layoutSubviews(self, _cmd);
    
    CGRect bounds = self.frame;
    bounds.size.height = [CKTranscriptHeaderView defaultHeight];
    self.frame = bounds;
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}



static NSString *const CKTranscriptTableViewLayoutBlockKey = @"layoutBlock";




static void (*__ungrouped$CKTranscriptTableView$layoutSubviews)(CKTranscriptTableView*, SEL);static void $_ungrouped$CKTranscriptTableView$layoutSubviews(CKTranscriptTableView* self, SEL _cmd) {
    __ungrouped$CKTranscriptTableView$layoutSubviews(self, _cmd);
    
    void (^updateBlock)(CKTranscriptTableView *) = objc_getAssociatedObject(self, CKTranscriptTableViewLayoutBlockKey);
    if (updateBlock)
        updateBlock(self);
}



@interface CKTranscriptController ()
-(void)updateHeaderView;
-(MGTranscriptHeaderContext *)headerContext;
@end

static const NSTimeInterval MGTranscriptHeaderViewAutoHideDelay = 3.0;





static MGTranscriptHeaderContext * $_ungrouped$CKTranscriptController$headerContext(CKTranscriptController* self, SEL _cmd) {
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



static void $_ungrouped$CKTranscriptController$updateHeaderView(CKTranscriptController* self, SEL _cmd) {
    CGFloat offset = self.transcriptTable.contentOffset.y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    



    
    CGFloat relativeHeaderOffset = header.frame.origin.y + offset;
    
    header.layer.shadowOpacity = MIN((relativeHeaderOffset / header.frame.size.height), 1.0);

    
    UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
    if (header) {
        insets.top = header.frame.size.height;
    }
    else {
        insets.top = 0;
    }
    self.transcriptTable.scrollIndicatorInsets = insets;
}


static void (*__ungrouped$CKTranscriptController$loadView)(CKTranscriptController*, SEL);static void $_ungrouped$CKTranscriptController$loadView(CKTranscriptController* self, SEL _cmd) {
    __ungrouped$CKTranscriptController$loadView(self, _cmd);
    
    __block CKTranscriptController *blockSelf = self;
    void (^updateBlock)(CKTranscriptTableView *) = ^(CKTranscriptTableView *tableView) {
        [blockSelf updateHeaderView];
    };
    objc_setAssociatedObject(self.transcriptTable, CKTranscriptTableViewLayoutBlockKey, updateBlock, OBJC_ASSOCIATION_COPY);
    
    [[self headerContext] setScrollView:self.transcriptTable];
}


static void (*__ungrouped$CKTranscriptController$viewWillAppear$)(CKTranscriptController*, SEL, BOOL);static void $_ungrouped$CKTranscriptController$viewWillAppear$(CKTranscriptController* self, SEL _cmd, BOOL animated) {
    __ungrouped$CKTranscriptController$viewWillAppear$(self, _cmd, animated);
    

    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    





    


}


static void (*__ungrouped$CKTranscriptController$viewDidAppear$)(CKTranscriptController*, SEL, BOOL);static void $_ungrouped$CKTranscriptController$viewDidAppear$(CKTranscriptController* self, SEL _cmd, BOOL animated) {
    __ungrouped$CKTranscriptController$viewDidAppear$(self, _cmd, animated);
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    NSLog(@"viewDidAppear, visibleOffset: %f, contentOffset: %f", [[self headerContext] visibleOffset], self.transcriptTable.contentOffset.y);
}

static void (*__ungrouped$CKTranscriptController$_setupTranscriptHeader)(CKTranscriptController*, SEL);static void $_ungrouped$CKTranscriptController$_setupTranscriptHeader(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _setupTranscriptHeader]", self);
    __ungrouped$CKTranscriptController$_setupTranscriptHeader(self, _cmd);
    





}


static void (*__ungrouped$CKTranscriptController$willRotateToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval);static void $_ungrouped$CKTranscriptController$willRotateToInterfaceOrientation$duration$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation toInterfaceOrientation, NSTimeInterval duration) {
    MGTranscriptHeaderContext *context = [self headerContext];
    [context beginIgnoringContentOffsetChanges];
    context.rotatingHeaderOffset = context.headerView.frame.origin.y;
    
    __ungrouped$CKTranscriptController$willRotateToInterfaceOrientation$duration$(self, _cmd, toInterfaceOrientation, duration);
}


static void (*__ungrouped$CKTranscriptController$didRotateFromInterfaceOrientation$)(CKTranscriptController*, SEL, UIInterfaceOrientation);static void $_ungrouped$CKTranscriptController$didRotateFromInterfaceOrientation$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation fromInterfaceOrientation) {
    __ungrouped$CKTranscriptController$didRotateFromInterfaceOrientation$(self, _cmd, fromInterfaceOrientation);
    [[self headerContext] endIgnoringContentOffsetChanges];
    MGTranscriptHeaderContext *context = [self headerContext];
    CGRect frame = context.headerView.frame;
    frame.origin.y = context.rotatingHeaderOffset;
    context.headerView.frame = frame;
    [context updateVisibleOffsetForActiveHeaderOffset];
}


static void (*__ungrouped$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval);static void $_ungrouped$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation toInterfaceOrientation, NSTimeInterval duration) {

    MGTranscriptHeaderContext *context = [self headerContext];
    CGRect frame = context.headerView.frame;
    frame.origin.y = context.rotatingHeaderOffset;
    context.headerView.frame = frame;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

static void (*__ungrouped$CKTranscriptController$_showTranscriptHeaderView)(CKTranscriptController*, SEL);static void $_ungrouped$CKTranscriptController$_showTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    __ungrouped$CKTranscriptController$_showTranscriptHeaderView(self, _cmd);
    NSLog(@"-[<CKTranscriptController: %p> _showTranscriptHeaderView]", self);
    
    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
    if (header) {
        MGTranscriptHeaderContext *context = [self headerContext];
        context.headerView = header;


        



        

        
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button && header.hasMoreMessages && !button.superview) {
            [self.transcriptTable addSubview:button];

            
            CGPoint center = button.center;
            center.y = [CKTranscriptHeaderView defaultHeight] / 2;
            center.x = self.transcriptTable.frame.size.width / 2;
            button.center = center;
        }
        

        [header removeFromSuperview];
        [self.view addSubview:header];
        
        UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
        insets.top = header.frame.size.height;
        self.transcriptTable.scrollIndicatorInsets = insets;
    }
}

static void (*__ungrouped$CKTranscriptController$_hideTranscriptHeaderView)(CKTranscriptController*, SEL);static void $_ungrouped$CKTranscriptController$_hideTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _hideTranscriptHeaderView]", self);
    
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
    
    __ungrouped$CKTranscriptController$_hideTranscriptHeaderView(self, _cmd);
}


static void (*__ungrouped$CKTranscriptController$_updateTranscriptHeaderView)(CKTranscriptController*, SEL);static void $_ungrouped$CKTranscriptController$_updateTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _updateTranscriptHeaderView]", self);
    __ungrouped$CKTranscriptController$_updateTranscriptHeaderView(self, _cmd);
    




}


static void (*__ungrouped$CKTranscriptController$setEditing$animated$)(CKTranscriptController*, SEL, BOOL, BOOL);static void $_ungrouped$CKTranscriptController$setEditing$animated$(CKTranscriptController* self, SEL _cmd, BOOL editing, BOOL animated) {
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;

    
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
    
    NSLog(@"-[<CKTranscriptController: %p> setEditing:%d animated:%d]", self, editing, animated);
    __ungrouped$CKTranscriptController$setEditing$animated$(self, _cmd, editing, animated);
    


    if (!editing) {
        BOOL shouldShow = [context shouldAlwaysShowHeaderAtContentOffset:self.transcriptTable.contentOffset.y];
        [UIView animateWithDuration:0.5 animations:^{
            [self.view bringSubviewToFront:header];
            [context setHeaderVisible:shouldShow animated:NO];
        }];
        

            [context performSelector:@selector(endIgnoringContentOffsetChanges) withObject:nil afterDelay:0.5];

    }
    



}


static void (*__ungrouped$CKTranscriptController$reload$)(CKTranscriptController*, SEL, BOOL);static void $_ungrouped$CKTranscriptController$reload$(CKTranscriptController* self, SEL _cmd, BOOL reload) {
    __ungrouped$CKTranscriptController$reload$(self, _cmd, reload);
    NSLog(@"-[<CKTranscriptController: %p> reload:%d]", self, reload);
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
}


static void $_ungrouped$CKTranscriptController$scrollViewDidScroll$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv) {
    CGFloat newOffset = sv.contentOffset.y;
    MGTranscriptHeaderContext *context = [self headerContext];
    
    if (!sv.decelerating) {
        context.decelerationDirection = UIScrollViewDirectionNone;
    }
    
    [context updateHeaderOffsetForContentOffset:newOffset force:NO];
    
    context.lastKnownOffset = newOffset;
}



static void $_ungrouped$CKTranscriptController$scrollViewDidEndDecelerating$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv) {
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = UIScrollViewDirectionNone;
}



static void $_ungrouped$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv, CGPoint velocity, CGPoint * targetContentOffset) {
    CGFloat targetY = (*targetContentOffset).y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = (velocity.y > 0 ? UIScrollViewDirectionDown : UIScrollViewDirectionUp);
    context.deceleratingTargetOffset = targetY;
}


static __attribute__((constructor)) void _logosLocalInit() { NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; {Class $$CKContentEntryView = objc_getClass("CKContentEntryView"); MSHookMessageEx($$CKContentEntryView, @selector(textContentViewDidBeginEditing:), (IMP)&$_ungrouped$CKContentEntryView$textContentViewDidBeginEditing$, (IMP*)&__ungrouped$CKContentEntryView$textContentViewDidBeginEditing$);class_addMethod($$CKContentEntryView, @selector(textContentViewDidEndEditing:), (IMP)&$_ungrouped$CKContentEntryView$textContentViewDidEndEditing$, "v@:@");Class $$CKTranscriptHeaderView = objc_getClass("CKTranscriptHeaderView"); MSHookMessageEx($$CKTranscriptHeaderView, @selector(initWithFrame:isPhoneTranscript:displayLoadPrevious:isGroupMessage:), (IMP)&$_ungrouped$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$, (IMP*)&__ungrouped$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$);MSHookMessageEx($$CKTranscriptHeaderView, @selector(layoutSubviews), (IMP)&$_ungrouped$CKTranscriptHeaderView$layoutSubviews, (IMP*)&__ungrouped$CKTranscriptHeaderView$layoutSubviews);Class $$CKTranscriptTableView = objc_getClass("CKTranscriptTableView"); MSHookMessageEx($$CKTranscriptTableView, @selector(layoutSubviews), (IMP)&$_ungrouped$CKTranscriptTableView$layoutSubviews, (IMP*)&__ungrouped$CKTranscriptTableView$layoutSubviews);Class $$CKTranscriptController = objc_getClass("CKTranscriptController"); class_addMethod($$CKTranscriptController, @selector(headerContext), (IMP)&$_ungrouped$CKTranscriptController$headerContext, "@@:");class_addMethod($$CKTranscriptController, @selector(updateHeaderView), (IMP)&$_ungrouped$CKTranscriptController$updateHeaderView, "v@:");MSHookMessageEx($$CKTranscriptController, @selector(loadView), (IMP)&$_ungrouped$CKTranscriptController$loadView, (IMP*)&__ungrouped$CKTranscriptController$loadView);MSHookMessageEx($$CKTranscriptController, @selector(viewWillAppear:), (IMP)&$_ungrouped$CKTranscriptController$viewWillAppear$, (IMP*)&__ungrouped$CKTranscriptController$viewWillAppear$);MSHookMessageEx($$CKTranscriptController, @selector(viewDidAppear:), (IMP)&$_ungrouped$CKTranscriptController$viewDidAppear$, (IMP*)&__ungrouped$CKTranscriptController$viewDidAppear$);MSHookMessageEx($$CKTranscriptController, @selector(_setupTranscriptHeader), (IMP)&$_ungrouped$CKTranscriptController$_setupTranscriptHeader, (IMP*)&__ungrouped$CKTranscriptController$_setupTranscriptHeader);MSHookMessageEx($$CKTranscriptController, @selector(willRotateToInterfaceOrientation:duration:), (IMP)&$_ungrouped$CKTranscriptController$willRotateToInterfaceOrientation$duration$, (IMP*)&__ungrouped$CKTranscriptController$willRotateToInterfaceOrientation$duration$);MSHookMessageEx($$CKTranscriptController, @selector(didRotateFromInterfaceOrientation:), (IMP)&$_ungrouped$CKTranscriptController$didRotateFromInterfaceOrientation$, (IMP*)&__ungrouped$CKTranscriptController$didRotateFromInterfaceOrientation$);MSHookMessageEx($$CKTranscriptController, @selector(willAnimateRotationToInterfaceOrientation:duration:), (IMP)&$_ungrouped$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$, (IMP*)&__ungrouped$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$);MSHookMessageEx($$CKTranscriptController, @selector(_showTranscriptHeaderView), (IMP)&$_ungrouped$CKTranscriptController$_showTranscriptHeaderView, (IMP*)&__ungrouped$CKTranscriptController$_showTranscriptHeaderView);MSHookMessageEx($$CKTranscriptController, @selector(_hideTranscriptHeaderView), (IMP)&$_ungrouped$CKTranscriptController$_hideTranscriptHeaderView, (IMP*)&__ungrouped$CKTranscriptController$_hideTranscriptHeaderView);MSHookMessageEx($$CKTranscriptController, @selector(_updateTranscriptHeaderView), (IMP)&$_ungrouped$CKTranscriptController$_updateTranscriptHeaderView, (IMP*)&__ungrouped$CKTranscriptController$_updateTranscriptHeaderView);MSHookMessageEx($$CKTranscriptController, @selector(setEditing:animated:), (IMP)&$_ungrouped$CKTranscriptController$setEditing$animated$, (IMP*)&__ungrouped$CKTranscriptController$setEditing$animated$);MSHookMessageEx($$CKTranscriptController, @selector(reload:), (IMP)&$_ungrouped$CKTranscriptController$reload$, (IMP*)&__ungrouped$CKTranscriptController$reload$);class_addMethod($$CKTranscriptController, @selector(scrollViewDidScroll:), (IMP)&$_ungrouped$CKTranscriptController$scrollViewDidScroll$, "v@:@");class_addMethod($$CKTranscriptController, @selector(scrollViewDidEndDecelerating:), (IMP)&$_ungrouped$CKTranscriptController$scrollViewDidEndDecelerating$, "v@:@");class_addMethod($$CKTranscriptController, @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:), (IMP)&$_ungrouped$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$, "v@:@{CGPoint=ff}^{CGPoint=ff}");}  [pool drain]; }
