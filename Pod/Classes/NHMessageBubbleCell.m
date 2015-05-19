//
//  NHMessegeBubbleCell.m
//  Pods
//
//  Created by Naithar on 02.05.15.
//
//

#import "NHMessageBubbleCell.h"

const NSUInteger kNHDisabledConstraintPriority = 1;
const NSUInteger kNHEnabledConstraintPriority = 900;

@interface NHMessageBubbleCell ()

@property (nonatomic, strong) UIView *messageContainer;
@property (nonatomic, strong) UIImageView *messageMaskView;

//@property (nonatomic, strong) NSLayoutConstraint *topMessageOffset;
@property (nonatomic, strong) NSLayoutConstraint *leftMessageOffset;
@property (nonatomic, strong) NSLayoutConstraint *rightMessageOffset;
@property (nonatomic, strong) NSLayoutConstraint *bottomMessageOffset;
@property (nonatomic, strong) NSLayoutConstraint *minMessageHeight;
@property (nonatomic, strong) NSLayoutConstraint *minMessageWidth;

@property (nonatomic, strong) CALayer *shadowLayer;
@property (nonatomic, strong) UIImageView *shadowMaskView;

@end

@implementation NHMessageBubbleCell

- (instancetype)init {
    self = [super init];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    [self setupBubble];
    [self setupViews];
}

- (void)awakeFromNib {
}

- (void)setupBubble {
    _bubbleType = NHMessageBubbleTypeOutgoing;
    _hasTail = NO;
    _messageContainerInset = UIEdgeInsetsZero;
    _minMessageContainerSize = CGSizeMake(40, 35);
    _shadowInsets = UIEdgeInsetsMake(1, 1.5, 1, 1.5);
}

- (void)setupMaskImage {
    if (!self.maskImage) {
        if (self.bubbleType == NHMessageBubbleTypeOutgoing) {
            self.messageMaskView.image = self.hasTail
            ? [NHBubbleMaskProvider defaultOutgoingTailBubble]
            : [NHBubbleMaskProvider defaultOutgoingBubble];
            self.shadowMaskView.image = self.hasTail
            ? [NHBubbleMaskProvider defaultOutgoingTailBubble]
            : [NHBubbleMaskProvider defaultOutgoingBubble];
        }
        else {
            self.messageMaskView.image = self.hasTail
            ? [NHBubbleMaskProvider defaultIncomingTailBubble]
            : [NHBubbleMaskProvider defaultIncomingBubble];
            self.shadowMaskView.image = self.hasTail
            ? [NHBubbleMaskProvider defaultIncomingTailBubble]
            : [NHBubbleMaskProvider defaultIncomingBubble];
        }
    }
    else {
        self.messageMaskView.image = self.hasTail
        ? self.tailMaskImage
        : self.maskImage;
        self.shadowMaskView.image = self.hasTail
        ? self.tailMaskImage
        : self.maskImage;
    }
}

- (void)setupViews {
    self.contentView.opaque = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.clipsToBounds = YES;

    self.messageContainer = [[UIView alloc] init];
    [self.messageContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.messageContainer.opaque = YES;
    self.messageContainer.clipsToBounds = YES;
    self.messageContainer.backgroundColor = self.bubbleColor ?: [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.messageContainer];

    self.minMessageHeight = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                           toItem:self.messageContainer
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0 constant:self.minMessageContainerSize.height];

    [self.messageContainer addConstraint:self.minMessageHeight];


    self.minMessageWidth = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                           toItem:self.messageContainer
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0 constant:self.minMessageContainerSize.width];

    [self.messageContainer addConstraint:self.minMessageWidth];
//
//    self.topMessageOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
//                                                                 attribute:NSLayoutAttributeTop
//                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
//                                                                    toItem:self.contentView
//                                                                 attribute:NSLayoutAttributeTop
//                                                                multiplier:1.0
//                                                                  constant:self.messageContainerInset.top];
//

    self.bottomMessageOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self.contentView
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:-self.messageContainerInset.bottom];



    self.leftMessageOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:self.messageContainerInset.left];



    self.rightMessageOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:-self.messageContainerInset.right];



    self.messageMaskView = [[UIImageView alloc] init];
    self.shadowLayer = [CALayer layer];
    self.shadowMaskView = [[UIImageView alloc] init];
    self.shadowLayer.shadowOffset = CGSizeMake(0.f, 0.f);

    if (self.bubbleType == NHMessageBubbleTypeOutgoing) {
        self.leftMessageOffset.priority = kNHDisabledConstraintPriority;
        self.rightMessageOffset.priority = kNHEnabledConstraintPriority;
    }
    else {
        self.rightMessageOffset.priority = kNHDisabledConstraintPriority;
        self.leftMessageOffset.priority = kNHEnabledConstraintPriority;
    }

    [self setupMaskImage];
    self.messageContainer.layer.mask = self.messageMaskView.layer;

    [self.shadowLayer addSublayer:self.shadowMaskView.layer];
    [self.contentView.layer insertSublayer:self.shadowLayer below:self.messageContainer.layer];

    
    [self.contentView addConstraint:self.bottomMessageOffset];
    [self.contentView addConstraint:self.leftMessageOffset];
    [self.contentView addConstraint:self.rightMessageOffset];

    [self setNeedsLayout];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
    [self resetMask];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self resetMask];
}

