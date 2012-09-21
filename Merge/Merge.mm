#line 1 "/Users/andrewr/Dropbox/Development/Merge/Merge/Merge.xm"



#import <substrate.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#import <ChatKit/CKTranscriptController.h>
#import <ChatKit/CKTranscriptHeaderView.h>
#import <ChatKit/CKTranscriptTableView.h>
#import <ChatKit/CKContentEntryView.h>
#import <ChatKit/CKAggregateConversation.h>
#import <ChatKit/CKSubConversation.h>
#import <ChatKit/CKEntity.h>
#import <ChatKit/_CKConversation.h>
#import <ChatKit/CKTranscriptBubbleData.h>
#import <ChatKit/CKServiceView.h>
#import <ChatKit/CKMessage.h>
#import <ChatKit/CKService.h>
#import <ChatKit/CKMessageStandaloneComposition.h>
#import <ChatKit/CKConversationList.h>
#import <ChatKit/CKTranscriptToolbarView.h>
#import <ChatKit/CKRecipientSelectionView.h>
#import <ChatKit/CKRecipientGenerator.h>
#import <ChatKit/CKComposeRecipientView.h>
#import <ChatKit/CKDashedLineView.h>
#import <ChatKit/CKUIBehavior.h>
#import <ChatKit/CKPreferredServiceManager.h>
#import <ChatKit/CKMessagesAppPreferredServiceManager.h>

#import <UIKit/UIKit.h>
#import <UIKit/UIGraphics.h>
#import <UIKit/UIPlacardButton_Dumped.h>
#import <AddressBook/ABPhoneFormatting_Dumped.h>
#import <MessageUI/MFComposeRecipientAtom_Dumped.h>
#import <MessageUI/MFComposeRecipient_Dumped.h>

#import "MGTranscriptHeaderContext.h"
#import "MGAddressManager.h"
#import "ABContactHelper/ABContactsHelper.h"

#warning TODO: see if these are useful
extern NSString *const CKAggregateConversationPreferredServiceChangedNotification;
extern NSString *const CKPreferredServiceChangedNotification;

@interface UIScrollView ()
- (NSTimeInterval)_contentOffsetAnimationDuration;
@end

@interface CKTranscriptTableView (FloatingHeader)
@property (nonatomic, copy) void (^updateBlock)(CKTranscriptTableView *);
@end

@interface CKTranscriptController (FloatingHeader)
- (void)updateHeaderView;
- (void)didSelectContactButton:(UIGestureRecognizer *)gesture;
- (MGTranscriptHeaderContext *)headerContext;
- (void)updateTranscriptHeaderInset;
- (UIView *)backPlacardView;
@end

@interface CKAggregateConversation ()
@property (nonatomic, retain) CKEntity *selectedRecipient;
@property (nonatomic, retain) CKMessage *pendingMessage;
- (CKSubConversation *)_bestExistingConversationWithService:(CKService *)service;
- (NSArray *)allAddresses;
@end

@interface CKTranscriptController ()
- (CKRecipientListView *)recipientListView;
- (CKTranscriptToolbarView *)transcriptToolbarView;
- (void)selectAddressForCurrentRecipientFromView:(UIView *)view asPopover:(BOOL)popover;
- (void)showPendingDividerIfNecessaryForRecipient:(CKEntity *)recipient;
@end

@interface CKTranscriptToolbarView ()
- (UIButton *)contactButton;
@end

@interface CKTranscriptBubbleData ()
@property (nonatomic, retain) CKService *pendingService;
- (CKMessage *)lastMessageFromIndex:(NSInteger)index;
- (CKMessage *)nextMessageFromIndex:(NSInteger)index;
- (NSInteger)_indexOfPendingService;
@end

@interface CKServiceView ()
@property (nonatomic, retain) CKEntity *entity;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic) BOOL shouldShowDashedLine;
- (void)updateTitleLabel;
- (CKService *)service;
- (UILabel *)textLabel;
@end

@interface CKPreferredServiceManager ()
- (CKService *)preferredServiceForSelectedRecipient:(CKEntity *)recipient withAggregateConversation:(CKAggregateConversation *)conversation canSend:(BOOL *)canSend error:(NSError **)error;
@end

@interface NSObject (MFComposeRecipientAtomDelegate)
- (void)recipientSelectionView:(CKRecipientSelectionView *)selectionView selectAddressForAtom:(MFComposeRecipientAtom *)atom;
@end

static BOOL ShouldMergeServiceAndDateLabels()
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

