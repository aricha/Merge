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

%group FloatingHeader
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
        if (button) {
            [button removeFromSuperview];
        }
        
        CGRect bounds = self.frame;
        bounds.size.height = [CKTranscriptHeaderView defaultHeight];
        self.frame = bounds;
    }
    
    return self;
}

//- (void)setFrame:(CGRect)frame
//{
//    if (frame.origin.y == 0 && self.frame.origin.y != 0)
//        LOG_BACKTRACE;
//    
//    %orig;
//}

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
- (void)updateHeaderView;
- (MGTranscriptHeaderContext *)headerContext;
- (void)updateTranscriptHeaderInset;
- (UIView *)backPlacardView;
@end

%hook CKTranscriptController

%new(@@:)
- (MGTranscriptHeaderContext *)headerContext
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
- (void)updateTranscriptHeaderInset
{
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    
    UIEdgeInsets insets = self.transcriptTable.scrollIndicatorInsets;
    insets.top = (!header || header.hidden ? 0 : header.frame.size.height);
    self.transcriptTable.scrollIndicatorInsets = insets;
}

%new(v@:)
- (void)updateHeaderView
{
    CGFloat offset = self.transcriptTable.contentOffset.y;
    
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    CGFloat relativeHeaderOffset = header.frame.origin.y + offset;
    CGFloat headerHeight = header.frame.size.height;
    
    header.layer.shadowOpacity = (self.editing && offset <= headerHeight ? 0.0 : MIN((relativeHeaderOffset / headerHeight), 1.0));
    
    [self updateTranscriptHeaderInset];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

//- (void)viewDidLoad
//{
//    %orig;
//    
//#warning Testing code
//    UINavigationController *navController = MSHookIvar<id>(self, "_navigationController");
//    if (navController) {
//        UISwipeGestureRecognizer *swipeUp = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeUpOnNavBar:)] autorelease];
//        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//        [navController.navigationBar addGestureRecognizer:swipeUp];
//    }
//}

%new(v@:@)
- (void)didSwipeUpOnNavBar:(UISwipeGestureRecognizer *)gesture
{
    %log;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillUnload
{
    %orig;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillChangeFrameNotification
                                                  object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    %orig;
    
//    [[self headerContext] updateHeaderOffsetForContentOffset:self.transcriptTable.contentOffset.y force:YES];
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    
//    MGTranscriptHeaderContext *context = [self headerContext];
//    [context setHeaderVisible:context.headerVisible animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    %orig;
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
    DLog(@"viewDidAppear, visibleOffset: %f, contentOffset: %f", [[self headerContext] visibleOffset], self.transcriptTable.contentOffset.y);
}

- (void)_setupTranscriptHeader {
    %log;
    %orig;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    MGTranscriptHeaderContext *context = [self headerContext];
    [context beginIgnoringContentOffsetChanges];
    context.rotatingHeaderOffset = context.headerOffset;
    
    %orig;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    %orig;
    [[self headerContext] endIgnoringContentOffsetChanges];
    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//    [[self headerContext] updateHeaderOffsetForContentOffset:self.transcriptTable.contentOffset.y force:YES];
    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

- (void)_showTranscriptHeaderView {
    %orig;
    %log;
    
    CKTranscriptHeaderView *header = MSHookIvar<id>(self, "_transcriptHeaderView");
    if (header) {
        MGTranscriptHeaderContext *context = [self headerContext];
        context.headerView = header;
        
//        self.transcriptTable.tableHeaderView = nil;
//        CGFloat tableHeaderHeight = (header.hasMoreMessages ? 2 : 1) * [CKTranscriptHeaderView defaultHeight];
//        CGFloat tableHeaderWidth = self.transcriptTable.frame.size.width;
        CGFloat tableWidth = self.transcriptTable.frame.size.width;
        CGSize tableHeaderSize = [header sizeThatFits:CGSizeMake(tableWidth, 2*[CKTranscriptHeaderView defaultHeight])];
        CGRect tableHeaderFrame = (CGRect){CGPointZero, tableHeaderSize};
        
        UIView *tableHeaderView = [[[UIView alloc] initWithFrame:tableHeaderFrame] autorelease];
        tableHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        tableHeaderView.backgroundColor = [CKTranscriptTableView tableColor];
        
        UIPlacardButton *button = MSHookIvar<id>(header, "_loadMoreButton");
        if (button && header.hasMoreMessages) {
//            [self.transcriptTable addSubview:button];
//            self.transcriptTable.tableHeaderView = button;
            
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

- (void)_hideTranscriptHeaderView {
    %log;
    
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
    
    %orig;
}

- (void)_updateTranscriptHeaderView
{
    %log;
    %orig;
    
    [self.view addSubview:[self headerContext].headerView];
    self.transcriptTable.tableHeaderView = [self headerContext].tableHeaderView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    BOOL prevEditing = [self.transcriptTable isEditing];
    
    %log;
    %orig;
    
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
    
//    if (!editing) {
//        [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
//    }
}

- (void)_updateBackPlacardSubviews
{
    %log;
    %orig;
    
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    [[self backPlacardView] bringSubviewToFront:header];
}

- (void)reload:(BOOL)reload
{
    %orig;
    %log;
    
    [[self headerContext] updateVisibleOffsetForActiveHeaderOffset];
}

%new(@@:)
- (UIView *)backPlacardView
{
    UIView *view = MSHookIvar<id>(self, "_backPlacard");
    
    // to avoid null msgSend crashes
    return (view == NULL ? nil : view);
}

%new(v@:@)
- (void)scrollViewDidScroll:(UIScrollView *)sv {
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

%new(v@:@)
- (void)keyboardFrameWillChange:(NSNotification *)note
{
    CGRect unconvertedKBFrame = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect kbFrame = [self.view convertRect:unconvertedKBFrame fromView:nil];
        
    CGFloat kbHeight = kbFrame.size.height - [self _accessoryViewHeight];
    BOOL keyboardVisible = (kbHeight > 0);
    
    [self headerContext].keyboardVisible = keyboardVisible;
}

%new(c@:)
- (BOOL)keyboardIsReallyOnScreen
{
    CGFloat accessoryHeight = [self _accessoryViewHeight];
    CGFloat kbHeight = [self _distanceFromBottomOfScreenToTopEdgeOfKeyboard];
    
    return (kbHeight - accessoryHeight > 0);
}

- (void)_resetTranscriptInsets
{
    %orig;
    
    [self updateTranscriptHeaderInset];
}

%end
%end

@interface CKTranscriptBubbleData ()

//@property (nonatomic, retain) CKMessage *pendingMessage;
@property (nonatomic) BOOL sendingMessage;
-(NSMutableArray *)_bubbleDataArray;

@end

@interface CKAggregateConversation ()

@property (nonatomic, retain) CKEntity *selectedRecipient;
@property (nonatomic, copy) void (^didAddMessageBlock)(CKMessage *message, CKAggregateConversation *conversation);
@property (nonatomic, retain) CKMessage * pendingMessage;

-(CKSubConversation *)_bestExistingConversationWithService:(CKService *)service;

@end

%hook CKEntity

- (NSUInteger)addressHash
{
    NSUInteger hash = MSHookIvar<NSUInteger>(self, "_addressHash");
    if (hash == 0) {
        ABRecordRef record = self.abRecord;
        if (record != NULL) {
            ABRecordID recordID = ABRecordGetRecordID(record);
            hash = (NSUInteger)recordID;
        }
        else {
            hash = %orig;
        }
//        NSLog(@"hash: %u for record %p with entity %@", hash, record, self);
    }
    return hash;
}

%end

//%hook _CKConversation
//
//-(NSUInteger)recipientsHash
//{
//    NSUInteger hash = MSHookIvar<NSUInteger>(self, "_recipientHash");
//    if (hash == 0) {
//        for (CKEntity *entity in [self recipients]) {
//            hash = hash ^ entity.addressBookUID;
//        }
//        NSLog(@"calculated hash %u for recipients %@", hash, [self recipients]);
//    }
//
//    return hash;
//}
//
//%end

//@interface MGAddressView ()
@interface CKServiceView ()

- (void)updateTitleLabel;
- (CKService *)service;
- (UILabel *)textLabel;
- (CKEntity *)entity;
- (void)setEntity:(CKEntity *)entity;

@end

//%subclass MGAddressView : CKServiceView
%hook CKServiceView

%new(v@:)
- (void)updateTitleLabel
{
    NSMutableString *labelText = [NSMutableString string];
    CKEntity *entity = [self entity];
    CKService *service = [self service];
    
//    if (entity) {
//        labelText = entity.normalizedRawAddress;
//    }
//    if (service) {
//        NSString *serviceText = (entity ? @" - " : @"");
//        serviceText = [serviceText stringByAppendingString:[service displayName]];
//        
//        labelText = [labelText stringByAppendingString:serviceText];
//    }
    
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

%new(@@:)
- (CKService *)service
{
    CKService *service = MSHookIvar<id>(self, "_service");
    return (service ? service : nil);
}

%new(@@:)
- (UILabel *)textLabel
{
    UILabel *label = MSHookIvar<id>(self, "_label");
    return (label ? label : nil);
}

- (void)setService:(CKService *)service
{
    if ([self service] != service) {
//        [[self service] release];
//#warning may be hacky
//        MSHookIvar<id>(self, "_service") = service;
        if (!service || [service isKindOfClass:%c(CKService)]) {
            %orig;
        }
        else if ([service isKindOfClass:%c(CKEntity)]) {
            [self setEntity:(CKEntity *)service];
        }
        
        [self updateTitleLabel];
    }
}
static NSString *const MGAddressViewEntityKey = @"MGAddressViewEntityKey";

%new(@@:)
- (CKEntity *)entity
{
    return objc_getAssociatedObject(self, MGAddressViewEntityKey);
}

%new(v@:@)
- (void)setEntity:(CKEntity *)entity
{
    objc_setAssociatedObject(self, MGAddressViewEntityKey, entity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updateTitleLabel];
}

%end

extern NSString *const CKBubbleDataMessage;

#define FLAG_NEW_RECIPIENT (1 << 5)

%hook CKTranscriptController

//-(void)sendMessage:(id)message
//{
//    NSMutableArray *recipients = MSHookIvar<id>(self, "_newCompositionRecipients");
//    if (!recipients) {recipients = nil;}
////    [recipients addObject:@""];
//    unsigned flags = MSHookIvar<unsigned>(self, "_newRecipient");
//    NSLog(@"sending message to recipients: %@, message: %@, _newRecipient: %u, isNewRecipient: %d, attempted: %u", recipients, message, flags, [self isNewRecipient], (flags & FLAG_NEW_RECIPIENT));
//    BOOL isNewRecipient = [self isNewRecipient];
//    
//    // enable new recipients temporarily
//    flags |= FLAG_NEW_RECIPIENT;
//    if (recipients.count == 0) {
//        recipients
//    }
//    
//    %orig;
//}

-(void)tableView:(id)view willDisplayCell:(id)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    %orig;
    if ([cell isKindOfClass:%c(CKServiceView)]) {
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
        
//        NSLog(@"recipients: %@ for index %@, message: %@", [message.conversation recipients], indexPath, [message text]);
        CKEntity *entity = [message.conversation recipient];
        if (!entity) {
            NSLog(@"error: could not find entity for CKServiceView at indexPath %@", indexPath);
        }
        
        [(CKServiceView *)cell setEntity:entity];
//        [(CKServiceView *)cell setService:message.service];
    }
}

//-(void)_startCreatingNewMessageForSending:(CKMessageStandaloneComposition *)composition
//{
//    NSLog(@"creating composition %@", composition);
//    
////    CKTranscriptBubbleData *data = [self bubbleData];
////    data.pendingMessage = message;
////    data.sendingMessage = YES;
////    CKAggregateConversation *aggregateConversation = [self conversation];
////    aggregateConversation.didAddMessageBlock = ^(CKMessage *message, CKAggregateConversation *conversation) {
////        NSLog(@"added new message, message conversation: %@, selected recipient: %@", message.conversation, conversation.selectedRecipient);
////#warning TODO: insert address divider as a new cell if necessary
////        
////        [[self transcriptTable] beginUpdates];
////        int index = [[self bubbleData] _appendServiceForMessageIfNeeded:message];
////        NSLog(@"message index: %d, insert index: %d", [[self bubbleData] indexForMessage:message], index);
////        if (index != NSNotFound) {
////            [[self transcriptTable] insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
////        }
////        [[self transcriptTable] endUpdates];
//////        if (index != NSNotFound) {
//////            [[self transcriptTable] reloadData];
//////        }
////    };
//    
//    %orig;
//    
////    data.sendingMessage = NO;
//}

%end

%hook CKTranscriptBubbleData

//static NSString *const MGBubbleDataPendingMessageKey = @"MGBubbleDataPendingMessageKey";
static NSString *const MGBubbleDataSendingMessageKey = @"MGBubbleDataSendingMessageKey";

%new(@@:)
- (BOOL)sendingMessage
{
    NSNumber *sending = objc_getAssociatedObject(self, MGBubbleDataSendingMessageKey);\
    if (sending)
        return [sending boolValue];
    else
        return NO;
}

%new(v@:@)
- (void)setSendingMessage:(BOOL)sendingMessage
{
    NSNumber *sending = [NSNumber numberWithBool:sendingMessage];
    objc_setAssociatedObject(self, MGBubbleDataSendingMessageKey, sending, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//%new(v@:@)
//- (void)setPendingMessage:(CKMessage *)message
//{
//    objc_setAssociatedObject(self, MGBubbleDataPendingMessageKey, message, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//%new(@@:)
//- (CKEntity *)pendingMessage
//{
//    return objc_getAssociatedObject(self, MGBubbleDataPendingMessageKey);
//}

%new(@@:)
-(NSMutableArray *)_bubbleDataArray
{
    NSMutableArray *array = MSHookIvar<id>(self, "_bubbleDataArray");
    return (array ? array : nil);
}

-(int)_appendServiceForMessageIfNeeded:(CKMessage *)message
{
    NSInteger response = %orig;
    if (response == NSNotFound && [message conversation]) { //![self sendingMessage]) {
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
        
//        NSLog(@"appending service for message \"%@\" with recipients: %@ groupID: %@, conversation: %@, aggregate: %@, placeholder: %d \n prevMessage \"%@\" recipients: %@ groupID: %@, conversation: %@, aggregate: %@", [message text], [message.conversation recipients], [message.conversation groupID], message.conversation, message.conversation.aggregateConversation, [message isPlaceholder], [prevMessage text], [prevMessage.conversation recipients], [prevMessage.conversation groupID], prevMessage.conversation, prevMessage.conversation.aggregateConversation);
        
        if ([prevMessage conversation]) {
            BOOL sameAddress = ([[message.conversation recipients] isEqual:[prevMessage.conversation recipients]]);
            
            if (!sameAddress) {
                response = [self _appendService:message.service];
            }
        }
    }
    return response;
}

%end

%hook NSObject

- (void)doesNotRecognizeSelector:(SEL)sel
{
    LOG_BACKTRACE;
    %orig;
}

%end

//%hook CKMadridService
//
//-(void)sendMessage:(CKMessage *)message
//{
//    NSLog(@"sending message %@ with conversation %@ and recipients %@ and aggregate %@", message, message.conversation, message.conversation.recipients, message.conversation.aggregateConversation);
//    %orig;
//}
//
//%end

%hook CKConversationList

//-(id)existingAggregateConversationForAddresses:(id)addresses
//{
//    id conversation = %orig;
//    NSLog(@"existingAggregate: %@ for addresses: %@", conversation, addresses);
//    return conversation;
//}

-(CKAggregateConversation *)aggregateConversationForRecipients:(NSArray *)recipients create:(BOOL)create
{
    CKAggregateConversation *conversation = %orig;
//    NSLog(@"aggregate for recipients: %@ is %@; shouldCreate: %d", recipients, conversation, create);
    
    if (recipients.count == 1) {
        conversation.selectedRecipient = [recipients objectAtIndex:0];
    }
    
    return conversation;
}

-(id)existingConversationForAddresses:(NSArray *)addresses
{
    CKSubConversation *conversation = %orig;
    if (conversation && conversation.recipients.count == 1) {
        NSLog(@"conversation: %@, aggregate: %@", conversation, conversation.aggregateConversation);
        conversation.aggregateConversation.selectedRecipient = [conversation.recipients objectAtIndex:0];
    }
    return conversation;
}

%end

%hook CKAggregateConversation

//-(id)recipients
//{
//    id recipients = %orig;
//    NSLog(@"recipients: %@ for convo: %@", recipients, self);
//    return recipients;
//}

static NSString *const MGDidAddMessageBlockKey = @"MGDidAddMessageBlockKey";
static NSString *const MGSelectedRecipientKey = @"MGSelectedRecipientKey";

%new(v@:@)
- (void)setDidAddMessageBlock:(void (^)(CKMessage *message, CKAggregateConversation *conversation))block
{
    objc_setAssociatedObject(self, MGDidAddMessageBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

%new(@@:)
- (void (^)(CKMessage *, CKAggregateConversation *))didAddMessageBlock
{
    return objc_getAssociatedObject(self, MGDidAddMessageBlockKey);
}

%new(v@:@)
- (void)setSelectedRecipient:(CKEntity *)recipient
{
//    void (^selectedRecipientChangedBlock)(CKMessage *, CKAggregateConversation *) = [self selectedRecipientChangedBlock];
//    BOOL didChange = (recipient != [self selectedRecipient]);
    
//    NSLog(@"old selected: %@, new selected: %@", [self selectedRecipient], recipient);
    
    objc_setAssociatedObject(self, MGSelectedRecipientKey, recipient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
//    if (didChange && selectedRecipientChangedBlock) {
//        selectedRecipientChangedBlock([self pendingMessage], self);
//    }
}

%new(@@:)
- (CKEntity *)selectedRecipient
{
    return objc_getAssociatedObject(self, MGSelectedRecipientKey);
}

static NSString *const MGPendingMessageKey = @"MGPendingMessageKey";

%new(@@:)
- (CKMessage *)pendingMessage
{
    return objc_getAssociatedObject(self, MGPendingMessageKey);
}

%new(v@:@)
- (void)setPendingMessage:(CKMessage *)pendingMessage
{
    objc_setAssociatedObject(self, MGPendingMessageKey, pendingMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)_subConversationForService:(id)service create:(BOOL)create
{
    CKSubConversation *conversation = [self _bestExistingConversationWithService:service];
    if (!conversation) {
        conversation = %orig;
    }
//    NSLog(@"found subConversation %@ for service %@, shouldCreate: %d, aggregate: %@", conversation, service, create, self);
    return conversation;
}

-(id)_bestExistingConversation
{
    CKSubConversation *conversation = [self _bestExistingConversationWithService:nil];
    if (!conversation) {
        conversation = %orig;
    }
//    NSLog(@"found bestExistingConversation %@ for aggregate %@", conversation, self);
    return conversation;
}

%new(@@:@)
-(CKSubConversation *)_bestExistingConversationWithService:(CKService *)service
{
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
                // ignore conversations that don't match
//                NSLog(@"conversation %@ does not match service %@, ignoring!", conversation, service);
                continue;
            }
            
            if ([[conversation recipients] containsObject:selectedRecipient]) {
//                NSLog(@"found selectedRecipient %@ in subConversation %@", selectedRecipient, conversation);
                selectedConversation = conversation;
                break;
            }
            
            if (!sequenceNum) {
                // placeholder (pending) message
//                NSLog(@"found conversation %@ with latestMessage %@ with no sequence number!", conversation, latestMessage);
                
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
        
//        NSLog(@"found mostRecentConversation %@, selectedConversation %@, pending messages: %@", mostRecentConversation, selectedConversation, mostRecentConversation.aggregateConversation.pendingMessages);
        
        return (selectedConversation ? selectedConversation : mostRecentConversation);
    }
    else {
        return nil;
    }
}

-(BOOL)isAggregatableWithConversation:(CKSubConversation *)conversation
{
    BOOL isAggregatable = ([conversation recipientsHash] == [self recipientsHash]);
    
    return isAggregatable;
}

-(int)addMessage:(CKMessage *)message incrementUnreadCount:(BOOL)count
{
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
    
//    NSLog(@"adding message %@ placeholder: %d, with conversation %@, recipients: %@, outgoing: %d, containsMessage: %d", message, [message isPlaceholder], message.conversation, message.conversation.recipients, [message isOutgoing], containsMessage);
//    self.pendingMessage = message;
    int result = %orig;
    
    if ([message isOutgoing] && [message conversation].recipients.count == 1) {
        self.selectedRecipient = [[message conversation].recipients objectAtIndex:0];
        
        if ([self didAddMessageBlock]) {
            [self didAddMessageBlock](message, self);
        }
    }
//    NSLog(@"result: %d for message %@ with conversation %@", result, message, message.conversation);
    return result;
}

//-(NSUInteger)recipientsHash
//{
//    NSUInteger hash = MSHookIvar<NSUInteger>(self, "_recipientHash");
//    if (hash == 0) {
//        for (CKSubConversation *convo in self.subConversations) {
//            for (CKEntity *recipient in convo.recipients) {
//                hash = hash ^ recipient.addressHash;
//            }
//        }
//        NSLog(@"calculated hash %u", hash);
//    }
//
//    return hash;
//}

%end

%hook CKMadridService

-(id)newMessageWithComposition:(id)composition forConversation:(CKSubConversation *)conversation
{
    %log;
    CKMessage *message = %orig;
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}

%end

%hook SMSApplication

- (void)handleURL:(NSURL *)url
{
    %log;
    %orig;
}

%end

%ctor {
    %init;
    if ([MGTranscriptHeaderContext shouldOverrideHeader]) {
        %init(FloatingHeader);
    }
}