// Logos by Dustin Howett
// See http://iphonedevwiki.net/index.php/Logos

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

@interface CKTranscriptHeaderView (BiteSMSFix)
@property (nonatomic, retain) UIPlacardButton *copyToClipboardButton;
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
- (CKServiceView *)pendingServiceViewIfVisible;
@end

@interface CKAggregateConversation ()
@property (nonatomic, retain) CKEntity *selectedRecipient;
@property (nonatomic, retain) CKMessage *pendingMessage;
- (CKSubConversation *)_bestExistingConversationWithService:(CKService *)service;
- (NSArray *)allAddresses;
- (BOOL)isCombinedConversation;
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

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

extern "C" BOOL CKIsRunningInSpringBoard(void);

extern "C" NSBundle *MGBundle(void)
{
	static NSBundle *mergeBundle = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		mergeBundle = [NSBundle bundleWithPath:@"/Library/Application Support/Merge/Merge.bundle"];
	});
	return mergeBundle;
}

static BOOL ShouldMergeServiceAndDateLabels()
{
	return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

%group FloatingHeader
%hook CKTranscriptHeaderView

static const int MGHeaderBackgroundImageViewTag = 17;

- (id)initWithFrame:(CGRect)frame isPhoneTranscript:(BOOL)transcript displayLoadPrevious:(BOOL)previous isGroupMessage:(BOOL)message
{
    self = %orig;
    
	CGFloat width = frame.size.width;
	BOOL isLandscape = (width - 320.0 >= (480.0 - 320.0) / 2); // just an approximation to cover all cases
	NSString *bgName = (isLandscape ? @"header_bg_landscape" : @"header_bg");
	UIImage *bgImg = [UIImage imageNamed:bgName inBundle:MGBundle()];
	if (bgImg) {
		UIImageView *bg = [[[UIImageView alloc] initWithImage:bgImg] autorelease];
		bg.frame = self.bounds;
		bg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		bg.tag = MGHeaderBackgroundImageViewTag;
		[self addSubview:bg];
		[self sendSubviewToBack:bg];
		
		for (UIView *view in self.subviews) {
			if ([view isKindOfClass:[UIThreePartButton class]]) {
				[(UIThreePartButton *)view setBackgroundColor:[UIColor clearColor]];
			}
		}
	}
	
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

- (void)addSubview:(UIView *)subview
{
	// Fix for BiteSMS. This is so hacky...
	if ([subview isKindOfClass:[UIPlacardButton class]] &&
		[[(UIPlacardButton *)subview actionsForTarget:self forControlEvent:UIControlEventTouchUpInside] containsObject:@"_clipboardButtonClicked:"])
	{
		self.copyToClipboardButton = (UIPlacardButton *)subview;
	}
	else {
		%orig;
	}
}

- (void)layoutSubviews
{
    %orig;
    
    CGRect frame = self.frame;
    frame.size.height = [CKTranscriptHeaderView defaultHeight];
    self.frame = frame;
    
	static const CGFloat curveHeight = 8.0;
	
	CGFloat height = frame.size.height - 3.0f;
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointZero];
	[path addLineToPoint:CGPointMake(frame.size.width, 0)];
	[path addLineToPoint:CGPointMake(frame.size.width, height)];
	[path addQuadCurveToPoint:CGPointMake(0, height) controlPoint:CGPointMake(frame.size.width / 2, height + curveHeight)];
	[path closePath];
	
    self.layer.shadowPath = path.CGPath; //[UIBezierPath bezierPathWithRect:self.bounds].CGPath;
	
	if ([CKTranscriptController tableColor]) {
		self.backgroundColor = [CKTranscriptController tableColor];
	}
}

static NSString *const MGBiteSMSCopyToClipboardButtonKey = @"MGBiteSMSCopyToClipboardButtonKey";

%new(@@:)
- (UIPlacardButton *)copyToClipboardButton
{
    return objc_getAssociatedObject(self, MGBiteSMSCopyToClipboardButtonKey);
}

%new(v@:@)
- (void)setCopyToClipboardButton:(UIPlacardButton *)copyToClipboardButton
{
    objc_setAssociatedObject(self, MGBiteSMSCopyToClipboardButtonKey, copyToClipboardButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

%end

%hook CKTranscriptTableView

static NSString *const MGTranscriptTableViewLayoutBlockKey = @"MGTranscriptTableViewLayoutBlockKey";

%new(@@:)
- (void (^)(CKTranscriptTableView *))updateBlock
{
    return objc_getAssociatedObject(self, MGTranscriptTableViewLayoutBlockKey);
}

%new(v@:@)
- (void)setUpdateBlock:(void (^)(CKTranscriptTableView *))updateBlock
{
    objc_setAssociatedObject(self, MGTranscriptTableViewLayoutBlockKey, updateBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)layoutSubviews
{
    %orig;
    
    void (^updateBlock)(CKTranscriptTableView *) = self.updateBlock;
    if (updateBlock)
        updateBlock(self);
}

%end

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
		
		CKTranscriptHeaderView *header = [blockSelf headerContext].headerView;
		UIView *tableHeaderView = [blockSelf headerContext].tableHeaderView;
		UIPlacardButton *copyToClipboardButton = header.copyToClipboardButton;
		
		if (copyToClipboardButton && copyToClipboardButton.superview != tableHeaderView) {
			[tableHeaderView addSubview:header.copyToClipboardButton];
		}
    };
    self.transcriptTable.updateBlock = updateBlock;
    
    [[self headerContext] setScrollView:self.transcriptTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameWillChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
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
	%orig;
	
    MGTranscriptHeaderContext *context = [self headerContext];
    context.headerOffset = context.rotatingHeaderOffset;
    [context updateVisibleOffsetForActiveHeaderOffset];
}

%new(v@:@)
- (void)didSelectContactButton:(UIGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self selectAddressForCurrentRecipientFromView:self.view asPopover:NO];
	}
}

- (void)_showTranscriptHeaderView {
    %orig;
    
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
//            center.x = self.transcriptTable.frame.size.width / 2;
            button.center = center;
        }
		
		UIPlacardButton *contactButton = MSHookIvar<id>(header, "_contactsButton");
		if (contactButton)
		{
			UILongPressGestureRecognizer *gesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectContactButton:)] autorelease];
			[contactButton addGestureRecognizer:gesture];
		}
		
		if (![CKTranscriptController tableColor] && CKIsRunningInSpringBoard()) {
			// may be in IntelliScreenX, which uses UIImageView for background, so
			// attempt to use that for header background
			
			for (UIView *subview in self.view.subviews) {
				if ([subview isKindOfClass:[UIImageView class]] && subview.frame.size.width == self.view.frame.size.width) {
					UIColor *bgColor = [[UIColor colorWithPatternImage:[(UIImageView *)subview image]] colorWithAlphaComponent:subview.alpha];
					header.backgroundColor = bgColor;
					break;
				}
			}
		}
        
        context.tableHeaderView = tableHeaderView;
        
        self.transcriptTable.tableHeaderView = tableHeaderView;
        [header removeFromSuperview];
        [self.view addSubview:header];
        
        [self updateTranscriptHeaderInset];
    }
}

