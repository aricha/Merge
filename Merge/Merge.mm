#line 1 "/Users/andrewr/Dropbox/Development/Merge/Merge/Merge.xm"



#import <ChatKit/CKTranscriptController.h>
#import <ChatKit/CKTranscriptHeaderView.h>
#import <substrate.h>
#import <QuartzCore/QuartzCore.h>
#import <ChatKit/CKTranscriptTableView.h>
#import <ChatKit/UIPlacardButton.h>
#import <objc/runtime.h>
#import "MGTranscriptHeaderContext.h"
#import <ChatKit/CKContentEntryView.h>
#import <ChatKit/CKAggregateConversation.h>
#import <ChatKit/CKSubConversation.h>
#import <ChatKit/CKEntity.h>
#import <ChatKit/_CKConversation.h>
#import <AddressBook/AddressBook.h>
#import <ChatKit/CKTranscriptBubbleData.h>
#import <ChatKit/CKServiceView.h>
#import <ChatKit/CKMessage.h>
#import <ChatKit/CKService.h>
#import <ChatKit/CKMessageStandaloneComposition.h>

#include <substrate.h>
@class CKServiceView; @class NSObject; @class CKEntity; @class CKConversationList; @class CKTranscriptTableView; @class CKTranscriptHeaderView; @class CKMadridService; @class CKTranscriptBubbleData; @class CKTranscriptController; @class CKService; @class CKAggregateConversation; @class SMSApplication; 
static NSUInteger (*_logos_orig$_ungrouped$CKEntity$addressHash)(CKEntity*, SEL); static NSUInteger _logos_method$_ungrouped$CKEntity$addressHash(CKEntity*, SEL); static void _logos_method$_ungrouped$CKServiceView$updateTitleLabel(CKServiceView*, SEL); static CKService * _logos_method$_ungrouped$CKServiceView$service(CKServiceView*, SEL); static UILabel * _logos_method$_ungrouped$CKServiceView$textLabel(CKServiceView*, SEL); static void (*_logos_orig$_ungrouped$CKServiceView$setService$)(CKServiceView*, SEL, CKService *); static void _logos_method$_ungrouped$CKServiceView$setService$(CKServiceView*, SEL, CKService *); static CKEntity * _logos_method$_ungrouped$CKServiceView$entity(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$setEntity$(CKServiceView*, SEL, CKEntity *); static void (*_logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$)(CKTranscriptController*, SEL, id, id, NSIndexPath *); static void _logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(CKTranscriptController*, SEL, id, id, NSIndexPath *); static BOOL _logos_method$_ungrouped$CKTranscriptBubbleData$sendingMessage(CKTranscriptBubbleData*, SEL); static void _logos_method$_ungrouped$CKTranscriptBubbleData$setSendingMessage$(CKTranscriptBubbleData*, SEL, BOOL); static NSMutableArray * _logos_method$_ungrouped$CKTranscriptBubbleData$_bubbleDataArray(CKTranscriptBubbleData*, SEL); static int (*_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$)(CKTranscriptBubbleData*, SEL, CKMessage *); static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(CKTranscriptBubbleData*, SEL, CKMessage *); static void (*_logos_orig$_ungrouped$NSObject$doesNotRecognizeSelector$)(NSObject*, SEL, SEL); static void _logos_method$_ungrouped$NSObject$doesNotRecognizeSelector$(NSObject*, SEL, SEL); static CKAggregateConversation * (*_logos_orig$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$)(CKConversationList*, SEL, NSArray *, BOOL); static CKAggregateConversation * _logos_method$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$(CKConversationList*, SEL, NSArray *, BOOL); static id (*_logos_orig$_ungrouped$CKConversationList$existingConversationForAddresses$)(CKConversationList*, SEL, NSArray *); static id _logos_method$_ungrouped$CKConversationList$existingConversationForAddresses$(CKConversationList*, SEL, NSArray *); static void _logos_method$_ungrouped$CKAggregateConversation$setDidAddMessageBlock$(CKAggregateConversation*, SEL, void (^)(CKMessage *message, CKAggregateConversation *conversation)); static void (^_logos_method$_ungrouped$CKAggregateConversation$didAddMessageBlock(CKAggregateConversation*, SEL))(CKMessage *, CKAggregateConversation *); static void _logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$(CKAggregateConversation*, SEL, CKEntity *); static CKEntity * _logos_method$_ungrouped$CKAggregateConversation$selectedRecipient(CKAggregateConversation*, SEL); static CKMessage * _logos_method$_ungrouped$CKAggregateConversation$pendingMessage(CKAggregateConversation*, SEL); static void _logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$(CKAggregateConversation*, SEL, CKMessage *); static id (*_logos_orig$_ungrouped$CKAggregateConversation$_subConversationForService$create$)(CKAggregateConversation*, SEL, id, BOOL); static id _logos_method$_ungrouped$CKAggregateConversation$_subConversationForService$create$(CKAggregateConversation*, SEL, id, BOOL); static id (*_logos_orig$_ungrouped$CKAggregateConversation$_bestExistingConversation)(CKAggregateConversation*, SEL); static id _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversation(CKAggregateConversation*, SEL); static CKSubConversation * _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversationWithService$(CKAggregateConversation*, SEL, CKService *); static BOOL (*_logos_orig$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$)(CKAggregateConversation*, SEL, CKSubConversation *); static BOOL _logos_method$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$(CKAggregateConversation*, SEL, CKSubConversation *); static int (*_logos_orig$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$)(CKAggregateConversation*, SEL, CKMessage *, BOOL); static int _logos_method$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$(CKAggregateConversation*, SEL, CKMessage *, BOOL); static id (*_logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$)(CKMadridService*, SEL, id, CKSubConversation *); static id _logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(CKMadridService*, SEL, id, CKSubConversation *); static void (*_logos_orig$_ungrouped$SMSApplication$handleURL$)(SMSApplication*, SEL, NSURL *); static void _logos_method$_ungrouped$SMSApplication$handleURL$(SMSApplication*, SEL, NSURL *); 
static Class _logos_static_class$CKServiceView; static Class _logos_static_class$CKService; static Class _logos_static_class$CKEntity; 
#line 24 "/Users/andrewr/Dropbox/Development/Merge/Merge/Merge.xm"
static id (*_logos_orig$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$)(CKTranscriptHeaderView*, SEL, CGRect, BOOL, BOOL, BOOL); static id _logos_method$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(CKTranscriptHeaderView*, SEL, CGRect, BOOL, BOOL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptHeaderView$layoutSubviews)(CKTranscriptHeaderView*, SEL); static void _logos_method$FloatingHeader$CKTranscriptHeaderView$layoutSubviews(CKTranscriptHeaderView*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews)(CKTranscriptTableView*, SEL); static void _logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews(CKTranscriptTableView*, SEL); static MGTranscriptHeaderContext * _logos_method$FloatingHeader$CKTranscriptController$headerContext(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$updateTranscriptHeaderInset(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$updateHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$loadView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$loadView(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$didSwipeUpOnNavBar$(CKTranscriptController*, SEL, UISwipeGestureRecognizer *); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewWillUnload)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$viewWillUnload(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewWillAppear$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$viewWillAppear$(CKTranscriptController*, SEL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewDidAppear$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$viewDidAppear$(CKTranscriptController*, SEL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_setupTranscriptHeader)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_setupTranscriptHeader(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void _logos_method$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void (*_logos_orig$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$)(CKTranscriptController*, SEL, UIInterfaceOrientation); static void _logos_method$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$(CKTranscriptController*, SEL, UIInterfaceOrientation); static void (*_logos_orig$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void _logos_method$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$setEditing$animated$)(CKTranscriptController*, SEL, BOOL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$(CKTranscriptController*, SEL, BOOL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$reload$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$reload$(CKTranscriptController*, SEL, BOOL); static UIView * _logos_method$FloatingHeader$CKTranscriptController$backPlacardView(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidScroll$(CKTranscriptController*, SEL, UIScrollView *); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidEndDecelerating$(CKTranscriptController*, SEL, UIScrollView *); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$(CKTranscriptController*, SEL, UIScrollView *, CGPoint, CGPoint *); static void _logos_method$FloatingHeader$CKTranscriptController$keyboardFrameWillChange$(CKTranscriptController*, SEL, NSNotification *); static BOOL _logos_method$FloatingHeader$CKTranscriptController$keyboardIsReallyOnScreen(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_resetTranscriptInsets)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_resetTranscriptInsets(CKTranscriptController*, SEL); 



static id _logos_method$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(CKTranscriptHeaderView* self, SEL _cmd, CGRect frame, BOOL transcript, BOOL previous, BOOL message) {
    self = _logos_orig$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(self, _cmd, frame, transcript, previous, message);
    
    self.backgroundColor = [CKTranscriptController tableColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    self.clipsToBounds = NO;
    
    if (previous) {
        UIPlacardButton *button = MSHookIvar<id>(self, "_loadMoreButton");
        if (button) {
            [button removeFromSuperview];
        }
        
        CGRect bounds = self.frame;
        bounds.size.height = [CKTranscriptHeaderView defaultHeight];
        self.frame = bounds;
    }
    
    return self;
}










static void _logos_method$FloatingHeader$CKTranscriptHeaderView$layoutSubviews(CKTranscriptHeaderView* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptHeaderView$layoutSubviews(self, _cmd);
    
    CGRect bounds = self.frame;
    bounds.size.height = [CKTranscriptHeaderView defaultHeight];
    self.frame = bounds;
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}



static NSString *const CKTranscriptTableViewLayoutBlockKey = @"layoutBlock";




static void _logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews(CKTranscriptTableView* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews(self, _cmd);
    
    void (^updateBlock)(CKTranscriptTableView *) = objc_getAssociatedObject(self, CKTranscriptTableViewLayoutBlockKey);
    if (updateBlock)
        updateBlock(self);
}



@interface CKTranscriptController ()
- (void)updateHeaderView;
- (MGTranscriptHeaderContext *)headerContext;
- (void)updateTranscriptHeaderInset;
- (UIView *)backPlacardView;
@end





static MGTranscriptHeaderContext * _logos_method$FloatingHeader$CKTranscriptController$headerContext(CKTranscriptController* self, SEL _cmd) {
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



static void _logos_method$FloatingHeader$CKTranscriptController$updateTranscriptHeaderInset(CKTranscriptController* self, SEL _cmd) {
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    
    UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
    insets.top = (!header || header.hidden ? 0 : header.frame.size.height);
    self.transcriptTable.scrollIndicatorInsets = insets;
}



static void _logos_method$FloatingHeader$CKTranscriptController$updateHeaderView(CKTranscriptController* self, SEL _cmd) {
    CGFloat offset = self.transcriptTable.contentOffset.y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    CGFloat relativeHeaderOffset = header.frame.origin.y + offset;
    CGFloat headerHeight = header.frame.size.height;
    
    header.layer.shadowOpacity = (self.editing && offset <= headerHeight ? 0.0 : MIN((relativeHeaderOffset / headerHeight), 1.0));
    
    [self updateTranscriptHeaderInset];
}


static void _logos_method$FloatingHeader$CKTranscriptController$loadView(CKTranscriptController* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptController$loadView(self, _cmd);
    
    __block CKTranscriptController *blockSelf = self;
    void (^updateBlock)(CKTranscriptTableView *) = ^(CKTranscriptTableView *tableView) {
        [blockSelf updateHeaderView];
    };
    objc_setAssociatedObject(self.transcriptTable, CKTranscriptTableViewLayoutBlockKey, updateBlock, OBJC_ASSOCIATION_COPY);
    
    [[self headerContext] setScrollView:self.transcriptTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}
















static void _logos_method$FloatingHeader$CKTranscriptController$didSwipeUpOnNavBar$(CKTranscriptController* self, SEL _cmd, UISwipeGestureRecognizer * gesture) {
    NSLog(@"-[<CKTranscriptController: %p> didSwipeUpOnNavBar:%@]", self, gesture);
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


static void _logos_method$FloatingHeader$CKTranscriptController$viewWillUnload(CKTranscriptController* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptController$viewWillUnload(self, _cmd);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}


static void _logos_method$FloatingHeader$CKTranscriptController$viewWillAppear$(CKTranscriptController* self, SEL _cmd, BOOL animated) {
    _logos_orig$FloatingHeader$CKTranscriptController$viewWillAppear$(self, _cmd, animated);
    

    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    


}


static void _logos_method$FloatingHeader$CKTranscriptController$viewDidAppear$(CKTranscriptController* self, SEL _cmd, BOOL animated) {
    _logos_orig$FloatingHeader$CKTranscriptController$viewDidAppear$(self, _cmd, animated);
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    DLog(@"viewDidAppear, visibleOffset: %f, contentOffset: %f", [[self headerContext] visibleOffset], self.transcriptTable.contentOffset.y);
}

static void _logos_method$FloatingHeader$CKTranscriptController$_setupTranscriptHeader(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _setupTranscriptHeader]", self);
    _logos_orig$FloatingHeader$CKTranscriptController$_setupTranscriptHeader(self, _cmd);
}


static void _logos_method$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation toInterfaceOrientation, NSTimeInterval duration) {
    MGTranscriptHeaderContext *context = [self headerContext];
    [context beginIgnoringContentOffsetChanges];
    context.rotatingHeaderOffset = context.headerOffset;
    
    _logos_orig$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$(self, _cmd, toInterfaceOrientation, duration);
}


static void _logos_method$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation fromInterfaceOrientation) {
    _logos_orig$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$(self, _cmd, fromInterfaceOrientation);
    [[self headerContext] endIgnoringContentOffsetChanges];
    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}


static void _logos_method$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$(CKTranscriptController* self, SEL _cmd, UIInterfaceOrientation toInterfaceOrientation, NSTimeInterval duration) {

    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

static void _logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(self, _cmd);
    NSLog(@"-[<CKTranscriptController: %p> _showTranscriptHeaderView]", self);
    
    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
    if (header) {
        MGTranscriptHeaderContext *context = [self headerContext];
        context.headerView = header;
        



        CGFloat tableWidth = self.transcriptTable.frame.size.width;
        CGSize tableHeaderSize = [header sizeThatFits:CGSizeMake(tableWidth, 2*[CKTranscriptHeaderView defaultHeight])];
        CGRect tableHeaderFrame = (CGRect){CGPointZero, tableHeaderSize};
        
        UIView *tableHeaderView = [[[UIView alloc] initWithFrame:tableHeaderFrame] autorelease];
        tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button && header.hasMoreMessages) {


            
            [tableHeaderView addSubview:button];
            
            CGPoint center = button.center;
            center.y = [CKTranscriptHeaderView defaultHeight] * (3 / 2);
            center.x = self.transcriptTable.frame.size.width / 2;
            button.center = center;
        }
        
        context.tableHeaderView = tableHeaderView;
        
        self.transcriptTable.tableHeaderView = tableHeaderView;
        [header removeFromSuperview];
        [self.view addSubview:header];
        
        [self updateTranscriptHeaderInset];
    }
}

static void _logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _hideTranscriptHeaderView]", self);
    
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    if (header) {
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button) {
            [button removeFromSuperview];
        }
    }
    
    [header removeFromSuperview];
    [self headerContext].headerView = nil;
    [self headerContext].tableHeaderView = nil;
    
    [self updateTranscriptHeaderInset];
    
    _logos_orig$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView(self, _cmd);
}


static void _logos_method$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _updateTranscriptHeaderView]", self);
    _logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView(self, _cmd);
    
    [self.view addSubview:[self headerContext].headerView];
    self.transcriptTable.tableHeaderView = [self headerContext].tableHeaderView;
}


static void _logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$(CKTranscriptController* self, SEL _cmd, BOOL editing, BOOL animated) {
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    BOOL prevEditing = [self.transcriptTable isEditing];
    
    NSLog(@"-[<CKTranscriptController: %p> setEditing:%d animated:%d]", self, editing, animated);
    _logos_orig$FloatingHeader$CKTranscriptController$setEditing$animated$(self, _cmd, editing, animated);
    
    if (header) {
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button) {
            button.hidden = editing;
        }
        context.tableHeaderView.hidden = editing;
    }
    
    if (editing) {
        if (!prevEditing) {
            [context beginIgnoringContentOffsetChanges];
        }
        
        [context setHeaderVisible:NO animated:YES force:YES completion:^(BOOL finished) {
            header.hidden = YES;
        }];
    }
    else {
        if (prevEditing) {
            [context endIgnoringContentOffsetChanges];
        }
        
        header.hidden = NO;
        BOOL shouldShow = [context shouldAlwaysShowHeaderAtContentOffset:self.transcriptTable.contentOffset.y];
        [context setHeaderVisible:shouldShow animated:YES];
    }
    



}


static void _logos_method$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews(CKTranscriptController* self, SEL _cmd) {
    NSLog(@"-[<CKTranscriptController: %p> _updateBackPlacardSubviews]", self);
    _logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews(self, _cmd);
    
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    [[self backPlacardView] bringSubviewToFront:header];
}


static void _logos_method$FloatingHeader$CKTranscriptController$reload$(CKTranscriptController* self, SEL _cmd, BOOL reload) {
    _logos_orig$FloatingHeader$CKTranscriptController$reload$(self, _cmd, reload);
    NSLog(@"-[<CKTranscriptController: %p> reload:%d]", self, reload);
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
}



static UIView * _logos_method$FloatingHeader$CKTranscriptController$backPlacardView(CKTranscriptController* self, SEL _cmd) {
    UIView *view = MSHookIvar<id>(self, "_backPlacard");
    
    
    return (view == NULL ? nil : view);
}


static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidScroll$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv) {
    CGFloat newOffset = sv.contentOffset.y;
    MGTranscriptHeaderContext *context = [self headerContext];
    
    if (!sv.decelerating) {
        context.decelerationDirection = UIScrollViewDirectionNone;
    }
    
    [context updateHeaderOffsetForContentOffset:newOffset force:NO];
    
    context.lastKnownOffset = newOffset;
}



static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidEndDecelerating$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv) {
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = UIScrollViewDirectionNone;
}



static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$(CKTranscriptController* self, SEL _cmd, UIScrollView * sv, CGPoint velocity, CGPoint * targetContentOffset) {
    CGFloat targetY = (*targetContentOffset).y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    context.decelerationDirection = (velocity.y > 0 ? UIScrollViewDirectionDown : UIScrollViewDirectionUp);
    context.deceleratingTargetOffset = targetY;
}



static void _logos_method$FloatingHeader$CKTranscriptController$keyboardFrameWillChange$(CKTranscriptController* self, SEL _cmd, NSNotification * note) {
    CGRect unconvertedKBFrame = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect kbFrame = [self.view convertRect:unconvertedKBFrame fromView:nil];
        
    CGFloat kbHeight = kbFrame.size.height - [self _accessoryViewHeight];
    BOOL keyboardVisible = (kbHeight > 0);
    
    [self headerContext].keyboardVisible = keyboardVisible;
}



static BOOL _logos_method$FloatingHeader$CKTranscriptController$keyboardIsReallyOnScreen(CKTranscriptController* self, SEL _cmd) {
    CGFloat accessoryHeight = [self _accessoryViewHeight];
    CGFloat kbHeight = [self _distanceFromBottomOfScreenToTopEdgeOfKeyboard];
    
    return (kbHeight - accessoryHeight > 0);
}


static void _logos_method$FloatingHeader$CKTranscriptController$_resetTranscriptInsets(CKTranscriptController* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptController$_resetTranscriptInsets(self, _cmd);
    
    [self updateTranscriptHeaderInset];
}




@interface CKTranscriptBubbleData ()


@property (nonatomic) BOOL sendingMessage;
-(NSMutableArray *)_bubbleDataArray;

@end

@interface CKAggregateConversation ()

@property (nonatomic, retain) CKEntity *selectedRecipient;
@property (nonatomic, copy) void (^didAddMessageBlock)(CKMessage *message, CKAggregateConversation *conversation);
@property (nonatomic, retain) CKMessage * pendingMessage;

-(CKSubConversation *)_bestExistingConversationWithService:(CKService *)service;

@end




static NSUInteger _logos_method$_ungrouped$CKEntity$addressHash(CKEntity* self, SEL _cmd) {
    NSUInteger hash = MSHookIvar<NSUInteger>(self, "_addressHash");
    if (hash == 0) {
        ABRecordRef record = self.abRecord;
        if (record != NULL) {
            ABRecordID recordID = ABRecordGetRecordID(record);
            hash = (NSUInteger)recordID;
        }
        else {
            hash = _logos_orig$_ungrouped$CKEntity$addressHash(self, _cmd);
        }

    }
    return hash;
}





















@interface CKServiceView ()

- (void)updateTitleLabel;
- (CKService *)service;
- (UILabel *)textLabel;
- (CKEntity *)entity;
- (void)setEntity:(CKEntity *)entity;

@end






static void _logos_method$_ungrouped$CKServiceView$updateTitleLabel(CKServiceView* self, SEL _cmd) {
    NSMutableString *labelText = [NSMutableString string];
    CKEntity *entity = [self entity];
    CKService *service = [self service];
    









    
    if (service) {
        [labelText appendString:[service displayName]];
    }
    if (entity) {
        if (service) {
            [labelText appendString:@" with "];
        }
        [labelText appendString:entity.normalizedRawAddress];
    }
    
    if (![labelText isEqualToString:[[self textLabel] text]] && labelText.length > 0) {
        [[self textLabel] setText:[NSString stringWithString:labelText]];
        [self setNeedsLayout];
    }
}



static CKService * _logos_method$_ungrouped$CKServiceView$service(CKServiceView* self, SEL _cmd) {
    CKService *service = MSHookIvar<id>(self, "_service");
    return (service ? service : nil);
}



static UILabel * _logos_method$_ungrouped$CKServiceView$textLabel(CKServiceView* self, SEL _cmd) {
    UILabel *label = MSHookIvar<id>(self, "_label");
    return (label ? label : nil);
}


static void _logos_method$_ungrouped$CKServiceView$setService$(CKServiceView* self, SEL _cmd, CKService * service) {
    if ([self service] != service) {



        if (!service || [service isKindOfClass:_logos_static_class$CKService]) {
            _logos_orig$_ungrouped$CKServiceView$setService$(self, _cmd, service);
        }
        else if ([service isKindOfClass:_logos_static_class$CKEntity]) {
            [self setEntity:(CKEntity *)service];
        }
        
        [self updateTitleLabel];
    }
}
static NSString *const MGAddressViewEntityKey = @"MGAddressViewEntityKey";



static CKEntity * _logos_method$_ungrouped$CKServiceView$entity(CKServiceView* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGAddressViewEntityKey);
}