#include <substrate.h>
@class MFComposeRecipientAtom; @class CKServiceView; @class CKSMSService; @class CKTranscriptHeaderView; @class CKMadridService; @class CKTranscriptController; @class CKDashedLineView; @class CKMessagesAppPreferredServiceManager; @class CKAggregateConversation; @class CKRecipientSelectionView; @class CKPreferredServiceManager; @class CKTranscriptToolbarView; @class CKEntity; @class CKConversationList; @class CKTranscriptTableView; @class CKTranscriptBubbleData; 
static NSUInteger (*_logos_orig$_ungrouped$CKEntity$addressHash)(CKEntity*, SEL); static NSUInteger _logos_method$_ungrouped$CKEntity$addressHash(CKEntity*, SEL); static void _logos_method$_ungrouped$CKServiceView$updateTitleLabel(CKServiceView*, SEL); static CKService * _logos_method$_ungrouped$CKServiceView$service(CKServiceView*, SEL); static UILabel * _logos_method$_ungrouped$CKServiceView$textLabel(CKServiceView*, SEL); static void (*_logos_orig$_ungrouped$CKServiceView$setService$)(CKServiceView*, SEL, CKService *); static void _logos_method$_ungrouped$CKServiceView$setService$(CKServiceView*, SEL, CKService *); static BOOL _logos_method$_ungrouped$CKServiceView$shouldShowDashedLine(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$setShouldShowDashedLine$(CKServiceView*, SEL, BOOL); static CKEntity * _logos_method$_ungrouped$CKServiceView$entity(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$setEntity$(CKServiceView*, SEL, CKEntity *); static UILabel * _logos_method$_ungrouped$CKServiceView$dateLabel(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$setDateLabel$(CKServiceView*, SEL, UILabel *); static NSDate * _logos_method$_ungrouped$CKServiceView$date(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$setDate$(CKServiceView*, SEL, NSDate *); static void (*_logos_orig$_ungrouped$CKServiceView$layoutSubviews)(CKServiceView*, SEL); static void _logos_method$_ungrouped$CKServiceView$layoutSubviews(CKServiceView*, SEL); static UIButton * _logos_method$_ungrouped$CKTranscriptToolbarView$contactButton(CKTranscriptToolbarView*, SEL); static CKRecipientListView * _logos_method$_ungrouped$CKTranscriptController$recipientListView(CKTranscriptController*, SEL); static CKTranscriptToolbarView * _logos_method$_ungrouped$CKTranscriptController$transcriptToolbarView(CKTranscriptController*, SEL); static void _logos_method$_ungrouped$CKTranscriptController$didSelectContactButtonPad$(CKTranscriptController*, SEL, UIGestureRecognizer *); static void (*_logos_orig$_ungrouped$CKTranscriptController$updateActionItem)(CKTranscriptController*, SEL); static void _logos_method$_ungrouped$CKTranscriptController$updateActionItem(CKTranscriptController*, SEL); static void (*_logos_orig$_ungrouped$CKTranscriptController$_computeBubbleData$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$_ungrouped$CKTranscriptController$_computeBubbleData$(CKTranscriptController*, SEL, BOOL); static void (*_logos_orig$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$)(CKTranscriptController*, SEL, NSNotification *); static void _logos_method$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$(CKTranscriptController*, SEL, NSNotification *); static void _logos_method$_ungrouped$CKTranscriptController$showPendingDividerIfNecessaryForRecipient$(CKTranscriptController*, SEL, CKEntity *); static void _logos_method$_ungrouped$CKTranscriptController$selectAddressForCurrentRecipientFromView$asPopover$(CKTranscriptController*, SEL, UIView *, BOOL); static void _logos_method$_ungrouped$CKTranscriptController$recipientSelectionView$selectAddressForAtom$(CKTranscriptController*, SEL, CKRecipientSelectionView *, MFComposeRecipientAtom *); static void (*_logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$)(CKTranscriptController*, SEL, CKTranscriptTableView *, CKServiceView *, NSIndexPath *); static void _logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(CKTranscriptController*, SEL, CKTranscriptTableView *, CKServiceView *, NSIndexPath *); static NSInteger _logos_method$_ungrouped$CKTranscriptBubbleData$_indexOfPendingService(CKTranscriptBubbleData*, SEL); static CKService * _logos_method$_ungrouped$CKTranscriptBubbleData$pendingService(CKTranscriptBubbleData*, SEL); static void _logos_method$_ungrouped$CKTranscriptBubbleData$setPendingService$(CKTranscriptBubbleData*, SEL, CKService *); static CKMessage * _logos_method$_ungrouped$CKTranscriptBubbleData$lastMessageFromIndex$(CKTranscriptBubbleData*, SEL, NSInteger); static CKMessage * _logos_method$_ungrouped$CKTranscriptBubbleData$nextMessageFromIndex$(CKTranscriptBubbleData*, SEL, NSInteger); static int (*_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$)(CKTranscriptBubbleData*, SEL, CKMessage *); static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$(CKTranscriptBubbleData*, SEL, CKMessage *); static int (*_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$)(CKTranscriptBubbleData*, SEL, CKMessage *); static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(CKTranscriptBubbleData*, SEL, CKMessage *); static CKAggregateConversation * (*_logos_orig$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$)(CKConversationList*, SEL, NSArray *, BOOL); static CKAggregateConversation * _logos_method$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$(CKConversationList*, SEL, NSArray *, BOOL); static id (*_logos_orig$_ungrouped$CKConversationList$existingConversationForAddresses$)(CKConversationList*, SEL, NSArray *); static id _logos_method$_ungrouped$CKConversationList$existingConversationForAddresses$(CKConversationList*, SEL, NSArray *); static CKEntity * _logos_method$_ungrouped$CKAggregateConversation$selectedRecipient(CKAggregateConversation*, SEL); static void _logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$(CKAggregateConversation*, SEL, CKEntity *); static CKMessage * _logos_method$_ungrouped$CKAggregateConversation$pendingMessage(CKAggregateConversation*, SEL); static void _logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$(CKAggregateConversation*, SEL, CKMessage *); static NSArray * _logos_method$_ungrouped$CKAggregateConversation$allAddresses(CKAggregateConversation*, SEL); static id (*_logos_orig$_ungrouped$CKAggregateConversation$_subConversationForService$create$)(CKAggregateConversation*, SEL, id, BOOL); static id _logos_method$_ungrouped$CKAggregateConversation$_subConversationForService$create$(CKAggregateConversation*, SEL, id, BOOL); static id (*_logos_orig$_ungrouped$CKAggregateConversation$_bestExistingConversation)(CKAggregateConversation*, SEL); static id _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversation(CKAggregateConversation*, SEL); static CKSubConversation * _logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversationWithService$(CKAggregateConversation*, SEL, CKService *); static BOOL (*_logos_orig$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$)(CKAggregateConversation*, SEL, CKSubConversation *); static BOOL _logos_method$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$(CKAggregateConversation*, SEL, CKSubConversation *); static int (*_logos_orig$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$)(CKAggregateConversation*, SEL, CKMessage *, BOOL); static int _logos_method$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$(CKAggregateConversation*, SEL, CKMessage *, BOOL); static id (*_logos_orig$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$)(CKSMSService*, SEL, id, CKSubConversation *); static id _logos_method$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$(CKSMSService*, SEL, id, CKSubConversation *); static id (*_logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$)(CKMadridService*, SEL, id, CKSubConversation *); static id _logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(CKMadridService*, SEL, id, CKSubConversation *); static void _logos_method$_ungrouped$CKRecipientSelectionView$composeRecipientView$showPersonCardForAtom$(CKRecipientSelectionView*, SEL, id, MFComposeRecipientAtom *); static id (*_logos_orig$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$)(MFComposeRecipientAtom*, SEL, CGRect, id, int); static id _logos_method$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$(MFComposeRecipientAtom*, SEL, CGRect, id, int); static void _logos_method$_ungrouped$MFComposeRecipientAtom$handleLongPressGesture$(MFComposeRecipientAtom*, SEL, UILongPressGestureRecognizer *); static CKService * _logos_method$_ungrouped$CKPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$(CKPreferredServiceManager*, SEL, CKEntity *, CKAggregateConversation *, BOOL *, NSError **); static CKService * (*_logos_orig$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$)(CKMessagesAppPreferredServiceManager*, SEL, CKEntity *, CKAggregateConversation *, BOOL *, NSError **); static CKService * _logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$(CKMessagesAppPreferredServiceManager*, SEL, CKEntity *, CKAggregateConversation *, BOOL *, NSError **); static id (*_logos_orig$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$)(CKMessagesAppPreferredServiceManager*, SEL, CKAggregateConversation *, BOOL, BOOL, BOOL *, id *); static id _logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$(CKMessagesAppPreferredServiceManager*, SEL, CKAggregateConversation *, BOOL, BOOL, BOOL *, id *); 

#line 110 "/Users/andrewr/Dropbox/Development/Merge/Merge/Merge.xm"
static id (*_logos_orig$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$)(CKTranscriptHeaderView*, SEL, CGRect, BOOL, BOOL, BOOL); static id _logos_method$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$(CKTranscriptHeaderView*, SEL, CGRect, BOOL, BOOL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptHeaderView$layoutSubviews)(CKTranscriptHeaderView*, SEL); static void _logos_method$FloatingHeader$CKTranscriptHeaderView$layoutSubviews(CKTranscriptHeaderView*, SEL); static void (^_logos_method$FloatingHeader$CKTranscriptTableView$updateBlock(CKTranscriptTableView*, SEL))(CKTranscriptTableView *); static void _logos_method$FloatingHeader$CKTranscriptTableView$setUpdateBlock$(CKTranscriptTableView*, SEL, void (^)(CKTranscriptTableView *)); static void (*_logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews)(CKTranscriptTableView*, SEL); static void _logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews(CKTranscriptTableView*, SEL); static MGTranscriptHeaderContext * _logos_method$FloatingHeader$CKTranscriptController$headerContext(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$updateTranscriptHeaderInset(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$updateHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$loadView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$loadView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewWillUnload)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$viewWillUnload(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewWillAppear$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$viewWillAppear$(CKTranscriptController*, SEL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$viewDidAppear$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$viewDidAppear$(CKTranscriptController*, SEL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void _logos_method$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void (*_logos_orig$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$)(CKTranscriptController*, SEL, UIInterfaceOrientation); static void _logos_method$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$(CKTranscriptController*, SEL, UIInterfaceOrientation); static void (*_logos_orig$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$)(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void _logos_method$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$(CKTranscriptController*, SEL, UIInterfaceOrientation, NSTimeInterval); static void _logos_method$FloatingHeader$CKTranscriptController$didSelectContactButton$(CKTranscriptController*, SEL, UIGestureRecognizer *); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$setEditing$animated$)(CKTranscriptController*, SEL, BOOL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$(CKTranscriptController*, SEL, BOOL, BOOL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$reload$)(CKTranscriptController*, SEL, BOOL); static void _logos_method$FloatingHeader$CKTranscriptController$reload$(CKTranscriptController*, SEL, BOOL); static UIView * _logos_method$FloatingHeader$CKTranscriptController$backPlacardView(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidScroll$(CKTranscriptController*, SEL, UIScrollView *); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewDidEndDecelerating$(CKTranscriptController*, SEL, UIScrollView *); static void _logos_method$FloatingHeader$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$(CKTranscriptController*, SEL, UIScrollView *, CGPoint, CGPoint *); static void _logos_method$FloatingHeader$CKTranscriptController$keyboardFrameWillChange$(CKTranscriptController*, SEL, NSNotification *); static BOOL _logos_method$FloatingHeader$CKTranscriptController$keyboardIsReallyOnScreen(CKTranscriptController*, SEL); static void (*_logos_orig$FloatingHeader$CKTranscriptController$_resetTranscriptInsets)(CKTranscriptController*, SEL); static void _logos_method$FloatingHeader$CKTranscriptController$_resetTranscriptInsets(CKTranscriptController*, SEL); 



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





static NSString *const MGTranscriptTableViewLayoutBlockKey = @"MGTranscriptTableViewLayoutBlockKey";



static void (^_logos_method$FloatingHeader$CKTranscriptTableView$updateBlock(CKTranscriptTableView* self, SEL _cmd))(CKTranscriptTableView *) {
    return objc_getAssociatedObject(self, MGTranscriptTableViewLayoutBlockKey);
}



static void _logos_method$FloatingHeader$CKTranscriptTableView$setUpdateBlock$(CKTranscriptTableView* self, SEL _cmd, void (^updateBlock)(CKTranscriptTableView *)) {
    objc_setAssociatedObject(self, MGTranscriptTableViewLayoutBlockKey, updateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


static void _logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews(CKTranscriptTableView* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews(self, _cmd);
    
    void (^updateBlock)(CKTranscriptTableView *) = self.updateBlock;
    if (updateBlock)
        updateBlock(self);
}







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
    self.transcriptTable.updateBlock = updateBlock;
    
    [[self headerContext] setScrollView:self.transcriptTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
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
	_logos_orig$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$(self, _cmd, toInterfaceOrientation, duration);
	
    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}



static void _logos_method$FloatingHeader$CKTranscriptController$didSelectContactButton$(CKTranscriptController* self, SEL _cmd, UIGestureRecognizer * gesture) {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self selectAddressForCurrentRecipientFromView:self.view asPopover:NO];
	}
}

static void _logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
    _logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView(self, _cmd);
    
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
		
		UIPlacardButton *contactButton = MSHookIvar<id>(header, "_contactsButton");
		if (contactButton)
		{
			UILongPressGestureRecognizer *gesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectContactButton:)] autorelease];
			[contactButton addGestureRecognizer:gesture];
		}
        
        context.tableHeaderView = tableHeaderView;
        
        self.transcriptTable.tableHeaderView = tableHeaderView;
        [header removeFromSuperview];
        [self.view addSubview:header];
        
        [self updateTranscriptHeaderInset];
    }
}

static void _logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView(CKTranscriptController* self, SEL _cmd) {
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
    _logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView(self, _cmd);
    
    [self.view addSubview:[self headerContext].headerView];
    self.transcriptTable.tableHeaderView = [self headerContext].tableHeaderView;
}


static void _logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$(CKTranscriptController* self, SEL _cmd, BOOL editing, BOOL animated) {
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    BOOL prevEditing = [self.transcriptTable isEditing];
    
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
    _logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews(self, _cmd);
    
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    [[self backPlacardView] bringSubviewToFront:header];
}


static void _logos_method$FloatingHeader$CKTranscriptController$reload$(CKTranscriptController* self, SEL _cmd, BOOL reload) {
    _logos_orig$FloatingHeader$CKTranscriptController$reload$(self, _cmd, reload);
    
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
		
		if (entity.propertyType == kABPersonPhoneProperty) {
			NSString *formattedAddress = [ABPhoneFormatting abNormalizedPhoneNumberFromString:entity.rawAddress];
			
			[labelText appendString:formattedAddress];
		}
		else {
			[labelText appendString:entity.normalizedRawAddress];
		}
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

            _logos_orig$_ungrouped$CKServiceView$setService$(self, _cmd, service);

        
        [self updateTitleLabel];
    }
}

static NSString *const MGAddressViewEntityKey = @"MGAddressViewEntityKey";
static NSString *const MGServiceViewDateLabelKey = @"MGServiceViewDateLabelKey";
static NSString *const MGServiceViewDateKey = @"MGServiceViewDateKey";
static NSString *const MGServiceViewShouldShowDashedLineKey = @"MGServiceViewShouldShowDashedLineKey";



static BOOL _logos_method$_ungrouped$CKServiceView$shouldShowDashedLine(CKServiceView* self, SEL _cmd) {
    NSNumber *shouldShowDashedLine = objc_getAssociatedObject(self, MGServiceViewShouldShowDashedLineKey);
	return (shouldShowDashedLine ? [shouldShowDashedLine boolValue] : YES);
}



static void _logos_method$_ungrouped$CKServiceView$setShouldShowDashedLine$(CKServiceView* self, SEL _cmd, BOOL shouldShowDashedLine) {
    objc_setAssociatedObject(self, MGServiceViewShouldShowDashedLineKey, @(shouldShowDashedLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	[self setNeedsLayout];
}



static CKEntity * _logos_method$_ungrouped$CKServiceView$entity(CKServiceView* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGAddressViewEntityKey);
}



static void _logos_method$_ungrouped$CKServiceView$setEntity$(CKServiceView* self, SEL _cmd, CKEntity * entity) {
    objc_setAssociatedObject(self, MGAddressViewEntityKey, entity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateTitleLabel];
}



static UILabel * _logos_method$_ungrouped$CKServiceView$dateLabel(CKServiceView* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGServiceViewDateLabelKey);
}



static void _logos_method$_ungrouped$CKServiceView$setDateLabel$(CKServiceView* self, SEL _cmd, UILabel * dateLabel) {
	[[self dateLabel] removeFromSuperview];
    objc_setAssociatedObject(self, MGServiceViewDateLabelKey, dateLabel,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self.contentView addSubview:dateLabel];
	[self setNeedsLayout];
}



static NSDate * _logos_method$_ungrouped$CKServiceView$date(CKServiceView* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGServiceViewDateKey);
}



static void _logos_method$_ungrouped$CKServiceView$setDate$(CKServiceView* self, SEL _cmd, NSDate * date) {
    objc_setAssociatedObject(self, MGServiceViewDateKey, date,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	NSString *dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterShortStyle];
	UILabel *dateLabel = [self dateLabel];
	
	if (dateString && !dateLabel) {
		dateLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		
		CKUIBehavior *behaviors = [CKUIBehavior sharedBehaviors];
		dateLabel.textColor = [behaviors timestampTextColor];
		dateLabel.shadowColor = [behaviors timestampTextShadowColor];
		dateLabel.shadowOffset = CGSizeMake(0.0, 1.0);
		dateLabel.font = [UIFont boldSystemFontOfSize:[behaviors timestampTextSize]];
		dateLabel.backgroundColor = [self textLabel].backgroundColor;
		dateLabel.textAlignment = UITextAlignmentCenter;
		dateLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight + UIViewAutoresizingFlexibleLeftMargin + UIViewAutoresizingFlexibleRightMargin;
		dateLabel.opaque = YES;
		
		dateLabel.text = dateString;
		[dateLabel sizeToFit];
		
		self.dateLabel = dateLabel;
	}
	else if (dateLabel) {
		NSString *prevText = dateLabel.text;
		if (prevText && ![dateString isEqualToString:prevText]) {
			dateLabel.text = dateString;
			[self setNeedsLayout];
		}
	}
}


static void _logos_method$_ungrouped$CKServiceView$layoutSubviews(CKServiceView* self, SEL _cmd) {
	_logos_orig$_ungrouped$CKServiceView$layoutSubviews(self, _cmd);
	
	UILabel *dateLabel = self.dateLabel;
	
	if (dateLabel) {
		[dateLabel sizeToFit];
		
		UILabel *textLabel = [self textLabel];
		
		static const CGFloat LabelSpacing = 1.0f;
		static const CGFloat DashedLineMargins = 3.0f;
		
		CGFloat totalLabelWidth = CGRectGetWidth(textLabel.bounds) + LabelSpacing + CGRectGetWidth(dateLabel.bounds);
		CGFloat labelMargins = ((CGRectGetWidth(self.bounds) - totalLabelWidth) / 2);
		
		CGRect textFrame = textLabel.frame;
		textFrame.origin.x = labelMargins;
		textLabel.frame = textFrame;
		
		CGRect dateFrame = dateLabel.frame;
		dateFrame.origin.x = CGRectGetWidth(self.bounds) - labelMargins - CGRectGetWidth(dateFrame);
		dateFrame.origin.y = textFrame.origin.y;
		dateLabel.frame = dateFrame;
		
		CGRect gapRect = (CGRect){CGRectGetMinX(textFrame), 0, totalLabelWidth + DashedLineMargins, CGRectGetHeight(self.bounds)};
		
		CKDashedLineView *dashedLine = MSHookIvar<id>(self, "_dashedLineView");
		if (dashedLine) {
			[dashedLine setGapRect:gapRect];
			dashedLine.alpha = (self.isEditing || !self.shouldShowDashedLine ? 0.0 : 1.0);
		}
		
		dateLabel.alpha = (self.isEditing ? 0.0 : 1.0);
	}
}







static UIButton * _logos_method$_ungrouped$CKTranscriptToolbarView$contactButton(CKTranscriptToolbarView* self, SEL _cmd) {
	UIButton *button = MSHookIvar<id>(self, "_contactButton");
	return (button ? button : nil);
}



extern NSString *const CKBubbleDataMessage;





static CKRecipientListView * _logos_method$_ungrouped$CKTranscriptController$recipientListView(CKTranscriptController* self, SEL _cmd) {
	id view = MSHookIvar<id>(self, "_recipientListView");
	return (view ? view : nil);
}



static CKTranscriptToolbarView * _logos_method$_ungrouped$CKTranscriptController$transcriptToolbarView(CKTranscriptController* self, SEL _cmd) {
	CKTranscriptToolbarView *view = MSHookIvar<id>(self, "_transcriptToolbarView");
	return (view ? view : nil);
}



static void _logos_method$_ungrouped$CKTranscriptController$didSelectContactButtonPad$(CKTranscriptController* self, SEL _cmd, UIGestureRecognizer * gesture) {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self selectAddressForCurrentRecipientFromView:gesture.view asPopover:YES];
	}
}


static void _logos_method$_ungrouped$CKTranscriptController$updateActionItem(CKTranscriptController* self, SEL _cmd) {
	_logos_orig$_ungrouped$CKTranscriptController$updateActionItem(self, _cmd);
	
	CKTranscriptToolbarView *toolbar = [self transcriptToolbarView];
	if (toolbar) {
		
		UILongPressGestureRecognizer *longPressGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectContactButtonPad:)] autorelease];
		UIButton *contactButton = [toolbar contactButton];
		[contactButton addGestureRecognizer:longPressGesture];
	}
}