- (void)_hideTranscriptHeaderView {
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
    %orig;
    
    [self.view addSubview:[self headerContext].headerView];
    self.transcriptTable.tableHeaderView = [self headerContext].tableHeaderView;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    MGTranscriptHeaderContext *context = [self headerContext];
    CKTranscriptHeaderView *header = context.headerView;
    
    BOOL prevEditing = [self.transcriptTable isEditing];
    
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
    %orig;
    
    CKTranscriptHeaderView *header = [self headerContext].headerView;
    [[self backPlacardView] bringSubviewToFront:header];
}

- (void)reload:(BOOL)reload
{
    %orig;
    
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
//        DLog(@"hash: %u for record %p with entity %@", hash, record, self);
    }
    return hash;
}

%end

%hook CKServiceView

%new(v@:)
- (void)updateTitleLabel
{
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
		%orig;
        
        [self updateTitleLabel];
    }
}

static NSString *const MGAddressViewEntityKey = @"MGAddressViewEntityKey";
static NSString *const MGServiceViewDateLabelKey = @"MGServiceViewDateLabelKey";
static NSString *const MGServiceViewDateKey = @"MGServiceViewDateKey";
static NSString *const MGServiceViewShouldShowDashedLineKey = @"MGServiceViewShouldShowDashedLineKey";

