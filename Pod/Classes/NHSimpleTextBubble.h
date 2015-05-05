//
//  NHSimpleTextBubble.h
//  Pods
//
//  Created by Naithar on 05.05.15.
//
//

#import "NHMessageBubbleCell.h"

@interface NHSimpleTextBubble : NHMessageBubbleCell

@property (nonatomic, readonly, strong) UILabel *messageLabel;

@property (nonatomic, assign) CGFloat maxLabelWidth;
@property (nonatomic, assign) UIEdgeInsets messageLabelInsets;
@property (nonatomic, assign) CGPoint messageLabelOffset;

@end