static void _logos_method$_ungrouped$CKTranscriptController$_computeBubbleData$(CKTranscriptController* self, SEL _cmd, BOOL force) {
	_logos_orig$_ungrouped$CKTranscriptController$_computeBubbleData$(self, _cmd, force);
	
	CKTranscriptBubbleData *data = [self bubbleData];
	CKService *lastService = [data serviceAtIndex:[data _lastIndexExcludingTypingIndicator]-1];
	NSInteger count = [data count];
	
	if (!lastService && count > 0) {
		CKEntity *selectedRecipient = self.conversation.selectedRecipient;
		CKMessage *lastMessage = [data lastMessageFromIndex:count];
		
		if (selectedRecipient && (lastMessage && lastMessage.conversation.recipient != selectedRecipient)) {
			CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] preferredServiceForSelectedRecipient:selectedRecipient
																												withAggregateConversation:[self conversation]
																																  canSend:NULL
																																	error:NULL];
			
			data.pendingService = preferredService;



		}
	}
}


static void _logos_method$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$(CKTranscriptController* self, SEL _cmd, NSNotification * notification) {
	_logos_orig$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$(self, _cmd, notification);
	
	CKTranscriptBubbleData *bubbleData = [self bubbleData];
	
	CKAggregateConversation *conversation = [self conversation];
	CKEntity *selectedRecipient = conversation.selectedRecipient;
	
	if (selectedRecipient) {
		CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] preferredServiceForSelectedRecipient:selectedRecipient
																											withAggregateConversation:conversation
																															  canSend:NULL
																																error:NULL];
		
		bubbleData.pendingService = preferredService;
	}
}



