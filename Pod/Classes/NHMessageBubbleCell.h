//
//  NHMessegeBubbleCell.h
//  Pods
//
//  Created by Naithar on 02.05.15.
//
//

#import <UIKit/UIKit.h>
#import <NHBubbleMaskProvider.h>

extern const NSUInteger kNHDisabledConstraintPriority;
extern const NSUInteger kNHEnabledConstraintPriority;

typedef NS_ENUM(NSUInteger, NHMessageBubbleType) {
    NHMessageBubbleTypeIncoming,
    NHMessageBubbleTypeOutgoing,
};

@interface NHMessageBubbleCell : UITableViewCell

@property (nonatomic, assign) CGSize minMessageContainerSize;
@property (nonatomic, assign) UIEdgeInsets messageContainerInset;
@property (nonatomic, assign) NHMessageBubbleType bubbleType;
@property (nonatomic, assign) BOOL hasTail;

@property (nonatomic, strong) UIColor *bubbleColor;

@property (nonatomic, readonly, strong) CALayer *shadowLayer;
@property (nonatomic, assign) UIEdgeInsets shadowInsets;

@property (nonatomic, strong) UIImage *maskImage;
@property (nonatomic, strong) UIImage *tailMaskImage;
@property (nonatomic, readonly, strong) UIView *messageContainer;


- (void)setupBubble;
- (void)setupViews;
- (void)reset;
- (void)reloadWithData:(id)data;
+ (CGFloat)heightForRowWithData:(id)data;

@end
