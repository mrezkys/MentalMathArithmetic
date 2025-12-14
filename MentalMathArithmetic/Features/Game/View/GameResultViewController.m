//
//  GameResultViewController.m
//  MentalMathArithmetic
//
//  Created by Codex on 2025/xx/xx.
//

#import "GameResultViewController.h"
#import "GameResultStatCardView.h"
#import "UIColor+Theme.h"
#import "UIView+Borders.h"

@interface GameResultViewController ()

@property (nonatomic, assign) CGFloat averageRepetition;
@property (nonatomic, assign) CGFloat accuracy;
@property (nonatomic, assign) NSInteger correctAnswerCount;
@property (nonatomic, assign) NSInteger totalQuestionCount;

@property (nonatomic, strong) UIStackView *statsStackView;
@property (nonatomic, strong) GameResultStatCardView *averageRepetitionCard;
@property (nonatomic, strong) GameResultStatCardView *accuracyCard;
@property (nonatomic, strong) GameResultStatCardView *correctAnswerCard;
@property (nonatomic, strong) UIImageView *characterImageView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) BOOL previousNavigationBarHidden;

@end

@implementation GameResultViewController

- (instancetype)initWithAverageRepetition:(CGFloat)averageRepetition
                                 accuracy:(CGFloat)accuracy
                        correctAnswerCount:(NSInteger)correctAnswerCount
                        totalQuestionCount:(NSInteger)totalQuestionCount {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _averageRepetition = averageRepetition;
        _accuracy = accuracy;
        _correctAnswerCount = correctAnswerCount;
        _totalQuestionCount = totalQuestionCount;
    }
    return self;
}

- (UIStackView *)statsStackView {
    if (!_statsStackView) {
        _statsStackView = [[UIStackView alloc] init];
        _statsStackView.axis = UILayoutConstraintAxisVertical;
        _statsStackView.spacing = 12.0;
        _statsStackView.alignment = UIStackViewAlignmentFill;
        _statsStackView.distribution = UIStackViewDistributionFill;
        _statsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _statsStackView;
}

- (GameResultStatCardView *)averageRepetitionCard {
    if (!_averageRepetitionCard) {
        _averageRepetitionCard = [GameResultStatCardView new];
        [_averageRepetitionCard configureWithTitle:@"Average\nRepetition" value:[self formattedAverageRepetition]];
    }
    return _averageRepetitionCard;
}

- (GameResultStatCardView *)accuracyCard {
    if (!_accuracyCard) {
        _accuracyCard = [GameResultStatCardView new];
        [_accuracyCard configureWithTitle:@"Answer\nAccuration" value:[self formattedAccuracy]];
    }
    return _accuracyCard;
}

- (GameResultStatCardView *)correctAnswerCard {
    if (!_correctAnswerCard) {
        _correctAnswerCard = [GameResultStatCardView new];
        [_correctAnswerCard configureWithTitle:@"Correct\nAnswer" value:[self formattedCorrectAnswers]];
    }
    return _correctAnswerCard;
}

- (UIImageView *)characterImageView {
    if (!_characterImageView) {
        _characterImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"character-with-book-illustration"]];
        _characterImageView.contentMode = UIViewContentModeScaleAspectFit;
        _characterImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _characterImageView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_footerView addSubview:self.backButton];
        [_footerView addBorderOnSide:UIBorderSideTop color:[UIColor lightGrayColor] width:1.0];
    }
    return _footerView;
}

- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_backButton setTitle:@"Back to Home" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _backButton.backgroundColor = [UIColor primaryBlue];
        _backButton.layer.cornerRadius = 16.0;
        _backButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_backButton addTarget:self action:@selector(handleBackButtonTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.previousNavigationBarHidden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:self.previousNavigationBarHidden animated:animated];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.statsStackView];
    [self.view addSubview:self.characterImageView];
    [self.view addSubview:self.footerView];

    [self.statsStackView addArrangedSubview:self.averageRepetitionCard];
    [self.statsStackView addArrangedSubview:self.accuracyCard];
    [self.statsStackView addArrangedSubview:self.correctAnswerCard];

    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;

    [NSLayoutConstraint activateConstraints:@[
        [self.statsStackView.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:36.0],
        [self.statsStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24.0],
        [self.statsStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24.0],

        [self.footerView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor],
        [self.footerView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor],
        [self.footerView.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor],

        [self.backButton.leadingAnchor constraintEqualToAnchor:self.footerView.leadingAnchor constant:24.0],
        [self.backButton.trailingAnchor constraintEqualToAnchor:self.footerView.trailingAnchor constant:-24.0],
        [self.backButton.topAnchor constraintEqualToAnchor:self.footerView.topAnchor constant:16.0],
        [self.backButton.bottomAnchor constraintEqualToAnchor:self.footerView.bottomAnchor constant:-16.0],
        [self.backButton.heightAnchor constraintEqualToConstant:56.0],

        [self.characterImageView.topAnchor constraintEqualToAnchor:self.statsStackView.bottomAnchor constant: -12],
        [self.characterImageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24.0],
        [self.characterImageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24.0],
        [self.characterImageView.bottomAnchor constraintEqualToAnchor:self.footerView.topAnchor constant: 0]
    ]];
}

- (NSString *)formattedAverageRepetition {
    NSInteger rounded = (NSInteger)round(self.averageRepetition);
    return [NSString stringWithFormat:@"%ld Rep", (long)rounded];
}

- (NSString *)formattedAccuracy {
    CGFloat percentage = self.accuracy;
    if (percentage <= 1.0f) {
        percentage *= 100.0f;
    }
    NSInteger rounded = (NSInteger)roundf(percentage);
    return [NSString stringWithFormat:@"%ld%%", (long)rounded];
}

- (NSString *)formattedCorrectAnswers {
    NSInteger total = MAX(self.totalQuestionCount, 0);
    NSInteger correct = MAX(MIN(self.correctAnswerCount, total), 0);
    return [NSString stringWithFormat:@"%ld/%ld", (long)correct, (long)total];
}

#pragma mark - Actions

- (void)handleBackButtonTap {
    if (self.backToHomeHandler) {
        self.backToHomeHandler();
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
