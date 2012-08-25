//
//  MGTranscriptHeaderContext.h
//  Merge
//
//  Created by Andrew Richardson on 12-07-30.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    UIScrollViewDirectionUp = -1,
    UIScrollViewDirectionNone = 0,
    UIScrollViewDirectionDown = 1,
} UIScrollViewDirection;

extern NSString *const CKContentEntryViewDidBeginEditingNotification;
extern NSString *const CKContentEntryViewDidEndEditingNotification;

#define HEADER_SHADOW_PADDING       (5.0f)
#define HEADER_TOP_SCROLL_PADDING   (30.0f)

@class CKTranscriptHeaderView;

@interface MGTranscriptHeaderContext : NSObject

// contentOffset at which the header should be fully visible
@property (nonatomic) CGFloat visibleOffset;

// last known contentOffset for the header's scrollView
@property (nonatomic) CGFloat lastKnownOffset;

@property (nonatomic) CGFloat rotatingHeaderOffset;

@property (nonatomic) CGFloat headerOffset;

// the direction in which scroll view deceleration initially begins
@property (nonatomic) UIScrollViewDirection decelerationDirection;

// only valid when decelerationDirection != UIScrollViewDirectionNone
@property (nonatomic) CGFloat deceleratingTargetOffset;

@property (nonatomic, retain) CKTranscriptHeaderView *headerView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIView *tableHeaderView;

@property (nonatomic) BOOL ignoringContentOffsetChangesDueToKeyboard;
@property (nonatomic) BOOL keyboardVisible;

//@property (nonatomic, readonly) BOOL headerVisible;

+ (BOOL)shouldOverrideHeader;

- (BOOL)shouldAlwaysShowHeaderAtContentOffset:(CGFloat)offset;

- (void)hideHeaderAfterDelay:(NSTimeInterval)delay;
- (void)cancelDelayedHideRequests;

- (void)setHeaderVisible:(BOOL)visible animated:(BOOL)animated;
- (void)setHeaderVisible:(BOOL)visible animated:(BOOL)animated force:(BOOL)force completion:(void (^)(BOOL finished))completion;

- (CGFloat)updateVisibleOffsetForNewContentOffset:(CGFloat)newOffset force:(BOOL)force;
- (void)updateHeaderOffsetForContentOffset:(CGFloat)newOffset force:(BOOL)force;
- (void)updateVisibleOffsetForActiveHeaderOffset;

// causes updateHeaderOffsetForContentOffset:force: to do nothing. nestable.
- (void)beginIgnoringContentOffsetChanges;
- (void)endIgnoringContentOffsetChanges;

@end
