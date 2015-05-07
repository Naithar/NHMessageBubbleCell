//
//  NHSimpleTextBubble.m
//  Pods
//
//  Created by Naithar on 05.05.15.
//
//

#import "NHSimpleTextBubble.h"

@interface NHSimpleTextBubble ()

@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSLayoutConstraint *topLabelOffset;
@property (nonatomic, strong) NSLayoutConstraint *bottomLabelOffset;
@property (nonatomic, strong) NSLayoutConstraint *leftLabelOffset;
@property (nonatomic, strong) NSLayoutConstraint *rightLabelOffset;
@property (nonatomic, strong) NSLayoutConstraint *labelWidth;

@end

@implementation NHSimpleTextBubble

- (void)setupBubble {
    [super setupBubble];

    _messageLabelInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    _messageLabelOffset = CGPointMake(5, 0);
    _maxLabelWidth = 200;
    self.hasTail = YES;
}

- (void)setupViews {
    [super setupViews];

    self.messageLabel = [[UILabel alloc] init];
    [self.messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.messageLabel.backgroundColor = self.messageContainer.backgroundColor;
    self.messageLabel.opaque = YES;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.text = nil;
    self.messageLabel.preferredMaxLayoutWidth = self.maxLabelWidth;
    self.messageLabel.textAlignment = self.bubbleType == NHMessageBubbleTypeOutgoing ? NSTextAlignmentRight : NSTextAlignmentLeft;

    [self.messageContainer addSubview:self.messageLabel];


    self.labelWidth = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                   attribute:NSLayoutAttributeHeight
                                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                                      toItem:self.messageLabel
                                                   attribute:NSLayoutAttributeHeight
                                                  multiplier:0
                                                    constant:self.maxLabelWidth];

    [self.messageLabel addConstraint:self.labelWidth];

    self.topLabelOffset = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.messageContainer
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:self.messageLabelInsets.top];

    self.bottomLabelOffset = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.messageContainer
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:-(self.messageLabelInsets.bottom + self.messageLabelOffset.y)];

    self.leftLabelOffset = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:self.messageContainer
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                         constant:(self.messageLabelInsets.left + (self.bubbleType == NHMessageBubbleTypeIncoming ? self.messageLabelOffset.x : 0))];

    self.rightLabelOffset = [NSLayoutConstraint constraintWithItem:self.messageLabel
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.messageContainer
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:-(self.messageLabelInsets.right + (self.bubbleType == NHMessageBubbleTypeOutgoing ? self.messageLabelOffset.x : 0))];

    [self.messageContainer addConstraints:@[self.topLabelOffset, self.bottomLabelOffset, self.leftLabelOffset, self.rightLabelOffset]];


    [self layoutIfNeeded];
}

- (void)setBubbleType:(NHMessageBubbleType)bubbleType {
    self.leftLabelOffset.constant = (self.messageLabelInsets.left + (bubbleType == NHMessageBubbleTypeIncoming ? self.messageLabelOffset.x : 0));
    self.rightLabelOffset.constant = -(self.messageLabelInsets.right + (bubbleType == NHMessageBubbleTypeOutgoing ? self.messageLabelOffset.x : 0));
    self.messageLabel.textAlignment = bubbleType == NHMessageBubbleTypeOutgoing ? NSTextAlignmentRight : NSTextAlignmentLeft;
    [super setBubbleType:bubbleType];
}

- (void)setMaxLabelWidth:(CGFloat)maxLabelWidth {
    [self willChangeValueForKey:@"maxLabelWidth"];
    _maxLabelWidth = maxLabelWidth;

    self.messageLabel.preferredMaxLayoutWidth = maxLabelWidth;
    self.labelWidth.constant = maxLabelWidth;
    [self didChangeValueForKey:@"maxLabelWidth"];
}

- (void)setMessageLabelInsets:(UIEdgeInsets)messageLabelInsets {
    [self willChangeValueForKey:@"messageLabelInsets"];
    _messageLabelInsets = messageLabelInsets;

    self.topLabelOffset.constant = messageLabelInsets.top;
    self.bottomLabelOffset.constant = -(messageLabelInsets.bottom + self.messageLabelOffset.y);
    self.leftLabelOffset.constant = (messageLabelInsets.left + (self.bubbleType == NHMessageBubbleTypeIncoming ? self.messageLabelOffset.x : 0));
    self.rightLabelOffset.constant = -(messageLabelInsets.right + (self.bubbleType == NHMessageBubbleTypeOutgoing ? self.messageLabelOffset.x : 0));

    [self didChangeValueForKey:@"messageLabelInsets"];
}

- (void)setMessageLabelOffset:(CGPoint)messageLabelOffset {
    [self willChangeValueForKey:@"messageLabelOffset"];
    _messageLabelOffset = messageLabelOffset;

    self.bottomLabelOffset.constant = -(self.messageLabelInsets.bottom + messageLabelOffset.y);
    self.leftLabelOffset.constant = (self.messageLabelInsets.left + (self.bubbleType == NHMessageBubbleTypeIncoming ? messageLabelOffset.x : 0));
    self.rightLabelOffset.constant = -(self.messageLabelInsets.right + (self.bubbleType == NHMessageBubbleTypeOutgoing ? messageLabelOffset.x : 0));

    [self didChangeValueForKey:@"messageLabelOffset"];
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    [super setBubbleColor:bubbleColor];
    self.messageLabel.backgroundColor = bubbleColor;
}

- (void)reset {
    [super reset];
    self.messageLabel.text = nil;
}

- (void)reloadWithData:(id)data {
    if ([data isKindOfClass:[NSString class]]) {
        self.messageLabel.text = data;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

+ (CGFloat)heightForRowWithData:(id)data {
    return 100;
}

@end