static void _logos_method$_ungrouped$CKServiceView$setEntity$(CKServiceView* self, SEL _cmd, CKEntity * entity) {
    objc_setAssociatedObject(self, MGAddressViewEntityKey, entity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateTitleLabel];
}



extern NSString *const CKBubbleDataMessage;

#define FLAG_NEW_RECIPIENT (1 << 5)






















static void _logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(CKTranscriptController* self, SEL _cmd, id view, id cell, NSIndexPath * indexPath) {
    _logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(self, _cmd, view, cell, indexPath);
    if ([cell isKindOfClass:_logos_static_class$CKServiceView]) {
        CKTranscriptBubbleData *data = [self bubbleData];
        CKMessage *message = nil;
        
        NSUInteger index = indexPath.row + 1;
        NSUInteger count = [data count];
        while (index < count) {
            message = [[data bubbleDataForIndex:index] objectForKey:CKBubbleDataMessage];
            if (message) {
                break;
            }
            index++;
        }
        

        CKEntity *entity = [message.conversation recipient];
        if (!entity) {
            NSLog(@"error: could not find entity for CKServiceView at indexPath %@", indexPath);
        }
        
        [(CKServiceView *)cell setEntity:entity];

    }
}



































static NSString *const MGBubbleDataSendingMessageKey = @"MGBubbleDataSendingMessageKey";



