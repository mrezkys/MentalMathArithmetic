//
//  GameResultStatCardView.m
//  MentalMathArithmetic
//
//  Created by Codex on 2025/xx/xx.
//

#import "GameResultStatCardView.h"
#import "UIColor+Theme.h"

@interface GameResultStatCardView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIStackView *contentStackView;

@end

@implementation GameResultStatCardView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightRegular];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [UILabel new];
        _valueLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightHeavy];
        _valueLabel.textColor = [UIColor blackColor];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_valueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_valueLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _valueLabel;
}

- (UIStackView *)contentStackView {
    if (!_contentStackView) {
        _contentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.titleLabel, self.valueLabel]];
        _contentStackView.axis = UILayoutConstraintAxisHorizontal;
        _contentStackView.alignment = UIStackViewAlignmentCenter;
        _contentStackView.spacing = 12.0;
        _contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentStackView;
}

- (void)setupView {
    self.backgroundColor = [UIColor lightBlue];
    self.layer.cornerRadius = 16.0;
    self.translatesAutoresizingMaskIntoConstraints = NO;

    [self addSubview:self.contentStackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.contentStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:24.0],
        [self.contentStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-24.0],
        [self.contentStackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:12.0],
        [self.contentStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12.0]
    ]];
}

- (void)configureWithTitle:(NSString *)title value:(NSString *)value {
    self.titleLabel.text = title;
    self.valueLabel.text = value;
}

@end
