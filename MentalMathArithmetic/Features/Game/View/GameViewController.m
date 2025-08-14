//
//  GameViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import "GameViewController.h"
#import "GameViewModel.h"
#import "UIColor+Theme.h"
#import "UIView+Borders.h"

@interface GameViewController ()
@property (strong, nonatomic) GameViewModel *viewModel;
@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CAShapeLayer *trackLayer;
@property (strong, nonatomic) UILabel *repetitionLabel;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UIStackView *progressLabelStackView;
@property (strong, nonatomic) UIView *questionCard;
@property (strong, nonatomic) UILabel *questionLabel;
@property (strong, nonatomic) UILabel *tapToShowLabel;
@property (strong, nonatomic) UIStackView *questionCardContentStackView;
@property (strong, nonatomic) UIImageView *bookIllustration;
@property (strong, nonatomic) UIStackView *questionCardMainStackView;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *answerButton;
@property (strong, nonatomic) UIStackView *footerStackView;
@property (strong, nonatomic) UIView *footerView;
@end


@implementation GameViewController

- (instancetype)initWithViewModel:(GameViewModel *)vm {
    if (self = [super init]) {
        _viewModel = vm;
        _viewModel.delegate = self;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultView];
    [self.viewModel start];
}

- (void)setupDefaultView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCircularProgress];
    [self setupProgressLabelStackView];
    [self setupFooterView];
    [self setupQuestionCardMainStackView];
    [self updateProgress];
}



- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        CGFloat circleRadius = self.view.bounds.size.width / 2 - 64;
        CGPoint circleCenter = CGPointMake(self.view.center.x, self.view.center.y - 100);
        UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:circleRadius startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2 clockwise:YES];
        
        _trackLayer = [CAShapeLayer layer];
        _trackLayer.path = trackPath.CGPath;
        _trackLayer.strokeColor = [UIColor lightBlue].CGColor;
        _trackLayer.lineWidth = 32.0;
        _trackLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _trackLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        CGFloat circleRadius = self.view.bounds.size.width / 2 - 64;
        CGPoint circleCenter = CGPointMake(self.view.center.x, self.view.center.y - 100);
        UIBezierPath *trackPath = [UIBezierPath bezierPathWithArcCenter:circleCenter radius:circleRadius startAngle:-M_PI_2 endAngle:2 * M_PI - M_PI_2 clockwise:YES];
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.path = trackPath.CGPath;
        _progressLayer.strokeColor = [UIColor primaryBlue].CGColor;
        _progressLayer.lineWidth = 32.0;
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeEnd = 0.0;
    }
    return _progressLayer;
}

- (UILabel *)repetitionLabel {
    if (!_repetitionLabel) {
        _repetitionLabel = [[UILabel alloc] init];
        _repetitionLabel.text = @"Repetition";
        _repetitionLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        _repetitionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _repetitionLabel;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightBold];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _progressLabel;
}

- (UIStackView *)progressLabelStackView {
    if (!_progressLabelStackView) {
        _progressLabelStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.repetitionLabel, self.progressLabel]];
        _progressLabelStackView.axis = UILayoutConstraintAxisVertical;
        _progressLabelStackView.spacing = 0;
        _progressLabelStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _progressLabelStackView;
}

- (UIImageView *)bookIllustration {
    if (!_bookIllustration) {
        _bookIllustration = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bookIllustration"]];
        _bookIllustration.layer.contentsGravity = kCAGravityBottom;
        _bookIllustration.contentMode = UIViewContentModeScaleAspectFit;
        _bookIllustration.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bookIllustration;
}

- (UIView *)questionCard {
    if (!_questionCard) {
        _questionCard = [[UIView alloc] init];
        _questionCard.backgroundColor = [UIColor primaryPurple];
        _questionCard.layer.cornerRadius = 16;
        _questionCard.translatesAutoresizingMaskIntoConstraints = NO;
        [_questionCard addSubview:self.questionCardContentStackView];
    }
    return _questionCard;
}

- (UILabel *)questionLabel {
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.text = @"Question";
        _questionLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightBold];
        _questionLabel.textColor = [UIColor whiteColor];
    }
    return _questionLabel;
}

- (UILabel *)tapToShowLabel {
    if (!_tapToShowLabel) {
        _tapToShowLabel = [[UILabel alloc] init];
        _tapToShowLabel.text = @"Tap to show";
        _tapToShowLabel.font = [UIFont systemFontOfSize:14];
        _tapToShowLabel.textColor = [UIColor whiteColor];
    }
    return _tapToShowLabel;
}

- (UIStackView *)questionCardContentStackView {
    if (!_questionCardContentStackView) {
        UILabel *playingLabel = [[UILabel alloc] init];
        playingLabel.text = @"Playing 🔊";
        playingLabel.font = [UIFont systemFontOfSize:14];
        playingLabel.textColor = [UIColor whiteColor];
        
        UIStackView *topContentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.questionLabel, self.tapToShowLabel]];
        topContentStackView.axis = UILayoutConstraintAxisHorizontal;
        topContentStackView.distribution = UIStackViewDistributionEqualSpacing;
        
        _questionCardContentStackView = [[UIStackView alloc] initWithArrangedSubviews:@[topContentStackView, playingLabel]];
        _questionCardContentStackView.axis = UILayoutConstraintAxisVertical;
        _questionCardContentStackView.spacing = 4;
        _questionCardContentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _questionCardContentStackView;
}

