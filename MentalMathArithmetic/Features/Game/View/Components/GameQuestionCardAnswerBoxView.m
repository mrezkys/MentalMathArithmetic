#import "GameQuestionCardAnswerBoxView.h"
#import "UIColor+Theme.h"

@interface GameQuestionCardAnswerBoxView ()

@property (nonatomic, strong) UIStackView *contentStackView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIStackView *headerStackView;
@property (nonatomic, strong) UIStackView *headerTopStackView;
@property (nonatomic, strong) UILabel *questionTitleLabel;
@property (nonatomic, strong) UILabel *hintLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *questionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *questionLabel;
@property (nonatomic, strong) UIView *answerView;
@property (nonatomic, strong) UILabel *answerLabel;

@property (nonatomic, assign, getter=isExpanded) BOOL expanded;

@end

@implementation GameQuestionCardAnswerBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor primaryPurple];
    self.layer.cornerRadius = 16;
    self.clipsToBounds = YES;

    [self addSubview:self.contentStackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.contentStackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.contentStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.contentStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.contentStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.questionView.heightAnchor constraintEqualToConstant:250],
    ]];

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap)];
    [self addGestureRecognizer:gesture];

    _expanded = YES;
    [self setExpanded:NO animated:NO];
}

- (UIStackView *)contentStackView {
    if (!_contentStackView) {
        _contentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.headerView, self.mainStackView]];
        _contentStackView.axis = UILayoutConstraintAxisVertical;
        _contentStackView.spacing = 4;
        _contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentStackView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_headerView addSubview:self.headerStackView];

        [NSLayoutConstraint activateConstraints:@[
            [self.headerStackView.leadingAnchor constraintEqualToAnchor:_headerView.leadingAnchor constant:12],
            [self.headerStackView.trailingAnchor constraintEqualToAnchor:_headerView.trailingAnchor constant:-12],
            [self.headerStackView.topAnchor constraintEqualToAnchor:_headerView.topAnchor constant:12],
            [self.headerStackView.bottomAnchor constraintEqualToAnchor:_headerView.bottomAnchor constant:-12],
        ]];
    }
    return _headerView;
}

- (UIStackView *)headerStackView {
    if (!_headerStackView) {
        _headerStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.headerTopStackView, self.statusLabel]];
        _headerStackView.axis = UILayoutConstraintAxisVertical;
        _headerStackView.spacing = 4;
        _headerStackView.alignment = UIStackViewAlignmentFill;
        _headerStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _headerStackView;
}

- (UIStackView *)headerTopStackView {
    if (!_headerTopStackView) {
        _headerTopStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.questionTitleLabel, self.hintLabel]];
        _headerTopStackView.axis = UILayoutConstraintAxisHorizontal;
        _headerTopStackView.distribution = UIStackViewDistributionEqualSpacing;
        _headerTopStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _headerTopStackView;
}

- (UILabel *)questionTitleLabel {
    if (!_questionTitleLabel) {
        _questionTitleLabel = [[UILabel alloc] init];
        _questionTitleLabel.text = @"Question";
        _questionTitleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBold];
        _questionTitleLabel.textColor = [UIColor whiteColor];
    }
    return _questionTitleLabel;
}

- (UILabel *)hintLabel {
    if (!_hintLabel) {
        _hintLabel = [[UILabel alloc] init];
        _hintLabel.text = @"Tap to show";
        _hintLabel.font = [UIFont systemFontOfSize:14];
        _hintLabel.textColor = [UIColor whiteColor];
    }
    return _hintLabel;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.text = @"Playing 🔊";
        _statusLabel.font = [UIFont systemFontOfSize:14];
        _statusLabel.textColor = [UIColor whiteColor];
    }
    return _statusLabel;
}

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.questionView, self.answerView]];
        _mainStackView.axis = UILayoutConstraintAxisVertical;
        _mainStackView.spacing = 0;
        _mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainStackView;
}

