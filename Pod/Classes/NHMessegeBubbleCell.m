//
//  NHMessegeBubbleCell.m
//  Pods
//
//  Created by Naithar on 02.05.15.
//
//

#import "NHMessegeBubbleCell.h"

@interface NHMessegeBubbleCell ()

@property (nonatomic, strong) UIView *messageContainer;
@property (nonatomic, strong) UIImageView *messageMaskView;

@end

@implementation NHMessegeBubbleCell

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
    [self setupViews];
}

- (void)awakeFromNib {
    [self setupViews];
}

- (void)setupViews {
    self.contentView.opaque = YES;
    self.contentView.clipsToBounds = YES;

    self.messageContainer = [[UIView alloc] init];
    [self.messageContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.messageContainer.opaque = YES;
    self.messageContainer.clipsToBounds = YES;
    self.messageContainer.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.messageContainer];
//
    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                          toItem:self.messageContainer
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:0 constant:35]];

    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                      attribute:NSLayoutAttributeWidth
                                                                      relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                         toItem:self.messageContainer
                                                                      attribute:NSLayoutAttributeWidth
                                                                     multiplier:0 constant:35]];



    NSLayoutConstraint *topOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:0];

//    topOffset.priority = UILayoutPriorityDefaultHigh;
    [self.contentView addConstraint:topOffset];

    NSLayoutConstraint *bottomOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                                                     constant:0];
//    bottomOffset.priority = UILayoutPriorityDefaultHigh;

    [self.contentView addConstraint:bottomOffset];

    NSLayoutConstraint *leftOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                  attribute:NSLayoutAttributeLeft
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentView
                                                                  attribute:NSLayoutAttributeLeft
                                                                 multiplier:1.0
                                                                   constant:0];
    leftOffset.priority = UILayoutPriorityDefaultLow;
    
    [self.contentView addConstraint:leftOffset];

    NSLayoutConstraint *rightOffset = [NSLayoutConstraint constraintWithItem:self.messageContainer
                                                                   attribute:NSLayoutAttributeRight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.contentView
                                                                   attribute:NSLayoutAttributeRight
                                                                  multiplier:1.0
                                                                    constant:0];

    rightOffset.priority = UILayoutPriorityDefaultHigh;

    [self.contentView addConstraint:rightOffset];


    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.opaque = YES;
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    messageLabel.backgroundColor = [UIColor greenColor];
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.text = @"dsadsa dsad sadsadasda dad asd a sd sad asd asd a";
    messageLabel.numberOfLines = 0;

    [self.messageContainer addSubview:messageLabel];

    [messageLabel addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationLessThanOrEqual
                                                                toItem:messageLabel
                                                             attribute:NSLayoutAttributeWidth
                                                            multiplier:0 constant:200]];

    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.messageContainer
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:5]];

    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                                      attribute:NSLayoutAttributeRight
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.messageContainer
                                                                      attribute:NSLayoutAttributeRight
                                                                     multiplier:1.0
                                                                       constant:-10]];

    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                                      attribute:NSLayoutAttributeTop
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.messageContainer
                                                                      attribute:NSLayoutAttributeTop
                                                                     multiplier:1.0
                                                                       constant:5]];

    [self.messageContainer addConstraint:[NSLayoutConstraint constraintWithItem:messageLabel
                                                                      attribute:NSLayoutAttributeBottom
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.messageContainer
                                                                      attribute:NSLayoutAttributeBottom
                                                                     multiplier:1.0
                                                                       constant:-5]];

    //use custom
    UIImage *maskImage = [[UIImage imageNamed:@"mask.bubble-tail"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 18, 16, 25) resizingMode:UIImageResizingModeTile];

    self.messageMaskView = [[UIImageView alloc] init];
    self.messageMaskView.image = maskImage;

    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

    [self resetMask];
}


- (void)prepareForReuse {
    [super prepareForReuse];

    [self resetMask];
}

- (void)resetMask {
    self.messageMaskView.frame = self.messageContainer.bounds;
    self.messageContainer.layer.mask = self.messageMaskView.layer;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