- (UIStackView *)questionCardMainStackView {
    if (!_questionCardMainStackView) {
        _questionCardMainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.bookIllustration, self.questionCard]];
        _questionCardMainStackView.alignment = UIStackViewAlignmentCenter;
        _questionCardMainStackView.axis = UILayoutConstraintAxisVertical;
        _questionCardMainStackView.spacing = 0;
        _questionCardMainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _questionCardMainStackView;
}

- (UIButton *)pauseButton {
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_pauseButton setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
        _pauseButton.tintColor = [UIColor blackColor];
        _pauseButton.backgroundColor = [UIColor primaryYellow];
        _pauseButton.layer.cornerRadius = 16;
        _pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pauseButton;
}

- (UIButton *)answerButton {
    if (!_answerButton) {
        _answerButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_answerButton setTitle:@"Answer Question" forState:UIControlStateNormal];
        [_answerButton.titleLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium]];
        [_answerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_answerButton setImage:[UIImage systemImageNamed:@"chevron.right"] forState:UIControlStateNormal];
        _answerButton.tintColor = [UIColor whiteColor];
        _answerButton.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        _answerButton.backgroundColor = [UIColor primaryGreen];
        _answerButton.layer.cornerRadius = 16;
        _answerButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _answerButton;
}

- (UIStackView *)footerStackView {
    if (!_footerStackView) {
        _footerStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.pauseButton, self.answerButton]];
        _footerStackView.axis = UILayoutConstraintAxisHorizontal;
        _footerStackView.spacing = 12;
        _footerStackView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _footerStackView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [_footerView addSubview:self.footerStackView];
        [_footerView addBorderOnSide:UIBorderSideTop color:[UIColor lightGrayColor] width:1.0];
    }
    return _footerView;
}


- (void)setupCircularProgress {
    [self.view.layer addSublayer:self.trackLayer];
    [self.view.layer addSublayer:self.progressLayer];
}

- (void)setupProgressLabelStackView {
    [self.view addSubview:self.progressLabelStackView];
    
    CGFloat circleCenterY = self.view.center.y - 100;

    [NSLayoutConstraint activateConstraints:@[
        [self.progressLabelStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.progressLabelStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant: circleCenterY - self.view.center.y]
    ]];
}

- (void)setupQuestionCardMainStackView {
    [self.view addSubview:self.questionCardMainStackView];

    [NSLayoutConstraint activateConstraints:@[
        [self.questionCard.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24],
        [self.questionCard.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24],
        [self.bookIllustration.heightAnchor constraintEqualToConstant:32],
        [self.questionCardContentStackView.leadingAnchor constraintEqualToAnchor:self.questionCard.leadingAnchor constant:16],
        [self.questionCardContentStackView.trailingAnchor constraintEqualToAnchor:self.questionCard.trailingAnchor constant:-16],
        [self.questionCardContentStackView.topAnchor constraintEqualToAnchor:self.questionCard.topAnchor constant:16],
        [self.questionCardContentStackView.bottomAnchor constraintEqualToAnchor:self.questionCard.bottomAnchor constant:-16],

        [self.questionCardMainStackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.questionCardMainStackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        [self.questionCardMainStackView.bottomAnchor constraintEqualToAnchor:self.footerView.topAnchor constant:-16]
    ]];
}

- (void)setupFooterView {
    [self.view addSubview:self.footerView];
    [self.footerView addSubview:self.footerStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.pauseButton.widthAnchor constraintEqualToConstant:60],
        [self.pauseButton.heightAnchor constraintEqualToConstant:60],
        
        [self.answerButton.heightAnchor constraintEqualToConstant:60],
        
        [self.footerStackView.leadingAnchor constraintEqualToAnchor:self.footerView.leadingAnchor constant:16],
        [self.footerStackView.trailingAnchor constraintEqualToAnchor:self.footerView.trailingAnchor constant:-16],
        [self.footerStackView.topAnchor constraintEqualToAnchor:self.footerView.topAnchor constant:16],
        [self.footerStackView.bottomAnchor constraintEqualToAnchor:self.footerView.bottomAnchor constant:-16],
        
        [self.footerView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.footerView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.footerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (void)updateProgress {
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)self.viewModel.repetitionCount, (long)self.viewModel.totalRepetitions];
    
    CGFloat progress = (CGFloat)self.viewModel.spelledNumberCount / self.viewModel.totalNumberCount;
    self.progressLayer.strokeEnd = progress;
}

//GameViewModelDelegate

- (void)viewModelDidUpdate:(GameViewModel *)viewModel {
    [self updateProgress];
}

@end
