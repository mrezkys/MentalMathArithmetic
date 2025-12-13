//
//  AnswerFeedbackView.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 20/08/25.
//

#import "AnswerFeedbackView.h"
#import "UIColor+Theme.h"

@interface AnswerFeedbackView ()

@property (strong, nonatomic) UILabel *yourAnswerLabel;
@property (strong, nonatomic) UILabel *resultLabel;
@property (strong, nonatomic) UIStackView *stackView;

@end

@implementation AnswerFeedbackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.yourAnswerLabel = [[UILabel alloc] init];
    self.yourAnswerLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    self.yourAnswerLabel.textColor = [UIColor blackColor];

    self.resultLabel = [[UILabel alloc] init];
    self.resultLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightHeavy];

    self.stackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.yourAnswerLabel, self.resultLabel]];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentCenter;
    self.stackView.spacing = 8;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.stackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
        [self.stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
    ]];
}

- (void)configureWithAnswer:(NSString *)answer type:(AnswerFeedbackType)type {
    self.yourAnswerLabel.text = [NSString stringWithFormat:@"Your Answer : %@", answer];
    switch (type) {
        case AnswerFeedbackTypeCorrect:
            self.resultLabel.text = @"CORRECT!";
            self.resultLabel.textColor = [UIColor primaryGreen];
            break;
        case AnswerFeedbackTypeIncorrect:
            self.resultLabel.text = @"INCORRECT!";
            self.resultLabel.textColor = [UIColor primaryRed];
            break;
    }
}

@end
