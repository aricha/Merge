//
//  MGAddressManager.m
//  Merge
//
//  Created by Andrew Richardson on 2012-09-04.
//
//

#import "MGAddressManager.h"

#import "ABContactHelper/ABContactsHelper.h"
#import <AddressBookUI/ABPersonTableAction_Dumped.h>
#import <AddressBookUI/ABPropertyGroup_Dumped.h>
#import <AddressBookUI/ABCapabilitiesManager_Dumped.h>
#import <AddressBookUI/ABActionSheet_Dumped.h>
#import <AddressBookUI/ABStyleProvider_Dumped.h>
#import <AddressBookUI/ABActionsController_Dumped.h>
#import <AddressBookUI/ABPopoverManager_Dumped.h>
#import <AddressBook/ABPhoneFormatting_Dumped.h>

typedef enum {
	ABActionsControllerActionCall = 0, // "Call"
	ABActionsControllerActionAddFavourite, // "Add to Favorites"
	ABActionsControllerActionFaceTime, // "FaceTime"
	ABActionsControllerActionSendMessage, // "Send Message"
	ABActionsControllerActionEmail, // "Email"
	ABActionsControllerActionVisit, // "Visit" (??)
	ABActionsControllerActionOpenMaps, // "Open in Google Maps"
} ABActionsControllerAction;

#define nilFromNull(obj) (obj ? obj : nil)

extern NSBundle *ABAddressBookUIBundle();

@interface MGAddressManager() <UIActionSheetDelegate, ABPersonTableActionDelegate>

@property (nonatomic, retain) UIActionSheet *activeSheet;
@property (nonatomic, copy) DifferentiationSheetCompletionBlock activeCompletionBlock;
@property (nonatomic, retain) NSArray *activeValidAddresses;
@property (nonatomic, retain) ABPersonTableAction *activeAction;
@property (nonatomic, retain) NSArray *activePropertyGroups;

@end

NSBundle *MGBundle(void);

NSBundle *MGBundle(void)
{
	static NSBundle *mergeBundle = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		// TODO: use an actual bundle
		mergeBundle = [ABAddressBookUIBundle() retain];
	});
	return mergeBundle;
}

@implementation MGAddressManager

+ (MGAddressManager *)sharedAddressManager
{
	static MGAddressManager *sharedManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedManager = [[MGAddressManager alloc] init];
	});
	
	return sharedManager;
}

- (void)dealloc
{
	[_activeCompletionBlock release];
	[_activeSheet release];
	[_activeValidAddresses release];
	[_activeAction release];
	[_activePropertyGroups release];
	
	[super dealloc];
}

- (ABStyleProvider *)styleProvider
{
	return [ABStyleProvider defaultStyleProvider];
}

- (void)actionSheet:(ABActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == actionSheet.cancelButtonIndex || ![actionSheet isKindOfClass:[ABActionSheet class]])
		return;
	
	ABPropertyGroup *propertyGroup = (ABPropertyGroup *)nilFromNull([actionSheet ab_tag3AtIndex:buttonIndex]);
	int propertyIndex = [actionSheet ab_tagAtIndex:buttonIndex];
	ABPropertyID property = [actionSheet ab_tag2AtIndex:buttonIndex];
	
	NSString *normalizedAddress = [ABPhoneFormatting abNormalizedPhoneNumberFromString:[propertyGroup propertyValueAtIndex:propertyIndex]];
	BOOL performOriginalAction = NO;
	
	if (self.activeValidAddresses && ![self.activeValidAddresses containsObject:normalizedAddress])
	{
		// use default (ie. URL) action
		performOriginalAction = YES;
	}
	else
	{
		if (self.activeCompletionBlock) {
			self.activeCompletionBlock(normalizedAddress, &performOriginalAction);
		}
	}
		
	if (performOriginalAction) {
		[self.activeAction performWithSender:self person:[propertyGroup.people objectAtIndex:0] property:property identifier:propertyIndex];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	self.activeValidAddresses = nil;
	self.activeCompletionBlock = nil;
	self.activeSheet = nil;
	self.activeAction = nil;
	self.activePropertyGroups = nil;
}

- (void)sendMessage:(ABPersonTableAction *)action person:(ABRecordRef)person property:(ABPropertyID)property identifier:(int)identifier
{
	ABActionsController *actionsController = [ABActionsController newActionsControllerForProperty:property];
	actionsController.person = (void *)person;
	
	ABPropertyGroup *selectedGroup = nil;
	for (ABPropertyGroup *group in self.activePropertyGroups)
	{
		if (group.property == property) {
			selectedGroup = group;
			break;
		}
	}
		
	if (selectedGroup) {
		[selectedGroup prepareActionsController:actionsController withValueAtIndex:identifier];
		
		[actionsController performAction:ABActionsControllerActionSendMessage];
	}
	else {
		NSLog(@"Error: could not find selected group for property %d", property);
	}
}