static void _logos_method$_ungrouped$CKTranscriptController$showPendingDividerIfNecessaryForRecipient$(CKTranscriptController* self, SEL _cmd, CKEntity * recipient) {
	CKTranscriptBubbleData *data = [self bubbleData];
	CKTranscriptTableView *tableView = [self transcriptTable];
	
	
	
	NSUInteger lastIndex = [data _indexOfPendingService]; 

	CKService *lastService = [data pendingService];
	

	
	CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] preferredServiceForSelectedRecipient:recipient
																										withAggregateConversation:[self conversation]
																												 canSend:NULL
																												   error:NULL];
	
	DLog(@"preferredService: %@", preferredService);
	
	NSIndexPath *scrollIndex = nil;
	
	if (!lastService)
	{
		
		[tableView beginUpdates];
		

		data.pendingService = preferredService;
		
		NSIndexPath *newIndex = [NSIndexPath indexPathForRow:(lastIndex + 1) inSection:0];

		[tableView insertRowsAtIndexPaths:@[newIndex]
						 withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView endUpdates];
		
		scrollIndex = newIndex;
	}
	else
	{
		NSIndexPath *lastServiceIndex = [NSIndexPath indexPathForRow:lastIndex inSection:0];
		CKServiceView *lastCell = (CKServiceView *)[tableView cellForRowAtIndexPath:lastServiceIndex];
		
		if (lastCell) {
			
			[lastCell setEntity:recipient];
			DLog(@"cell %@ exists! setting service to %@", lastCell, preferredService);
			[lastCell setService:preferredService];
		}
		else {
			scrollIndex = lastServiceIndex;
			




		}
		
		data.pendingService = preferredService;
	}
	
	if (scrollIndex) {
		[tableView scrollToRowAtIndexPath:scrollIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		NSTimeInterval animationDuration = [tableView _contentOffsetAnimationDuration];
		
		
		
		[self performSelector:@selector(_makeContentEntryViewActive) withObject:nil afterDelay:(animationDuration + 0.1)];
	}
	else {
		
		[self _makeContentEntryViewActive];
	}
	
	[self updateEntryView];
}

extern "C" void CKShowError(NSError *error);



