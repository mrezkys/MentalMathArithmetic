#import "GameQuestionCardAnswerBoxView.h"
#import "UIColor+Theme.h"

@interface GameQuestionCardAnswerBoxView ()

@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIView *questionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *questionLabel; // question text
@property (nonatomic, strong) UIView *answerView;
@property (nonatomic, strong) UILabel *answerLabel; // final answer

@end

@implementation GameQuestionCardAnswerBoxView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.questionView, self.answerView]];
        _mainStackView.axis = UILayoutConstraintAxisVertical;
        _mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainStackView;
}

- (UIView *)questionView {
    if (!_questionView) {
        _questionView = [UIView new];
        _questionView.backgroundColor = [UIColor darkPurple];
        _questionView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _questionView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [_scrollView addSubview:self.questionLabel];
    }
    return _scrollView;
}

- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [UILabel new];
        _questionLabel.text = @"1 + 2  + 7 + 8 + 91 + 2 + 7 + 8 + 9 1 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 9 1 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 91 + 2 + 7 + 8 + 91 + 2 + 7 ";
        
        _questionLabel.numberOfLines = 0;
        _questionLabel.textColor = [UIColor whiteColor];
        _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _questionLabel;
}

- (UIView *)answerView {
    if (!_answerView) {
        _answerView = [UIView new];
        _answerView.backgroundColor = [UIColor primaryPurple];
        _answerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_answerView addSubview:self.answerLabel];
    }
    return _answerView;
}

- (UILabel *)answerLabel {
    if (!_answerLabel) {
        _answerLabel = [UILabel new];
        _answerLabel.text = @"= 239";
        _answerLabel.textColor = [UIColor whiteColor];
        _answerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _answerLabel;
}


- (void)setupViews {
    [self addSubview:self.mainStackView];
    
    [_questionView addSubview:self.scrollView];
    
    
    self.scrollView.contentInset = UIEdgeInsetsMake(24, 24, 24, 24);

    [NSLayoutConstraint activateConstraints:@[
        [self.mainStackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.mainStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.mainStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.mainStackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        
        [self.questionView.heightAnchor constraintEqualToConstant:250],
        
        [self.scrollView.topAnchor constraintEqualToAnchor:self.questionView.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.questionView.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.questionView.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.questionView.bottomAnchor],
        
        [self.questionLabel.topAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.topAnchor],
        [self.questionLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.leadingAnchor],
        [self.questionLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.trailingAnchor],
        [self.questionLabel.bottomAnchor constraintEqualToAnchor:self.scrollView.contentLayoutGuide.bottomAnchor],
        [self.questionLabel.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor constant: -48],
        
        [self.answerLabel.topAnchor constraintEqualToAnchor:self.answerView.topAnchor constant:24],
        [self.answerLabel.leadingAnchor constraintEqualToAnchor:self.answerView.leadingAnchor constant:24],
        [self.answerLabel.trailingAnchor constraintEqualToAnchor:self.answerView.trailingAnchor constant:-24],
        [self.answerLabel.bottomAnchor constraintEqualToAnchor:self.answerView.bottomAnchor constant:-24]
    ]];
}

@end