%new(d@:)
- (BOOL)shouldShowDashedLine
{
    NSNumber *shouldShowDashedLine = objc_getAssociatedObject(self, MGServiceViewShouldShowDashedLineKey);
	return (shouldShowDashedLine ? [shouldShowDashedLine boolValue] : YES);
}

%new(v@:d)
- (void)setShouldShowDashedLine:(BOOL)shouldShowDashedLine
{
    objc_setAssociatedObject(self, MGServiceViewShouldShowDashedLineKey, @(shouldShowDashedLine), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
	[self setNeedsLayout];
}

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

%new(@@:)
- (UILabel *)dateLabel
{
    return objc_getAssociatedObject(self, MGServiceViewDateLabelKey);
}

%new(v@:@)
- (void)setDateLabel:(UILabel *)dateLabel
{
	[[self dateLabel] removeFromSuperview];
    objc_setAssociatedObject(self, MGServiceViewDateLabelKey, dateLabel,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	[self.contentView addSubview:dateLabel];
	[self setNeedsLayout];
}

%new(@@:)
- (NSDate *)date
{
    return objc_getAssociatedObject(self, MGServiceViewDateKey);
}

%new(v@:@)
- (void)setDate:(NSDate *)date
{
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

- (void)layoutSubviews
{
	%orig;
	
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

%end

%hook CKTranscriptToolbarView

%new(@@:)
- (UIButton *)contactButton
{
	UIButton *button = MSHookIvar<id>(self, "_contactButton");
	return (button ? button : nil);
}

%end

extern NSString *const CKBubbleDataMessage;

%hook CKTranscriptController

%new(@@:)
-(CKRecipientListView *)recipientListView
{
	id view = MSHookIvar<id>(self, "_recipientListView");
	return (view ? view : nil);
}

%new(@@:)
-(CKTranscriptToolbarView *)transcriptToolbarView
{
	CKTranscriptToolbarView *view = MSHookIvar<id>(self, "_transcriptToolbarView");
	return (view ? view : nil);
}

%new(v@:@)
-(void)didSelectContactButtonPad:(UIGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan) {
		[self selectAddressForCurrentRecipientFromView:gesture.view asPopover:YES];
	}
}

-(void)updateActionItem
{
	%orig;
	
	CKTranscriptToolbarView *toolbar = [self transcriptToolbarView];
	if (toolbar) {
		// add tap-and-hold gesture for top-right Contact button (on iPad)
		UILongPressGestureRecognizer *longPressGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectContactButtonPad:)] autorelease];
		UIButton *contactButton = [toolbar contactButton];
		[contactButton addGestureRecognizer:longPressGesture];
	}
}

-(void)_computeBubbleData:(BOOL)force
{
	%orig;
	
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
//			if (preferredService) {
//				[data _appendService:preferredService];
//			}
		}
	}
}

- (void)_handlePreferredServiceChangedNotification:(NSNotification *)notification
{
#ifdef DEBUG
	%log;
#endif
	
	%orig;
	
	CKTranscriptBubbleData *bubbleData = [self bubbleData];
	
	CKAggregateConversation *conversation = [self conversation];
	CKEntity *selectedRecipient = conversation.selectedRecipient;
	
	if (selectedRecipient) {
		CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] preferredServiceForSelectedRecipient:selectedRecipient
																											withAggregateConversation:conversation
																															  canSend:NULL
																																error:NULL];
		
		// only update pendingService if necessary (don't need to append service if
		// user hasn't manually changed addresses to send to)
		if (bubbleData.pendingService) {
			bubbleData.pendingService = preferredService;
			
			CKServiceView *pendingServiceView = [self pendingServiceViewIfVisible];
			if (pendingServiceView) {
				pendingServiceView.service = preferredService;
			}
		}
	}
}

%new(@@:)
- (CKServiceView *)pendingServiceViewIfVisible
{
	NSUInteger lastIndex = [[self bubbleData] _indexOfPendingService];
	NSIndexPath *lastServiceIndex = [NSIndexPath indexPathForRow:lastIndex inSection:0];
	CKServiceView *serviceView = (CKServiceView *)[[self transcriptTable] cellForRowAtIndexPath:lastServiceIndex];
	
	return serviceView;
}

