//
//  MGAddressManager.h
//  Merge
//
//  Created by Andrew Richardson on 2012-09-04.
//
//

#import <Foundation/Foundation.h>

@class ABContact, UIView;

@interface MGAddressManager : NSObject

+ (MGAddressManager *)sharedAddressManager;

- (void)presentDifferentiationSheetForContact:(ABContact *)contact
									   inView:(UIView *)view
									asPopover:(BOOL)showAsPopover
						   availableAddresses:(NSArray *)addresses
								   completion:(void (^)(NSString *address))completionBlock;

@end