- (UIView *)questionView {
    if (!_questionView) {
        _questionView = [[UIView alloc] init];
        _questionView.backgroundColor = [UIColor darkPurple];
        _questionView.translatesAutoresizingMaskIntoConstraints = NO;
        [_questionView addSubview:self.scrollView];

        [NSLayoutConstraint activateConstraints:@[
            [self.scrollView.topAnchor constraintEqualToAnchor:_questionView.topAnchor],
            [self.scrollView.leadingAnchor constraintEqualToAnchor:_questionView.leadingAnchor],
            [self.scrollView.trailingAnchor constraintEqualToAnchor:_questionView.trailingAnchor],
            [self.scrollView.bottomAnchor constraintEqualToAnchor:_questionView.bottomAnchor],
        ]];
    }
    return _questionView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.contentInset = UIEdgeInsetsMake(24, 24, 24, 24);
        [_scrollView addSubview:self.questionLabel];

        [NSLayoutConstraint activateConstraints:@[
            [self.questionLabel.topAnchor constraintEqualToAnchor:_scrollView.contentLayoutGuide.topAnchor],
            [self.questionLabel.leadingAnchor constraintEqualToAnchor:_scrollView.contentLayoutGuide.leadingAnchor],
            [self.questionLabel.trailingAnchor constraintEqualToAnchor:_scrollView.contentLayoutGuide.trailingAnchor],
            [self.questionLabel.bottomAnchor constraintEqualToAnchor:_scrollView.contentLayoutGuide.bottomAnchor],
            [self.questionLabel.widthAnchor constraintEqualToAnchor:_scrollView.widthAnchor constant:-48],
        ]];
    }
    return _scrollView;
}

- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.text = @"1 + 2  + 7 + 8 + 91 + 2 + 7 + 8 + 9 1 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 9 1 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 91 + 2 + 7 ";
        _questionLabel.numberOfLines = 0;
        _questionLabel.textColor = [UIColor whiteColor];
        _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _questionLabel;
}

- (UIView *)answerView {
    if (!_answerView) {
        _answerView = [[UIView alloc] init];
        _answerView.backgroundColor = [UIColor primaryPurple];
        _answerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_answerView addSubview:self.answerLabel];

        [NSLayoutConstraint activateConstraints:@[
            [self.answerLabel.topAnchor constraintEqualToAnchor:_answerView.topAnchor constant:24],
            [self.answerLabel.leadingAnchor constraintEqualToAnchor:_answerView.leadingAnchor constant:24],
            [self.answerLabel.trailingAnchor constraintEqualToAnchor:_answerView.trailingAnchor constant:-24],
            [self.answerLabel.bottomAnchor constraintEqualToAnchor:_answerView.bottomAnchor constant:-24],
        ]];
    }
    return _answerView;
}

- (UILabel *)answerLabel {
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] init];
        _answerLabel.text = @"= 239";
        _answerLabel.textColor = [UIColor whiteColor];
        _answerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _answerLabel;
}

- (void)handleTap {
    if (self.tapHandler) {
        self.tapHandler();
    }
}

- (void)setQuestionText:(NSString *)text {
    self.questionLabel.text = text;
}

- (void)setAnswerText:(NSString *)text {
    self.answerLabel.text = text;
}

- (void)setExpanded:(BOOL)expanded animated:(BOOL)animated {
    if (_expanded == expanded) {
        return;
    }

    _expanded = expanded;

    void (^finalState)(void) = ^{
        self.questionView.hidden = !expanded;
        self.answerView.hidden = !expanded;
        self.hintLabel.hidden = expanded;
        self.hintLabel.alpha = expanded ? 0.0 : 1.0;
        self.statusLabel.text = expanded ? @"Question Revealed" : @"Playing 🔊";
    };

    if (animated) {
        if (expanded) {
            self.questionView.hidden = NO;
            self.answerView.hidden = NO;
            self.questionView.alpha = 0.0;
            self.answerView.alpha = 0.0;
            self.hintLabel.hidden = NO;
            self.hintLabel.alpha = 1.0;
        } else {
            self.hintLabel.hidden = NO;
            self.hintLabel.alpha = 0.0;
            self.questionView.alpha = 1.0;
            self.answerView.alpha = 1.0;
        }

        [UIView animateWithDuration:0.25 animations:^{
            self.hintLabel.alpha = expanded ? 0.0 : 1.0;
            self.questionView.alpha = expanded ? 1.0 : 0.0;
            self.answerView.alpha = expanded ? 1.0 : 0.0;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
            finalState();
            self.questionView.alpha = 1.0;
            self.answerView.alpha = 1.0;
        }];
    } else {
        finalState();
    }
}

@end