%new(v@:@)
-(void)showPendingDividerIfNecessaryForRecipient:(CKEntity *)recipient
{
	CKTranscriptBubbleData *data = [self bubbleData];
	CKTranscriptTableView *tableView = [self transcriptTable];
	
	// _lastIndexExcludingTypingIndicator is actually an insertion index, so subtract 1 to get
	// actual last index
	NSUInteger lastIndex = [data _indexOfPendingService]; //[data _lastIndexExcludingTypingIndicator] - 1;
//	CKService *lastService = [data serviceAtIndex:lastIndex];
	CKService *lastService = [data pendingService];
	
//	DLog(@"last index: %d, lastService: %@", lastIndex, lastService);
	
//	CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] preferredServiceForSelectedRecipient:recipient
//																										withAggregateConversation:[self conversation]
//																												 canSend:NULL
//																												   error:NULL];
	CKService *preferredService = [[CKPreferredServiceManager sharedPreferredServiceManager] _preferredServiceForEntities:@[recipient] newComposition:YES checkWithServer:YES canSend:NULL error:NULL];
	
	DLog(@"preferredService: %@", preferredService);
	
	NSIndexPath *scrollIndex = nil;
	
	if (!lastService)
	{
		// add pending divider to indicate new address
		[tableView beginUpdates];
		
//		[data _appendService:preferredService];
		data.pendingService = preferredService;
		
		NSIndexPath *newIndex = [NSIndexPath indexPathForRow:(lastIndex + 1) inSection:0];
//		DLog(@"newIndex: %@, numRows: %d", newIndex, numRows);
		[tableView insertRowsAtIndexPaths:@[newIndex]
						 withRowAnimation:UITableViewRowAnimationAutomatic];
		[tableView endUpdates];
		
		scrollIndex = newIndex;
	}
	else
	{
		NSIndexPath *lastServiceIndex = [NSIndexPath indexPathForRow:lastIndex inSection:0];
//		CKServiceView *lastCell = (CKServiceView *)[tableView cellForRowAtIndexPath:lastServiceIndex];
		CKServiceView *lastCell = [self pendingServiceViewIfVisible];
		
		if (lastCell) {
			// pending divider already showing, update information if needed
			[lastCell setEntity:recipient];
			DLog(@"cell %@ exists! setting service to %@", lastCell, preferredService);
			[lastCell setService:preferredService];
		}
		else {
			scrollIndex = lastServiceIndex;
			
//			data.pendingService = preferredService;
//			NSMutableDictionary *serviceData = (NSMutableDictionary *)[[self bubbleData] bubbleDataForIndex:lastIndex];
//			DLog(@"serviceData: %@", serviceData);
//			[serviceData setObject:preferredService forKey:CKBubbleDataService];
		}
		
		data.pendingService = preferredService;
	}
	
	if (scrollIndex) {
		[tableView scrollToRowAtIndexPath:scrollIndex atScrollPosition:UITableViewScrollPositionBottom animated:YES];
		NSTimeInterval animationDuration = [tableView _contentOffsetAnimationDuration];
		
		// add extra 0.1 padding to ensure animation always completes (method seems to disable
		// UIView animations for a bit and so messes with scrolling animation)
		[self performSelector:@selector(_makeContentEntryViewActive) withObject:nil afterDelay:(animationDuration + 0.1)];
	}
	else {
		// no need to wait for animation if pending divider is already visible
		[self _makeContentEntryViewActive];
	}
	
	[self updateEntryView];
}

extern "C" void CKShowError(NSError *error);

%new(v@:)
-(void)selectAddressForCurrentRecipientFromView:(UIView *)view asPopover:(BOOL)popover
{
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
//    NSArray *addresses = [self.conversation allAddresses];
    
	DifferentiationSheetCompletionBlock completion = ^(NSString *selectedAddress, BOOL *performOriginalAction) {
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
					DLog(@"Error: conversation %@ NOT in current aggregate %@, its aggregate is %@", convo, self.conversation, convo.aggregateConversation);
					
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
	};
	
    [[MGAddressManager sharedAddressManager] presentDifferentiationSheetForContact:contact
                                                                            inView:view
																		 asPopover:popover
                                                                availableAddresses:nil
                                                                        completion:completion];
}