static void _logos_method$_ungrouped$CKTranscriptController$selectAddressForCurrentRecipientFromView$asPopover$(CKTranscriptController* self, SEL _cmd, UIView * view, BOOL popover) {
    CKSubConversation *conversation = [self.conversation _bestExistingConversation];
    CKEntity *entity = [conversation recipient];
	if (!entity) {
		entity = [self.conversation recipient];
	}
	
	ABRecordRef record = entity.abRecord;
	if (!record) {
		NSLog(@"Error: could not find record for entity %@ in aggregate %@", entity, self.conversation);
		return;
	}
    ABContact *contact = [ABContact contactWithRecord:record];

    
    [[MGAddressManager sharedAddressManager] presentDifferentiationSheetForContact:contact
                                                                            inView:view
																		 asPopover:popover
                                                                availableAddresses:nil
                                                                        completion:^(NSString *selectedAddress, BOOL *performOriginalAction) {
                                                                            CKSubConversation *subConversation = [[CKConversationList sharedConversationList] existingConversationForAddresses:@[selectedAddress]];
                                                                            if (subConversation) {
																				CKEntity *selectedRecipient = [subConversation.recipients objectAtIndex:0];
                                                                                self.conversation.selectedRecipient = selectedRecipient;
																				
																				[self showPendingDividerIfNecessaryForRecipient:selectedRecipient];
                                                                            }
																			else {
																				CKPreferredServiceManager *manager = [CKPreferredServiceManager sharedPreferredServiceManager];
																				BOOL canSend = YES;
																				NSError *error = nil;
																				CKService *preferredService = [manager preferredServiceForAddressString:selectedAddress newComposition:YES checkWithServer:YES canSend:&canSend error:&error];
																				
																				DLog(@"canSend?? : %d, error: %@", canSend, error);
																				
																				if (canSend && preferredService) {
																					CKEntity *recipient = [preferredService copyEntityForAddressString:selectedAddress];
																					CKSubConversation *convo = [[[[CKConversationList sharedConversationList] conversationForRecipients:@[recipient] create:YES service:preferredService] retain] autorelease];
																					
																					DLog(@"convo: %@ for recipient: %@ with aggregate: %@", convo, recipient, convo.aggregateConversation);
																					
																					if ([self.conversation containsConversation:convo]) {
																						self.conversation.selectedRecipient = recipient;
																						[self showPendingDividerIfNecessaryForRecipient:recipient];
																					}
																					else {
																						ULog(@"Error: conversation %@ NOT in current aggregate %@, its aggregate is %@", convo, self.conversation, convo.aggregateConversation);
																						
																						[[CKConversationList sharedConversationList] removeConversation:convo];
																						[convo deleteAllMessagesAndRemoveGroup];
																						
																						*performOriginalAction = YES;
																					}
																					
																					[recipient release];
																				}
																				else {
#ifdef DEBUG
																					CKShowError(error);
#endif
																					*performOriginalAction = YES;
																				}
																			}
                                                                        }];
}



static void _logos_method$_ungrouped$CKTranscriptController$recipientSelectionView$selectAddressForAtom$(CKTranscriptController* self, SEL _cmd, CKRecipientSelectionView * view, MFComposeRecipientAtom * atom) {
	ABRecordRef record = atom.recipient.record;
	if (record) {
		ABContact *contact = [ABContact contactWithRecord:record];
		
		[[MGAddressManager sharedAddressManager] presentDifferentiationSheetForContact:contact
																				inView:atom
																			 asPopover:YES
																	availableAddresses:nil
																			completion:^(NSString *selectedAddress, BOOL *performOriginalAction) {
																				if (selectedAddress) {
																					CKRecipientGenerator *generator = [self _recipientGenerator];
																					MFComposeRecipient *recipient = [generator recipientWithAddress:selectedAddress];
																					CKComposeRecipientView *recipientsView = view.toField;
																					MFComposeRecipient *prevRecipient = atom.recipient;
																					if (recipient && recipientsView && ![recipient isEqual:prevRecipient]) {
																						[recipientsView replaceRecipient:prevRecipient withRecipient:recipient];
																					}
																				}
																			}];
	}
}


static void _logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(CKTranscriptController* self, SEL _cmd, CKTranscriptTableView * view, CKServiceView * cell, NSIndexPath * indexPath) {
    _logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$(self, _cmd, view, cell, indexPath);
    if ([cell isKindOfClass:[CKServiceView class]]) {
		CKEntity *entity = nil;
		NSDate *messageDate = nil;
		
		NSUInteger numRows = [[self transcriptTable] numberOfRowsInSection:indexPath.section];
		if (indexPath.row == numRows - 1)
		{
			
			entity = [self.conversation selectedRecipient];
			
			if (ShouldMergeServiceAndDateLabels()) {
				messageDate = [NSDate date];
			}
		}
        else
		{
			CKTranscriptBubbleData *data = [self bubbleData];
			NSInteger index = indexPath.row + 1;
			
			CKMessage *message = [data nextMessageFromIndex:index];
			entity = [message.conversation recipient];
			
			if (ShouldMergeServiceAndDateLabels()) {
				messageDate = [message date];
				cell.shouldShowDashedLine = (indexPath.row > 0);
			}
		}
		
        if (!entity) {
            NSLog(@"Error: could not find entity for CKServiceView at indexPath %@", indexPath);
        }
        
        [cell setEntity:entity];
		if (messageDate) {
			[cell setDate:messageDate];
		}
    }
}



extern NSString *const CKBubbleDataService;



static NSString *const MGBubbleDataPendingServiceKey = @"MGBubbleDataPendingServiceKey";



static NSInteger _logos_method$_ungrouped$CKTranscriptBubbleData$_indexOfPendingService(CKTranscriptBubbleData* self, SEL _cmd) {
	
	
	return ([self _lastIndexExcludingTypingIndicator] - 1);
}



static CKService * _logos_method$_ungrouped$CKTranscriptBubbleData$pendingService(CKTranscriptBubbleData* self, SEL _cmd) {

	return [self serviceAtIndex:[self _indexOfPendingService]];
}



static void _logos_method$_ungrouped$CKTranscriptBubbleData$setPendingService$(CKTranscriptBubbleData* self, SEL _cmd, CKService * pendingService) {
	CKService *prevPendingService = [[[self pendingService] retain] autorelease];
    objc_setAssociatedObject(self, MGBubbleDataPendingServiceKey, pendingService,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	if (pendingService) {
		if (!prevPendingService) {
			[self _appendService:pendingService];
		}
		else {
			NSMutableDictionary *serviceData = (NSMutableDictionary *)[self bubbleDataForIndex:[self _indexOfPendingService]];
			[serviceData setObject:pendingService forKey:CKBubbleDataService];
		}
	}
}



static CKMessage * _logos_method$_ungrouped$CKTranscriptBubbleData$lastMessageFromIndex$(CKTranscriptBubbleData* self, SEL _cmd, NSInteger index) {
	CKMessage *prevMessage = nil;
	
	int count = [self count];
	if (index >= count && count > 0) {
		index = count-1;
	}
	
	while (index > 0) {
		prevMessage = [self messageAtIndex:index];
		if (prevMessage) {
			break;
		}
		index--;
	}
	
	return prevMessage;
}



static CKMessage * _logos_method$_ungrouped$CKTranscriptBubbleData$nextMessageFromIndex$(CKTranscriptBubbleData* self, SEL _cmd, NSInteger index) {
	CKMessage *message = nil;
	
	int count = [self count];
	while (index < count) {
		message = [self messageAtIndex:index];
		if (message) {
			break;
		}
		index++;
	}
	
	return message;
}


static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$(CKTranscriptBubbleData* self, SEL _cmd, CKMessage * message) {
	if (ShouldMergeServiceAndDateLabels()) {
		NSInteger index = [self indexForMessage:message];
		if (index == NSNotFound) {
			index = [self count];
		}
		
		CKService *prevService = [self serviceAtIndex:index-1];
		if (prevService) {
			[self _setupNextEligibleTimestamp:[message date]];
			return NSNotFound;
		}
	}
	
	return _logos_orig$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$(self, _cmd, message);
}


static int _logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(CKTranscriptBubbleData* self, SEL _cmd, CKMessage * message) {
    NSInteger response = _logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$(self, _cmd, message);
    if (response == NSNotFound && [message conversation]) {
        NSInteger index = [self indexForMessage:message];
        if (index == NSNotFound) {
            index = [self count];
        }
		
		NSInteger searchIndex = (index > 0 ? index-1 : 0);
		
		
		CKService *prevService = [self serviceAtIndex:searchIndex];
		if (!prevService) {
			CKMessage *prevMessage = [self lastMessageFromIndex:searchIndex];
			BOOL shouldAppendService = NO;
			

			
			if ([prevMessage conversation]) {
				BOOL sameAddress = ([[message.conversation recipients] isEqual:[prevMessage.conversation recipients]]);
				shouldAppendService = !sameAddress;
			}
			else if (index == 0) {
				
				shouldAppendService = YES;
			}
			
			if (shouldAppendService) {
				response = [self _appendService:message.service];
			}
		}
    }
    return response;
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

        conversation.aggregateConversation.selectedRecipient = [conversation.recipients objectAtIndex:0];
    }
    return conversation;
}