- (void)prepareForReuse {
    [super prepareForReuse];

    [self reset];
}

- (void)setBubbleType:(NHMessageBubbleType)bubbleType {
    if (bubbleType != _bubbleType) {
        [self willChangeValueForKey:@"bubbleType"];
        _bubbleType = bubbleType;

        if (self.leftMessageOffset
            && self.rightMessageOffset) {
            [self.contentView removeConstraints:@[self.leftMessageOffset, self.rightMessageOffset]];

            if (bubbleType == NHMessageBubbleTypeOutgoing) {
                self.leftMessageOffset.priority = kNHDisabledConstraintPriority;
                self.rightMessageOffset.priority = kNHEnabledConstraintPriority;
            }
            else {
                self.rightMessageOffset.priority = kNHDisabledConstraintPriority;
                self.leftMessageOffset.priority = kNHEnabledConstraintPriority;
            }
            
            [self.contentView addConstraints:@[self.leftMessageOffset, self.rightMessageOffset]];
        }

        [UIView performWithoutAnimation:^{
            [self.superview setNeedsLayout];
            [self.superview layoutIfNeeded];
        }];

        [self setupMaskImage];
        [self resetMask];

        [self didChangeValueForKey:@"bubbleType"];
    }
}

- (void)setHasTail:(BOOL)hasTail {
    if (_hasTail != hasTail) {
        [self willChangeValueForKey:@"hasTail"];
        _hasTail = hasTail;

        [UIView performWithoutAnimation:^{
            [self setupMaskImage];
        }];
//        [self setNeedsLayout];
//        [self layoutIfNeeded];

        [self didChangeValueForKey:@"hasTail"];
    }
}

- (void)setMessageContainerInset:(UIEdgeInsets)messageContainerInset {
    [self willChangeValueForKey:@"messageContainerInset"];
    _messageContainerInset = messageContainerInset;

//    self.topMessageOffset.constant = messageContainerInset.top;
    self.leftMessageOffset.constant = messageContainerInset.left;
    self.rightMessageOffset.constant = -messageContainerInset.right;
    self.bottomMessageOffset.constant = -messageContainerInset.bottom;

    [self setNeedsLayout];
    [self layoutIfNeeded];

    [self didChangeValueForKey:@"messageContainerInset"];
}

- (void)setMinMessageContainerSize:(CGSize)minMessageContainerSize {
    [self willChangeValueForKey:@"minMessageContainerSize"];
    _minMessageContainerSize = minMessageContainerSize;

    self.minMessageWidth.constant = minMessageContainerSize.width;
    self.minMessageHeight.constant = minMessageContainerSize.height;

    [UIView performWithoutAnimation:^{
        [self.superview setNeedsLayout];
        [self.superview layoutIfNeeded];
    }];

    [self didChangeValueForKey:@"minMessageContainerSize"];
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    [self willChangeValueForKey:@"bubbleColor"];
    _bubbleColor = bubbleColor;
    self.messageContainer.backgroundColor = bubbleColor ?: [UIColor groupTableViewBackgroundColor];
    [self didChangeValueForKey:@"bubbleColor"];
}

- (void)resetMask {
    if (!CGRectEqualToRect(self.messageMaskView.frame, self.messageContainer.bounds)) {
        self.messageMaskView.frame = self.messageContainer.bounds;
    }

    if (!CGRectEqualToRect(self.shadowMaskView.frame, self.messageContainer.frame)) {
        self.shadowMaskView.frame = UIEdgeInsetsInsetRect(self.messageContainer.frame, self.shadowInsets);
    }
}

- (void)reset {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)reloadWithData:(id)data {

}

+ (CGFloat)heightForRowWithData:(id)data {
    return 44;
}

@end