%new(v@:@@)
-(void)recipientSelectionView:(CKRecipientSelectionView *)view selectAddressForAtom:(MFComposeRecipientAtom *)atom
{
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

-(void)tableView:(CKTranscriptTableView *)view willDisplayCell:(CKServiceView *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    %orig;
    if ([cell isKindOfClass:[CKServiceView class]]) {
		CKEntity *entity = nil;
		NSDate *messageDate = nil;
		
		NSUInteger numRows = [[self transcriptTable] numberOfRowsInSection:indexPath.section];
		if (indexPath.row == numRows - 1)
		{
			// last row is service / address divider, treat as pending message
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

%end

extern NSString *const CKBubbleDataService;

%hook CKTranscriptBubbleData

static NSString *const MGBubbleDataPendingServiceKey = @"MGBubbleDataPendingServiceKey";

%new(d@:)
- (NSInteger)_indexOfPendingService
{
	// _lastIndexExcludingTypingIndicator is actually an insertion index, so subtract 1 to get
	// actual last index
	return ([self _lastIndexExcludingTypingIndicator] - 1);
}

%new(@@:)
- (CKService *)pendingService
{
//    return objc_getAssociatedObject(self, MGBubbleDataPendingServiceKey);
	return [self serviceAtIndex:[self _indexOfPendingService]];
}

%new(v@:@)
- (void)setPendingService:(CKService *)pendingService
{
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

%new(@@:d)
-(CKMessage *)lastMessageFromIndex:(NSInteger)index
{
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

%new(@@:d)
-(CKMessage *)nextMessageFromIndex:(NSInteger)index
{
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

- (int)_appendDateForMessageIfNeeded:(CKMessage *)message
{
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
	
	return %orig;
}

-(int)_appendServiceForMessageIfNeeded:(CKMessage *)message
{
    NSInteger response = %orig;
    if (response == NSNotFound && [message conversation]) {
        NSInteger index = [self indexForMessage:message];
        if (index == NSNotFound) {
            index = [self count];
        }
		
		NSInteger searchIndex = (index > 0 ? index-1 : 0);
		
		// don't append another service divider if one is already there
		CKService *prevService = [self serviceAtIndex:searchIndex];
		if (!prevService) {
			CKMessage *prevMessage = [self lastMessageFromIndex:searchIndex];
			BOOL shouldAppendService = NO;
			
//			DLog(@"appending service for message \"%@\" with recipients: %@ groupID: %@, conversation: %@, aggregate: %@, placeholder: %d \n prevMessage \"%@\" recipients: %@ groupID: %@, conversation: %@, aggregate: %@", [message text], [message.conversation recipients], [message.conversation groupID], message.conversation, message.conversation.aggregateConversation, [message isPlaceholder], [prevMessage text], [prevMessage.conversation recipients], [prevMessage.conversation groupID], prevMessage.conversation, prevMessage.conversation.aggregateConversation);
			
			if ([prevMessage conversation]) {
				BOOL sameAddress = ([[message.conversation recipients] isEqual:[prevMessage.conversation recipients]]);
				shouldAppendService = !sameAddress;
			}
			else if (index == 0) {
				// always show service at the top (doesn't happen automatically on iPad)
				shouldAppendService = YES;
			}
			
			if (shouldAppendService) {
				response = [self _appendService:message.service];
			}
		}
    }
    return response;
}

%end

%hook CKConversationList

-(CKAggregateConversation *)aggregateConversationForRecipients:(NSArray *)recipients create:(BOOL)create
{
    CKAggregateConversation *conversation = %orig;
//    DLog(@"aggregate for recipients: %@ is %@; shouldCreate: %d", recipients, conversation, create);
    
    if (recipients.count == 1) {
        conversation.selectedRecipient = [recipients objectAtIndex:0];
    }
    
    return conversation;
}

-(id)existingConversationForAddresses:(NSArray *)addresses
{
    CKSubConversation *conversation = %orig;
    if (conversation && conversation.recipients.count == 1) {
//        DLog(@"conversation: %@, aggregate: %@", conversation, conversation.aggregateConversation);
        conversation.aggregateConversation.selectedRecipient = [conversation.recipients objectAtIndex:0];
    }
    return conversation;
}

%end

%hook CKAggregateConversation

static NSString *const MGSelectedRecipientKey = @"MGSelectedRecipientKey";
static NSString *const MGPendingMessageKey = @"MGPendingMessageKey";

%new(@@:)
- (CKEntity *)selectedRecipient
{
    return objc_getAssociatedObject(self, MGSelectedRecipientKey);
}

%new(v@:@)
- (void)setSelectedRecipient:(CKEntity *)recipient
{
    objc_setAssociatedObject(self, MGSelectedRecipientKey, recipient, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

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

%new(@@:)
- (NSArray *)allAddresses
{
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

-(id)_subConversationForService:(id)service create:(BOOL)create
{
    CKSubConversation *conversation = [self _bestExistingConversationWithService:service];
    if (!conversation) {
        conversation = %orig;
    }
//    DLog(@"found subConversation %@ for service %@, shouldCreate: %d, aggregate: %@", conversation, service, create, self);
    return conversation;
}

-(id)_bestExistingConversation
{
    CKSubConversation *conversation = [self _bestExistingConversationWithService:nil];
    if (!conversation) {
        conversation = %orig;
    }
//    DLog(@"found bestExistingConversation %@ for aggregate %@", conversation, self);
    return conversation;
}

%new(d@:)
- (BOOL)isCombinedConversation
{
	BOOL isCombinedConversation = NO;
    NSString *prevGroupID = nil;
    for (CKSubConversation *conversation in self.subConversations) {
		if (conversation.recipients.count == 1) {
			if (!prevGroupID) {
				prevGroupID = conversation.groupID;
			}
			else if (![prevGroupID isEqualToString:conversation.groupID] /*&& conversation.recipients.count <= 1*/) {
				isCombinedConversation = YES;
				break;
			}
		}
    }
	
	return isCombinedConversation;
}

%new(@@:@)
-(CKSubConversation *)_bestExistingConversationWithService:(CKService *)service
{
    if ([self isCombinedConversation]) {
        CKEntity *selectedRecipient = self.selectedRecipient;
        CKSubConversation *mostRecentConversation = nil;
        CKSubConversation *selectedConversation = nil;
        long long largestSequenceNum = 0;
        for (CKSubConversation *conversation in self.subConversations) {
            CKMessage *latestMessage = conversation.latestMessage;
            NSNumber *sequenceNum = latestMessage.sequenceNumber;
            
            if (service && ![conversation.service isEqual:service]) {
                // ignore conversations that don't match
//                DLog(@"conversation %@ does not match service %@, ignoring!", conversation, service);
                continue;
            }
            
            if ([[conversation recipients] containsObject:selectedRecipient]) {
//                DLog(@"found selectedRecipient %@ in subConversation %@", selectedRecipient, conversation);
                selectedConversation = conversation;
                break;
            }
            
            if (!sequenceNum) {
                // placeholder (pending) message
//                DLog(@"found conversation %@ with latestMessage %@ with no sequence number!", conversation, latestMessage);
                
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
        
//        DLog(@"found mostRecentConversation %@, selectedConversation %@, pending messages: %@", mostRecentConversation, selectedConversation, mostRecentConversation.aggregateConversation.pendingMessages);
        
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
    
//    DLog(@"adding message %@ placeholder: %d, with conversation %@, recipients: %@, outgoing: %d, containsMessage: %d", message, [message isPlaceholder], message.conversation, message.conversation.recipients, [message isOutgoing], containsMessage);
//    self.pendingMessage = message;
    int result = %orig;
    
    if ([message isOutgoing] && [message conversation].recipients.count == 1) {
        self.selectedRecipient = [[message conversation].recipients objectAtIndex:0];
        
//        if ([self didAddMessageBlock]) {
//            [self didAddMessageBlock](message, self);
//        }
    }
//    DLog(@"result: %d for message %@ with conversation %@", result, message, message.conversation);
    return result;
}

%end

%hook CKSMSService

-(id)newMessageWithComposition:(id)composition forConversation:(CKSubConversation *)conversation
{
    CKMessage *message = %orig;
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}

%end

%hook CKMadridService

-(id)newMessageWithComposition:(id)composition forConversation:(CKSubConversation *)conversation
{
    CKMessage *message = %orig;
    if ([conversation aggregateConversation]) {
        [[conversation aggregateConversation] addMessage:message incrementUnreadCount:NO];
    }
    return message;
}

%end

//%hook SMSApplication
//
//- (void)handleURL:(NSURL *)url
//{
//    %log;
//    %orig;
//}
//
//%end

%hook CKRecipientSelectionView

%new(v@:@@)
- (void)composeRecipientView:(id)view showPersonCardForAtom:(MFComposeRecipientAtom *)atom
{
	if (self.delegate && [self.delegate respondsToSelector:@selector(recipientSelectionView:selectAddressForAtom:)]) {
		[self.delegate recipientSelectionView:self selectAddressForAtom:atom];
	}
}

%end

%hook MFComposeRecipientAtom

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

- (id)initWithFrame:(CGRect)frame recipient:(id)recipient style:(int)style
{
	id _self = %orig;
	if (_self) {
		// need to use an actual gesture recognizer to force tap-and-hold to be recognized
		// before touch up
		UILongPressGestureRecognizer *longPressGesture = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)] autorelease];
		[self addGestureRecognizer:longPressGesture];
	}
	
	return _self;
}

%new(v@:@)
- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
	if (gesture.state == UIGestureRecognizerStateBegan) {
		if (self.style != MFComposeRecipientAtomStyleError) {
			[self handleTouchAndHold];
		}
		else {
			[self.delegate selectComposeRecipientAtom:self];
		}
	}
}

%end

typedef enum {
	// ????????? (there are obviously more)
	CKPreferredServiceManagerOptionsNewComposition = 1 << 7,
} CKPreferredServiceManagerOptions;

%hook CKPreferredServiceManager

%new(@:@@pp)
- (CKService *)preferredServiceForSelectedRecipient:(CKEntity *)recipient withAggregateConversation:(CKAggregateConversation *)conversation canSend:(BOOL *)canSend error:(NSError **)error
{
	NSLog(@"Error: %@ called on %@; should only be called on CKMessagesAppPreferredServiceManager!", NSStringFromSelector(_cmd), self);
	
	// this method gets it wrong sometimes, so don't use it normally!
	return (recipient.service ? recipient.service : [self _preferredServiceForEntities:@[recipient] newComposition:YES checkWithServer:NO canSend:canSend error:(id *)error]);
}

%end

%hook CKMessagesAppPreferredServiceManager

- (CKService *)preferredServiceForSelectedRecipient:(CKEntity *)recipient withAggregateConversation:(CKAggregateConversation *)conversation canSend:(BOOL *)canSend error:(NSError **)error
{
	CKService *preferredService = nil;
	
	if (recipient) {
		NSArray *recipients = @[recipient];
		NSError *actualError = nil;
		
		unsigned options = [self __optionsForConversation:conversation];
		options |= CKPreferredServiceManagerOptionsNewComposition;
		
		preferredService = [self _preferredServiceForEntities:recipients
							//											  newComposition:NO // apparently needs to always be YES to work properly
							//											 checkWithServer:checkWithServer
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

- (id)preferredServiceForAggregateConversation:(CKAggregateConversation *)aggregateConversation newComposition:(BOOL)newComposition checkWithServer:(BOOL)checkWithServer canSend:(BOOL *)canSend error:(id *)error
{
	CKService *preferredService = nil;
	if (aggregateConversation.selectedRecipient) {
		preferredService = [self preferredServiceForSelectedRecipient:aggregateConversation.selectedRecipient
											withAggregateConversation:aggregateConversation
															  canSend:canSend
																error:(NSError **)error];
	}
	else if ([aggregateConversation isCombinedConversation]) {
		CKSubConversation *conversation = [aggregateConversation _bestExistingConversation];
		if (conversation.recipients.count == 1) {
			preferredService = [self preferredServiceForSelectedRecipient:conversation.recipient
												withAggregateConversation:aggregateConversation
																  canSend:canSend
																	error:(NSError **)error];
		}
		else {
			preferredService = %orig;
		}
	}
	else {
		preferredService = %orig;
	}
	
	return preferredService;
}

%end

%group DashedLineFixPad
%hook CKDashedLineView

- (void)drawRect:(CGRect)rect
{
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

%end
%end

%ctor {
    %init;
    if ([MGTranscriptHeaderContext shouldOverrideHeader]) {
        %init(FloatingHeader);
    }
	
	if (ShouldMergeServiceAndDateLabels()) {
		%init(DashedLineFixPad);
	}
}