static BOOL _logos_method$_ungrouped$CKTranscriptBubbleData$sendingMessage(CKTranscriptBubbleData* self, SEL _cmd) {
    NSNumber *sending = objc_getAssociatedObject(self, MGBubbleDataSendingMessageKey);\
    if (sending)
        return [sending boolValue];
    else
        return NO;
}



static void _logos_method$_ungrouped$CKTranscriptBubbleData$setSendingMessage$(CKTranscriptBubbleData* self, SEL _cmd, BOOL sendingMessage) {
    NSNumber *sending = [NSNumber numberWithBool:sendingMessage];
    objc_setAssociatedObject(self, MGBubbleDataSendingMessageKey, sending, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}















static NSMutableArray * _logos_method$_ungrouped$CKTranscriptBubbleData$_bubbleDataArray(CKTranscriptBubbleData* self, SEL _cmd) {
    NSMutableArray *array = MSHookIvar<id>(self, "_bubbleDataArray");
    return (array ? array : nil);
}


static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(CKTranscriptBubbleData* self, SEL _cmd, CKMessage * message) {
    NSInteger response = _logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(self, _cmd, message);
    if (response == NSNotFound && [message conversation]) { 
        NSUInteger index = [self indexForMessage:message];
        if (index == NSNotFound) {
            index = [self count];
        }
        CKMessage *prevMessage = nil;
        while (index > 0) {
            prevMessage = [self messageAtIndex:index-1];
            if (prevMessage) {
                break;
            }
            index--;
        }
        

        
        if ([prevMessage conversation]) {
            BOOL sameAddress = ([[message.conversation recipients] isEqual:[prevMessage.conversation recipients]]);
            
            if (!sameAddress) {
                response = [self _appendService:message.service];
            }
        }
    }
    return response;
}






static void _logos_method$_ungrouped$NSObject$doesNotRecognizeSelector$(NSObject* self, SEL _cmd, SEL sel) {
    LOG_BACKTRACE;
    _logos_orig$_ungrouped$NSObject$doesNotRecognizeSelector$(self, _cmd, sel);
}























static CKAggregateConversation * _logos_method$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$(CKConversationList* self, SEL _cmd, NSArray * recipients, BOOL create) {
    CKAggregateConversation *conversation = _logos_orig$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$(self, _cmd, recipients, create);

    
    if (recipients.count == 1) {
        conversation.selectedRecipient = [recipients objectAtIndex:0];
    }
    
    return conversation;
}


static id _logos_method$_ungrouped$CKConversationList$existingConversationForAddresses$(CKConversationList* self, SEL _cmd, NSArray * addresses) {
    CKSubConversation *conversation = _logos_orig$_ungrouped$CKConversationList$existingConversationForAddresses$(self, _cmd, addresses);
    if (conversation && conversation.recipients.count == 1) {
        NSLog(@"conversation: %@, aggregate: %@", conversation, conversation.aggregateConversation);
        conversation.aggregateConversation.selectedRecipient = [conversation.recipients objectAtIndex:0];
    }
    return conversation;
}












static NSString *const MGDidAddMessageBlockKey = @"MGDidAddMessageBlockKey";
static NSString *const MGSelectedRecipientKey = @"MGSelectedRecipientKey";



static void _logos_method$_ungrouped$CKAggregateConversation$setDidAddMessageBlock$(CKAggregateConversation* self, SEL _cmd, void (^block)(CKMessage *message, CKAggregateConversation *conversation)) {
    objc_setAssociatedObject(self, MGDidAddMessageBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



static void (^_logos_method$_ungrouped$CKAggregateConversation$didAddMessageBlock(CKAggregateConversation* self, SEL _cmd))(CKMessage *, CKAggregateConversation *) {
    return objc_getAssociatedObject(self, MGDidAddMessageBlockKey);
}



static void _logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$(CKAggregateConversation* self, SEL _cmd, CKEntity * recipient) {


    

    
    objc_setAssociatedObject(self, MGSelectedRecipientKey, recipient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    



}



static CKEntity * _logos_method$_ungrouped$CKAggregateConversation$selectedRecipient(CKAggregateConversation* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGSelectedRecipientKey);
}

static NSString *const MGPendingMessageKey = @"MGPendingMessageKey";



static CKMessage * _logos_method$_ungrouped$CKAggregateConversation$pendingMessage(CKAggregateConversation* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGPendingMessageKey);
}



static void _logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$(CKAggregateConversation* self, SEL _cmd, CKMessage * pendingMessage) {
    objc_setAssociatedObject(self, MGPendingMessageKey, pendingMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


static id _logos_method$_ungrouped$CKAggregateConversation$_subConversationForService$create$(CKAggregateConversation* self, SEL _cmd, id service, BOOL create) {
    CKSubConversation *conversation = [self _bestExistingConversationWithService:service];
    if (!conversation) {
        conversation = _logos_orig$_ungrouped$CKAggregateConversation$_subConversationForService$create$(self, _cmd, service, create);
    }

    return conversation;
}


static id _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversation(CKAggregateConversation* self, SEL _cmd) {
    CKSubConversation *conversation = [self _bestExistingConversationWithService:nil];
    if (!conversation) {
        conversation = _logos_orig$_ungrouped$CKAggregateConversation$_bestExistingConversation(self, _cmd);
    }

    return conversation;
}



static CKSubConversation * _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversationWithService$(CKAggregateConversation* self, SEL _cmd, CKService * service) {
    BOOL isCombinedConversation = NO;
    NSString *prevGroupID = nil;
    for (CKSubConversation *conversation in self.subConversations) {
        if (!prevGroupID) {
            prevGroupID = conversation.groupID;
        }
        else if (![prevGroupID isEqualToString:conversation.groupID] && conversation.recipients.count <= 1) {
            isCombinedConversation = YES;
            break;
        }
    }
    
    if (isCombinedConversation) {
        CKEntity *selectedRecipient = self.selectedRecipient;
        CKSubConversation *mostRecentConversation = nil;
        CKSubConversation *selectedConversation = nil;
        long long largestSequenceNum = 0;
        for (CKSubConversation *conversation in self.subConversations) {
            CKMessage *latestMessage = conversation.latestMessage;
            NSNumber *sequenceNum = latestMessage.sequenceNumber;
            
            if (service && ![conversation.service isEqual:service]) {
                

                continue;
            }
            
            if ([[conversation recipients] containsObject:selectedRecipient]) {

                selectedConversation = conversation;
                break;
            }
            
            if (!sequenceNum) {
                

                
                if (!selectedConversation) {
                    selectedConversation = conversation;
                }
                else {
                    NSArray *pendingMessages = conversation.pendingMessages;
                    NSLog(@"ERROR: found multiple outgoing messages for aggregate %@! They are: %@ and %@", self, [selectedConversation pendingMessages], pendingMessages);
                    break;
                }
            }
            else if ([sequenceNum longLongValue] > largestSequenceNum) {
                largestSequenceNum = [sequenceNum longLongValue];
                mostRecentConversation = conversation;
            }
        }
        

        
        return (selectedConversation ? selectedConversation : mostRecentConversation);
    }
    else {
        return nil;
    }
}


static BOOL _logos_method$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$(CKAggregateConversation* self, SEL _cmd, CKSubConversation * conversation) {
    BOOL isAggregatable = ([conversation recipientsHash] == [self recipientsHash]);
    
    return isAggregatable;
}


static int _logos_method$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$(CKAggregateConversation* self, SEL _cmd, CKMessage * message, BOOL count) {
    BOOL containsMessage = NO;
    for (CKSubConversation *conversation in self.subConversations) {
        if ([conversation containsMessage:message]) {
            containsMessage = YES;
            break;
        }
    }
    
    if (containsMessage) {
        return 0;
    }
    


    int result = _logos_orig$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$(self, _cmd, message, count);
    
    if ([message isOutgoing] && [message conversation].recipients.count == 1) {
        self.selectedRecipient = [[message conversation].recipients objectAtIndex:0];
        
        if ([self didAddMessageBlock]) {
            [self didAddMessageBlock](message, self);
        }
    }

    return result;
}





















static id _logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(CKMadridService* self, SEL _cmd, id composition, CKSubConversation * conversation) {
    NSLog(@"-[<CKMadridService: %p> newMessageWithComposition:%@ forConversation:%@]", self, composition, conversation);
    CKMessage *message = _logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(self, _cmd, composition, conversation);
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}






static void _logos_method$_ungrouped$SMSApplication$handleURL$(SMSApplication* self, SEL _cmd, NSURL * url) {
    NSLog(@"-[<SMSApplication: %p> handleURL:%@]", self, url);
    _logos_orig$_ungrouped$SMSApplication$handleURL$(self, _cmd, url);
}



static __attribute__((constructor)) void _logosLocalCtor_72b4bc74() {
    {{Class _logos_class$_ungrouped$CKEntity = objc_getClass("CKEntity"); MSHookMessageEx(_logos_class$_ungrouped$CKEntity, @selector(addressHash), (IMP)&_logos_method$_ungrouped$CKEntity$addressHash, (IMP*)&_logos_orig$_ungrouped$CKEntity$addressHash);Class _logos_class$_ungrouped$CKServiceView = objc_getClass("CKServiceView"); { const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(updateTitleLabel), (IMP)&_logos_method$_ungrouped$CKServiceView$updateTitleLabel, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(service), (IMP)&_logos_method$_ungrouped$CKServiceView$service, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(textLabel), (IMP)&_logos_method$_ungrouped$CKServiceView$textLabel, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKServiceView, @selector(setService:), (IMP)&_logos_method$_ungrouped$CKServiceView$setService$, (IMP*)&_logos_orig$_ungrouped$CKServiceView$setService$);{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(entity), (IMP)&_logos_method$_ungrouped$CKServiceView$entity, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(setEntity:), (IMP)&_logos_method$_ungrouped$CKServiceView$setEntity$, _typeEncoding); }Class _logos_class$_ungrouped$CKTranscriptController = objc_getClass("CKTranscriptController"); MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptController, @selector(tableView:willDisplayCell:forRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$);Class _logos_class$_ungrouped$CKTranscriptBubbleData = objc_getClass("CKTranscriptBubbleData"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(sendingMessage), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$sendingMessage, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(setSendingMessage:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$setSendingMessage$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(_bubbleDataArray), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$_bubbleDataArray, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(_appendServiceForMessageIfNeeded:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$);Class _logos_class$_ungrouped$NSObject = objc_getClass("NSObject"); MSHookMessageEx(_logos_class$_ungrouped$NSObject, @selector(doesNotRecognizeSelector:), (IMP)&_logos_method$_ungrouped$NSObject$doesNotRecognizeSelector$, (IMP*)&_logos_orig$_ungrouped$NSObject$doesNotRecognizeSelector$);Class _logos_class$_ungrouped$CKConversationList = objc_getClass("CKConversationList"); MSHookMessageEx(_logos_class$_ungrouped$CKConversationList, @selector(aggregateConversationForRecipients:create:), (IMP)&_logos_method$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$, (IMP*)&_logos_orig$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$);MSHookMessageEx(_logos_class$_ungrouped$CKConversationList, @selector(existingConversationForAddresses:), (IMP)&_logos_method$_ungrouped$CKConversationList$existingConversationForAddresses$, (IMP*)&_logos_orig$_ungrouped$CKConversationList$existingConversationForAddresses$);Class _logos_class$_ungrouped$CKAggregateConversation = objc_getClass("CKAggregateConversation"); { const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(setDidAddMessageBlock:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$setDidAddMessageBlock$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(didAddMessageBlock), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$didAddMessageBlock, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(setSelectedRecipient:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(selectedRecipient), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$selectedRecipient, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(pendingMessage), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$pendingMessage, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(setPendingMessage:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(_subConversationForService:create:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_subConversationForService$create$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$_subConversationForService$create$);MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(_bestExistingConversation), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversation, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$_bestExistingConversation);{ const char *_typeEncoding = "@@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(_bestExistingConversationWithService:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversationWithService$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(isAggregatableWithConversation:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$);MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(addMessage:incrementUnreadCount:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$);Class _logos_class$_ungrouped$CKMadridService = objc_getClass("CKMadridService"); MSHookMessageEx(_logos_class$_ungrouped$CKMadridService, @selector(newMessageWithComposition:forConversation:), (IMP)&_logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$, (IMP*)&_logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$);Class _logos_class$_ungrouped$SMSApplication = objc_getClass("SMSApplication"); MSHookMessageEx(_logos_class$_ungrouped$SMSApplication, @selector(handleURL:), (IMP)&_logos_method$_ungrouped$SMSApplication$handleURL$, (IMP*)&_logos_orig$_ungrouped$SMSApplication$handleURL$);}{_logos_static_class$CKServiceView = objc_getClass("CKServiceView"); _logos_static_class$CKService = objc_getClass("CKService"); _logos_static_class$CKEntity = objc_getClass("CKEntity"); }}
    if ([MGTranscriptHeaderContext shouldOverrideHeader]) {
        {Class _logos_class$FloatingHeader$CKTranscriptHeaderView = objc_getClass("CKTranscriptHeaderView"); MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptHeaderView, @selector(initWithFrame:isPhoneTranscript:displayLoadPrevious:isGroupMessage:), (IMP)&_logos_method$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptHeaderView, @selector(layoutSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptHeaderView$layoutSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptHeaderView$layoutSubviews);Class _logos_class$FloatingHeader$CKTranscriptTableView = objc_getClass("CKTranscriptTableView"); MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptTableView, @selector(layoutSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews);Class _logos_class$FloatingHeader$CKTranscriptController = objc_getClass("CKTranscriptController"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(headerContext), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$headerContext, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(updateTranscriptHeaderInset), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$updateTranscriptHeaderInset, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(updateHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$updateHeaderView, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(loadView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$loadView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$loadView);{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(didSwipeUpOnNavBar:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$didSwipeUpOnNavBar$, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewWillUnload), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewWillUnload, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewWillUnload);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewWillAppear:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewWillAppear$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewWillAppear$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewDidAppear:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewDidAppear$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewDidAppear$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_setupTranscriptHeader), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_setupTranscriptHeader, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_setupTranscriptHeader);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(willRotateToInterfaceOrientation:duration:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(didRotateFromInterfaceOrientation:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(willAnimateRotationToInterfaceOrientation:duration:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_showTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_hideTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_updateTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(setEditing:animated:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$setEditing$animated$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_updateBackPlacardSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(reload:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$reload$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$reload$);{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(backPlacardView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$backPlacardView, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewDidScroll:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewDidScroll$, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewDidEndDecelerating:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewDidEndDecelerating$, _typeEncoding); }{ const char *_typeEncoding = "v@:@{CGPoint=ff}^{CGPoint=ff}"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(keyboardFrameWillChange:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$keyboardFrameWillChange$, _typeEncoding); }{ const char *_typeEncoding = "c@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(keyboardIsReallyOnScreen), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$keyboardIsReallyOnScreen, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_resetTranscriptInsets), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_resetTranscriptInsets, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_resetTranscriptInsets);}
    }
}