static NSString *const MGSelectedRecipientKey = @"MGSelectedRecipientKey";
static NSString *const MGPendingMessageKey = @"MGPendingMessageKey";



static CKEntity * _logos_method$_ungrouped$CKAggregateConversation$selectedRecipient(CKAggregateConversation* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGSelectedRecipientKey);
}



static void _logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$(CKAggregateConversation* self, SEL _cmd, CKEntity * recipient) {
    objc_setAssociatedObject(self, MGSelectedRecipientKey, recipient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



static CKMessage * _logos_method$_ungrouped$CKAggregateConversation$pendingMessage(CKAggregateConversation* self, SEL _cmd) {
    return objc_getAssociatedObject(self, MGPendingMessageKey);
}



static void _logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$(CKAggregateConversation* self, SEL _cmd, CKMessage * pendingMessage) {
    objc_setAssociatedObject(self, MGPendingMessageKey, pendingMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



static NSArray * _logos_method$_ungrouped$CKAggregateConversation$allAddresses(CKAggregateConversation* self, SEL _cmd) {
	NSMutableArray *addresses = [NSMutableArray array];
    for (CKSubConversation *conversation in self.subConversations)
    {
        for (CKEntity *entity in conversation.recipients)
        {
            NSString *address = entity.normalizedRawAddress;
			if (address && entity.propertyType == kABPersonPhoneProperty) {
				address = [ABPhoneFormatting abNormalizedPhoneNumberFromString:address];
			}
			
            if (address) {
                [addresses addObject:address];
            }
        }
    }
    
    return [NSArray arrayWithArray:addresses];
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
                    NSLog(@"Error: found multiple outgoing messages for aggregate %@! They are: %@ and %@", self, [selectedConversation pendingMessages], pendingMessages);
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
        



    }

    return result;
}






static id _logos_method$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$(CKSMSService* self, SEL _cmd, id composition, CKSubConversation * conversation) {
    CKMessage *message = _logos_orig$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$(self, _cmd, composition, conversation);
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}






static id _logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(CKMadridService* self, SEL _cmd, id composition, CKSubConversation * conversation) {
    CKMessage *message = _logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$(self, _cmd, composition, conversation);
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}

















static void _logos_method$_ungrouped$CKRecipientSelectionView$composeRecipientView$showPersonCardForAtom$(CKRecipientSelectionView* self, SEL _cmd, id view, MFComposeRecipientAtom * atom) {
	if (self.delegate && [self.delegate respondsToSelector:@selector(recipientSelectionView:selectAddressForAtom:)]) {
		[self.delegate recipientSelectionView:self selectAddressForAtom:atom];
	}
}





typedef enum {
	MFComposeRecipientAtomStyleBlue = 0,
	MFComposeRecipientAtomStyleBlueDisclosure = 1,
	MFComposeRecipientAtomStyleBlueVerified = 2,
	MFComposeRecipientAtomStyleBlueSecure = 3,
	MFComposeRecipientAtomStyleBlueInsecure = 4,
	MFComposeRecipientAtomStyleBlueVerifiedSecure = 5,
	MFComposeRecipientAtomStyleBlueUnknown = 6,
	MFComposeRecipientAtomStyleGreen = 7,
	MFComposeRecipientAtomStyleGreenDisclosure = 8,
	MFComposeRecipientAtomStyleGray = 9,
	MFComposeRecipientAtomStyleError = 10,
} MFComposeRecipientAtomStyle;


static id _logos_method$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$(MFComposeRecipientAtom* self, SEL _cmd, CGRect frame, id recipient, int style) {
	id _self = _logos_orig$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$(self, _cmd, frame, recipient, style);
	if (_self) {
		
		
		UILongPressGestureRecognizer *longPressGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)] autorelease];
		[self addGestureRecognizer:longPressGesture];
	}
	
	return _self;
}



static void _logos_method$_ungrouped$MFComposeRecipientAtom$handleLongPressGesture$(MFComposeRecipientAtom* self, SEL _cmd, UILongPressGestureRecognizer * gesture) {
	if (gesture.state == UIGestureRecognizerStateBegan) {
		if (self.style != MFComposeRecipientAtomStyleError) {
			[self handleTouchAndHold];
		}
		else {
			[self.delegate selectComposeRecipientAtom:self];
		}
	}
}



typedef enum {
	
	CKPreferredServiceManagerOptionsNewComposition = 1 << 7,
} CKPreferredServiceManagerOptions;





static CKService * _logos_method$_ungrouped$CKPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$(CKPreferredServiceManager* self, SEL _cmd, CKEntity * recipient, CKAggregateConversation * conversation, BOOL * canSend, NSError ** error) {
	NSLog(@"Error: %@ called on %@; should only be called on CKMessagesAppPreferredServiceManager!", NSStringFromSelector(_cmd), self);
	
	
	return (recipient.service ? recipient.service : [self _preferredServiceForEntities:@[recipient] newComposition:YES checkWithServer:NO canSend:canSend error:(id *)error]);
}






static CKService * _logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$(CKMessagesAppPreferredServiceManager* self, SEL _cmd, CKEntity * recipient, CKAggregateConversation * conversation, BOOL * canSend, NSError ** error) {
	CKService *preferredService = nil;
	
	if (recipient) {
		NSArray *recipients = @[recipient];
		NSError *actualError = nil;
		
		unsigned options = [self __optionsForConversation:conversation];
		options |= CKPreferredServiceManagerOptionsNewComposition;
		
		preferredService = [self _preferredServiceForEntities:recipients
							
							
													  options:options
													  canSend:canSend
														error:&actualError];
		
		if (error) {
			*error = actualError;
		}
		
		DLog(@"found preferred service %@ \naggregate %@\nselectedRecipient %@\nerror: %@", preferredService, conversation, recipient, actualError);
		
		if (!preferredService) {
			preferredService = recipient.service;
		}
	}
	
	return preferredService;
}