- (void)presentDifferentiationSheetForContact:(ABContact *)contact
									   inView:(UIView *)view
									asPopover:(BOOL)showAsPopover
						   availableAddresses:(NSArray *)addresses
								   completion:(DifferentiationSheetCompletionBlock)completionBlock
{
	NSAssert(contact != nil, @"contact cannot be nil");
	NSArray *people = @[(id)contact.record];
		
	NSMutableArray *propertyTypes = [NSMutableArray array];
	
	ABCapabilitiesManager *capabilities = [ABCapabilitiesManager defaultCapabilitiesManager];
	if ([capabilities isMadridConfigured] || [capabilities isMMSConfigured])
		[propertyTypes addObject:@(kABPersonEmailProperty)];
	if ([capabilities isMadridConfigured] || [capabilities hasSMSCapability])
		[propertyTypes addObject:@(kABPersonPhoneProperty)];
	
	NSMutableArray *propertyGroups = [NSMutableArray array];
	BOOL hasValidAddress = NO;
	
	for (int i = 0; i < propertyTypes.count; i++)
	{
		ABPropertyID propertyType = [[propertyTypes objectAtIndex:i] intValue];
		ABPropertyGroup *propertyGroup = [[[ABPropertyGroup alloc] initWithProperty:propertyType context:NULL] autorelease];
		propertyGroup.people = people;
		propertyGroup.styleProvider = [self styleProvider];
		
		if (propertyGroup.itemCount > 0)
			hasValidAddress = YES;
		
		[propertyGroups addObject:propertyGroup];
	}
	
	NSAssert1(hasValidAddress, @"Error: no valid addresses found for contact %@", contact);
	
	NSBundle *abBundle = ABAddressBookUIBundle();
	NSBundle *mgBundle = MGBundle();
	
	// PHONE_ACTION_TEXT_SHEET_TITLE in AB
	NSString *sheetTitle = [mgBundle localizedStringForKey:@"ADDRESS_SWITCH_TITLE" value:@"Select an address to send to." table:@"AB"];
	
	NSString *cancelTitle = [abBundle localizedStringForKey:@"CANCEL" value:@"Cancel" table:@"AB"];
	
	ABActionSheet *actionSheet = [[[ABActionSheet alloc] init] autorelease];
	actionSheet.title = sheetTitle;
	actionSheet.delegate = self;
	
	for (ABPropertyGroup *propertyGroup in propertyGroups)
	{
		ABRecordID property = [propertyGroup property];
		
		for (int i = 0; i < propertyGroup.itemCount; i++)
		{
			NSString *value = [propertyGroup stringValueAtIndex:i];
			NSString *label = [propertyGroup localizedPropertyLabelAtIndex:i];
			
			[actionSheet ab_addButtonWithTitle:value label:label tag:i tag2:property tag3:propertyGroup tag4:contact];
		}
	}
	
	NSUInteger cancelIndex = [actionSheet _addButtonWithTitle:cancelTitle];
	actionSheet.cancelButtonIndex = cancelIndex;
	
//	if (addresses)
	{
		NSString *title = [abBundle localizedStringForKey:@"PHONE_ACTION_TEXT" value:nil table:@"AB"];
		NSString *shortTitle = [abBundle localizedStringForKey:@"PHONE_ACTION_TEXT_SHORT" value:nil table:@"AB"];
		
		ABPersonTableAction *action = [[[ABPersonTableAction alloc] initWithTitle:title
																	  shortTitle:shortTitle
																		  target:self
																		selector:@selector(sendMessage:person:property:identifier:)
																		property:kABPersonPhoneProperty] autorelease];
		action.differentiationSheetTitle = sheetTitle;
		action.delegate = self;
		
		CFMutableArrayRef properties = CFArrayCreateMutable(CFAllocatorGetDefault(), 2, NULL);
		CFArrayAppendValue(properties, &kABPersonPhoneProperty);
		CFArrayAppendValue(properties, &kABPersonEmailProperty);
		
		action.properties = properties; //(CFArrayRef)@[(id)&kABPersonPhoneProperty, (id)&kABPersonEmailProperty];
		CFRelease(properties);
		
		actionSheet.ab_context = action;
		self.activeAction = action;
	}
	
	self.activeCompletionBlock = completionBlock;
	self.activeSheet = actionSheet;
	self.activeValidAddresses = addresses;
	self.activePropertyGroups = propertyGroups;
	
//	[ABPopoverManager actionSheet:actionSheet showFromView:view animated:YES autorotate:YES];
	if (showAsPopover) {
		[actionSheet showFromRect:view.bounds inView:view animated:YES];
	}
	else {
		[actionSheet showInView:view];
	}
}

@end