static id _logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$(CKMessagesAppPreferredServiceManager* self, SEL _cmd, CKAggregateConversation * aggregateConversation, BOOL newComposition, BOOL checkWithServer, BOOL * canSend, id * error) {
	CKService *preferredService = nil;
	if (aggregateConversation.selectedRecipient) {
		preferredService = [self preferredServiceForSelectedRecipient:aggregateConversation.selectedRecipient
											withAggregateConversation:aggregateConversation
															  canSend:canSend
																error:(NSError **)error];
	}
	else {
		preferredService = _logos_orig$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$(self, _cmd, aggregateConversation, newComposition, checkWithServer, canSend, error);
	}
	
	return preferredService;
}



static void (*_logos_orig$DashedLineFixPad$CKDashedLineView$drawRect$)(CKDashedLineView*, SEL, CGRect); static void _logos_method$DashedLineFixPad$CKDashedLineView$drawRect$(CKDashedLineView*, SEL, CGRect); 



static void _logos_method$DashedLineFixPad$CKDashedLineView$drawRect$(CKDashedLineView* self, SEL _cmd, CGRect rect) {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(ctx);
	CGRect bounds = self.bounds;
	
	UIColor *color = MSHookIvar<id>(self, "_color");
	if (color) {
		[color set];
	}
	
	CGRect gap = MSHookIvar<CGRect>(self, "_gap");
	if (!CGRectIsNull(gap)) {
		CGRect leftClipRect = (CGRect){CGPointZero, CGRectGetMinX(gap), CGRectGetMaxY(bounds)};
		CGRect rightClipRect = (CGRect){CGRectGetMaxX(gap), 0, CGRectGetMaxX(bounds) - CGRectGetMaxX(gap), CGRectGetMaxY(bounds)};
		
		const CGRect rects[] = {leftClipRect, rightClipRect};
		CGContextClipToRects(ctx, rects, 2);
	}
	
	UIRectFill(bounds);
	UIGraphicsPopContext();
}




static __attribute__((constructor)) void _logosLocalCtor_fdbd8d16() {
    {{Class _logos_class$_ungrouped$CKEntity = objc_getClass("CKEntity"); MSHookMessageEx(_logos_class$_ungrouped$CKEntity, @selector(addressHash), (IMP)&_logos_method$_ungrouped$CKEntity$addressHash, (IMP*)&_logos_orig$_ungrouped$CKEntity$addressHash);Class _logos_class$_ungrouped$CKServiceView = objc_getClass("CKServiceView"); { const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(updateTitleLabel), (IMP)&_logos_method$_ungrouped$CKServiceView$updateTitleLabel, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(service), (IMP)&_logos_method$_ungrouped$CKServiceView$service, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(textLabel), (IMP)&_logos_method$_ungrouped$CKServiceView$textLabel, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKServiceView, @selector(setService:), (IMP)&_logos_method$_ungrouped$CKServiceView$setService$, (IMP*)&_logos_orig$_ungrouped$CKServiceView$setService$);{ const char *_typeEncoding = "d@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(shouldShowDashedLine), (IMP)&_logos_method$_ungrouped$CKServiceView$shouldShowDashedLine, _typeEncoding); }{ const char *_typeEncoding = "v@:d"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(setShouldShowDashedLine:), (IMP)&_logos_method$_ungrouped$CKServiceView$setShouldShowDashedLine$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(entity), (IMP)&_logos_method$_ungrouped$CKServiceView$entity, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(setEntity:), (IMP)&_logos_method$_ungrouped$CKServiceView$setEntity$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(dateLabel), (IMP)&_logos_method$_ungrouped$CKServiceView$dateLabel, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(setDateLabel:), (IMP)&_logos_method$_ungrouped$CKServiceView$setDateLabel$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(date), (IMP)&_logos_method$_ungrouped$CKServiceView$date, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKServiceView, @selector(setDate:), (IMP)&_logos_method$_ungrouped$CKServiceView$setDate$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKServiceView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$CKServiceView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$CKServiceView$layoutSubviews);Class _logos_class$_ungrouped$CKTranscriptToolbarView = objc_getClass("CKTranscriptToolbarView"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptToolbarView, @selector(contactButton), (IMP)&_logos_method$_ungrouped$CKTranscriptToolbarView$contactButton, _typeEncoding); }Class _logos_class$_ungrouped$CKTranscriptController = objc_getClass("CKTranscriptController"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(recipientListView), (IMP)&_logos_method$_ungrouped$CKTranscriptController$recipientListView, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(transcriptToolbarView), (IMP)&_logos_method$_ungrouped$CKTranscriptController$transcriptToolbarView, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(didSelectContactButtonPad:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$didSelectContactButtonPad$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptController, @selector(updateActionItem), (IMP)&_logos_method$_ungrouped$CKTranscriptController$updateActionItem, (IMP*)&_logos_orig$_ungrouped$CKTranscriptController$updateActionItem);MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptController, @selector(_computeBubbleData:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$_computeBubbleData$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptController$_computeBubbleData$);MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptController, @selector(_handlePreferredServiceChangedNotification:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptController$_handlePreferredServiceChangedNotification$);{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(showPendingDividerIfNecessaryForRecipient:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$showPendingDividerIfNecessaryForRecipient$, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(selectAddressForCurrentRecipientFromView:asPopover:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$selectAddressForCurrentRecipientFromView$asPopover$, _typeEncoding); }{ const char *_typeEncoding = "v@:@@"; class_addMethod(_logos_class$_ungrouped$CKTranscriptController, @selector(recipientSelectionView:selectAddressForAtom:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$recipientSelectionView$selectAddressForAtom$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptController, @selector(tableView:willDisplayCell:forRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptController$tableView$willDisplayCell$forRowAtIndexPath$);Class _logos_class$_ungrouped$CKTranscriptBubbleData = objc_getClass("CKTranscriptBubbleData"); { const char *_typeEncoding = "d@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(_indexOfPendingService), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$_indexOfPendingService, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(pendingService), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$pendingService, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(setPendingService:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$setPendingService$, _typeEncoding); }{ const char *_typeEncoding = "@@:d"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(lastMessageFromIndex:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$lastMessageFromIndex$, _typeEncoding); }{ const char *_typeEncoding = "@@:d"; class_addMethod(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(nextMessageFromIndex:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$nextMessageFromIndex$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(_appendDateForMessageIfNeeded:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendDateForMessageIfNeeded$);MSHookMessageEx(_logos_class$_ungrouped$CKTranscriptBubbleData, @selector(_appendServiceForMessageIfNeeded:), (IMP)&_logos_method$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$, (IMP*)&_logos_orig$_ungrouped$CKTranscriptBubbleData$_appendServiceForMessageIfNeeded$);Class _logos_class$_ungrouped$CKConversationList = objc_getClass("CKConversationList"); MSHookMessageEx(_logos_class$_ungrouped$CKConversationList, @selector(aggregateConversationForRecipients:create:), (IMP)&_logos_method$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$, (IMP*)&_logos_orig$_ungrouped$CKConversationList$aggregateConversationForRecipients$create$);MSHookMessageEx(_logos_class$_ungrouped$CKConversationList, @selector(existingConversationForAddresses:), (IMP)&_logos_method$_ungrouped$CKConversationList$existingConversationForAddresses$, (IMP*)&_logos_orig$_ungrouped$CKConversationList$existingConversationForAddresses$);Class _logos_class$_ungrouped$CKAggregateConversation = objc_getClass("CKAggregateConversation"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(selectedRecipient), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$selectedRecipient, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(setSelectedRecipient:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$setSelectedRecipient$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(pendingMessage), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$pendingMessage, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(setPendingMessage:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$setPendingMessage$, _typeEncoding); }{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(allAddresses), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$allAddresses, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(_subConversationForService:create:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_subConversationForService$create$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$_subConversationForService$create$);MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(_bestExistingConversation), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversation, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$_bestExistingConversation);{ const char *_typeEncoding = "@@:@"; class_addMethod(_logos_class$_ungrouped$CKAggregateConversation, @selector(_bestExistingConversationWithService:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$_bestExistingConversationWithService$, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(isAggregatableWithConversation:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$isAggregatableWithConversation$);MSHookMessageEx(_logos_class$_ungrouped$CKAggregateConversation, @selector(addMessage:incrementUnreadCount:), (IMP)&_logos_method$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$, (IMP*)&_logos_orig$_ungrouped$CKAggregateConversation$addMessage$incrementUnreadCount$);Class _logos_class$_ungrouped$CKSMSService = objc_getClass("CKSMSService"); MSHookMessageEx(_logos_class$_ungrouped$CKSMSService, @selector(newMessageWithComposition:forConversation:), (IMP)&_logos_method$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$, (IMP*)&_logos_orig$_ungrouped$CKSMSService$newMessageWithComposition$forConversation$);Class _logos_class$_ungrouped$CKMadridService = objc_getClass("CKMadridService"); MSHookMessageEx(_logos_class$_ungrouped$CKMadridService, @selector(newMessageWithComposition:forConversation:), (IMP)&_logos_method$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$, (IMP*)&_logos_orig$_ungrouped$CKMadridService$newMessageWithComposition$forConversation$);Class _logos_class$_ungrouped$CKRecipientSelectionView = objc_getClass("CKRecipientSelectionView"); { const char *_typeEncoding = "v@:@@"; class_addMethod(_logos_class$_ungrouped$CKRecipientSelectionView, @selector(composeRecipientView:showPersonCardForAtom:), (IMP)&_logos_method$_ungrouped$CKRecipientSelectionView$composeRecipientView$showPersonCardForAtom$, _typeEncoding); }Class _logos_class$_ungrouped$MFComposeRecipientAtom = objc_getClass("MFComposeRecipientAtom"); MSHookMessageEx(_logos_class$_ungrouped$MFComposeRecipientAtom, @selector(initWithFrame:recipient:style:), (IMP)&_logos_method$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$, (IMP*)&_logos_orig$_ungrouped$MFComposeRecipientAtom$initWithFrame$recipient$style$);{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$_ungrouped$MFComposeRecipientAtom, @selector(handleLongPressGesture:), (IMP)&_logos_method$_ungrouped$MFComposeRecipientAtom$handleLongPressGesture$, _typeEncoding); }Class _logos_class$_ungrouped$CKPreferredServiceManager = objc_getClass("CKPreferredServiceManager"); { const char *_typeEncoding = "@:@@pp"; class_addMethod(_logos_class$_ungrouped$CKPreferredServiceManager, @selector(preferredServiceForSelectedRecipient:withAggregateConversation:canSend:error:), (IMP)&_logos_method$_ungrouped$CKPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$, _typeEncoding); }Class _logos_class$_ungrouped$CKMessagesAppPreferredServiceManager = objc_getClass("CKMessagesAppPreferredServiceManager"); MSHookMessageEx(_logos_class$_ungrouped$CKMessagesAppPreferredServiceManager, @selector(preferredServiceForSelectedRecipient:withAggregateConversation:canSend:error:), (IMP)&_logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$, (IMP*)&_logos_orig$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForSelectedRecipient$withAggregateConversation$canSend$error$);MSHookMessageEx(_logos_class$_ungrouped$CKMessagesAppPreferredServiceManager, @selector(preferredServiceForAggregateConversation:newComposition:checkWithServer:canSend:error:), (IMP)&_logos_method$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$, (IMP*)&_logos_orig$_ungrouped$CKMessagesAppPreferredServiceManager$preferredServiceForAggregateConversation$newComposition$checkWithServer$canSend$error$);}}
    if ([MGTranscriptHeaderContext shouldOverrideHeader]) {
        {Class _logos_class$FloatingHeader$CKTranscriptHeaderView = objc_getClass("CKTranscriptHeaderView"); MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptHeaderView, @selector(initWithFrame:isPhoneTranscript:displayLoadPrevious:isGroupMessage:), (IMP)&_logos_method$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptHeaderView$initWithFrame$isPhoneTranscript$displayLoadPrevious$isGroupMessage$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptHeaderView, @selector(layoutSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptHeaderView$layoutSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptHeaderView$layoutSubviews);Class _logos_class$FloatingHeader$CKTranscriptTableView = objc_getClass("CKTranscriptTableView"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptTableView, @selector(updateBlock), (IMP)&_logos_method$FloatingHeader$CKTranscriptTableView$updateBlock, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptTableView, @selector(setUpdateBlock:), (IMP)&_logos_method$FloatingHeader$CKTranscriptTableView$setUpdateBlock$, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptTableView, @selector(layoutSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptTableView$layoutSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptTableView$layoutSubviews);Class _logos_class$FloatingHeader$CKTranscriptController = objc_getClass("CKTranscriptController"); { const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(headerContext), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$headerContext, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(updateTranscriptHeaderInset), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$updateTranscriptHeaderInset, _typeEncoding); }{ const char *_typeEncoding = "v@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(updateHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$updateHeaderView, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(loadView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$loadView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$loadView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewWillUnload), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewWillUnload, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewWillUnload);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewWillAppear:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewWillAppear$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewWillAppear$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(viewDidAppear:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$viewDidAppear$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$viewDidAppear$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(willRotateToInterfaceOrientation:duration:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$willRotateToInterfaceOrientation$duration$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(didRotateFromInterfaceOrientation:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$didRotateFromInterfaceOrientation$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(willAnimateRotationToInterfaceOrientation:duration:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$willAnimateRotationToInterfaceOrientation$duration$);{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(didSelectContactButton:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$didSelectContactButton$, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_showTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_showTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_hideTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_hideTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_updateTranscriptHeaderView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_updateTranscriptHeaderView);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(setEditing:animated:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$setEditing$animated$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$setEditing$animated$);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_updateBackPlacardSubviews), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_updateBackPlacardSubviews);MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(reload:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$reload$, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$reload$);{ const char *_typeEncoding = "@@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(backPlacardView), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$backPlacardView, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewDidScroll:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewDidScroll$, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewDidEndDecelerating:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewDidEndDecelerating$, _typeEncoding); }{ const char *_typeEncoding = "v@:@{CGPoint=ff}^{CGPoint=ff}"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$scrollViewWillEndDragging$withVelocity$targetContentOffset$, _typeEncoding); }{ const char *_typeEncoding = "v@:@"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(keyboardFrameWillChange:), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$keyboardFrameWillChange$, _typeEncoding); }{ const char *_typeEncoding = "c@:"; class_addMethod(_logos_class$FloatingHeader$CKTranscriptController, @selector(keyboardIsReallyOnScreen), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$keyboardIsReallyOnScreen, _typeEncoding); }MSHookMessageEx(_logos_class$FloatingHeader$CKTranscriptController, @selector(_resetTranscriptInsets), (IMP)&_logos_method$FloatingHeader$CKTranscriptController$_resetTranscriptInsets, (IMP*)&_logos_orig$FloatingHeader$CKTranscriptController$_resetTranscriptInsets);}
    }
	
	if (ShouldMergeServiceAndDateLabels()) {
		{Class _logos_class$DashedLineFixPad$CKDashedLineView = objc_getClass("CKDashedLineView"); MSHookMessageEx(_logos_class$DashedLineFixPad$CKDashedLineView, @selector(drawRect:), (IMP)&_logos_method$DashedLineFixPad$CKDashedLineView$drawRect$, (IMP*)&_logos_orig$DashedLineFixPad$CKDashedLineView$drawRect$);}
	}
}
