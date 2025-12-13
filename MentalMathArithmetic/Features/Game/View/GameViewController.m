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
#import "GameQuestionCardAnswerBoxView.h"
#import "ConfirmationModalViewController.h"
#import "AnswerQuestionModalViewController.h"
#import "TimeCounterModalViewController.h"
#import "GameQuestionState.h"
#import "GameSession.h"
#import "GameQuestion.h"
#import "GameSessionProgressView.h"
#import "AnswerFeedbackView.h"
#import <QuartzCore/QuartzCore.h>

@interface GameViewController ()
@property (strong, nonatomic) GameViewModel *viewModel;
@property (strong, nonatomic) CAShapeLayer *progressLayer;
@property (strong, nonatomic) CAShapeLayer *trackLayer;
@property (strong, nonatomic) UILabel *repetitionLabel;
@property (strong, nonatomic) UILabel *progressLabel;
@property (strong, nonatomic) UIStackView *progressLabelStackView;
@property (strong, nonatomic) GameSessionProgressView *sessionProgressView;
@property (strong, nonatomic) GameQuestionCardAnswerBoxView *questionCardView;
@property (strong, nonatomic) AnswerFeedbackView *answerFeedbackView;
@property (strong, nonatomic) UIImageView *bookIllustration;
@property (nonatomic, strong) NSLayoutConstraint *bookIllustrationHeightConstraint;
@property (strong, nonatomic) UIStackView *questionCardMainStackView;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIButton *answerButton;
@property (strong, nonatomic) UIStackView *footerStackView;
@property (strong, nonatomic) UIView *footerView;
@property (strong, nonatomic, nullable) CADisplayLink *progressDisplayLink;
@end


@implementation GameViewController

- (instancetype)initWithViewModel:(GameViewModel *)vm {
    if (self = [super init]) {
        _viewModel = vm;

    }
    return self;
}

- (void)dealloc {
    [self stopProgressAnimation];
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

- (GameSessionProgressView *)sessionProgressView {
    if (!_sessionProgressView) {
        _sessionProgressView = [[GameSessionProgressView alloc] init];
        
        [self.view addSubview:self.sessionProgressView];

        [NSLayoutConstraint activateConstraints:@[
            [self.sessionProgressView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:12.0],
            [self.sessionProgressView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24.0],
            [self.sessionProgressView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24.0],
            [self.sessionProgressView.heightAnchor constraintEqualToConstant:6.0]
        ]];
    }
    return _sessionProgressView;
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

- (GameQuestionCardAnswerBoxView *)questionCardView {
    if (!_questionCardView) {
        _questionCardView = [GameQuestionCardAnswerBoxView new];
        __weak typeof(self) weakSelf = self;
        _questionCardView.tapHandler = ^{
            [weakSelf checkQuestionState];
        };
    }
    return _questionCardView;
}

- (AnswerFeedbackView *)answerFeedbackView {
    if (!_answerFeedbackView) {
        _answerFeedbackView = [AnswerFeedbackView new];
        _answerFeedbackView.translatesAutoresizingMaskIntoConstraints = NO;
        _answerFeedbackView.hidden = YES;
    }
    return _answerFeedbackView;
}

- (UIStackView *)questionCardMainStackView {
    if (!_questionCardMainStackView) {
        _questionCardMainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.bookIllustration, self.questionCardView]];
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
        [_pauseButton addTarget:self action:@selector(handlePauseButtonTap) forControlEvents:UIControlEventTouchUpInside];
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
        [_answerButton addTarget:self
                           action:@selector(handleAnswerButtonTap)
                 forControlEvents:UIControlEventTouchUpInside];
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


#pragma mark - Actions
- (void)handlePauseButtonTap {
    [self.viewModel togglePause];
    
    if (self.viewModel.isPaused) {
        [self stopProgressAnimation];
        [self.pauseButton setImage:[UIImage systemImageNamed:@"play.fill"] forState:UIControlStateNormal];
    } else {
        [self startProgressAnimation];
        [self.pauseButton setImage:[UIImage systemImageNamed:@"pause.fill"] forState:UIControlStateNormal];
    }
}

- (void)handleAnswerButtonTap {
    GameQuestionState *state = self.viewModel.currentQuestionState;
    if (state.isAwaitingAnswer) {
        [self checkQuestionState];
    } else {
        BOOL advanced = [self.viewModel advanceToNextQuestion];
        if (!advanced) {
            [self.answerButton setTitle:@"End Session" forState:UIControlStateNormal];
        } else {
            [self updateProgress];
            [self updateSessionProgress];
            [self updateQuestionCard];
        }
    }
    
}


#pragma mark - Private

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultView];

    [self.viewModel start];
    [self updateProgress];
    [self updateSessionProgress];
    [self updateQuestionCard];
    
}

- (void)setupDefaultView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupCircularProgress];
    [self setupProgressLabelStackView];
    [self setupFooterView];
    [self setupQuestionCardMainStackView];
    [self updateProgress];
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
    [self.view addSubview:self.answerFeedbackView];
    
    self.bookIllustrationHeightConstraint = [self.bookIllustration.heightAnchor constraintEqualToConstant:32];


    [NSLayoutConstraint activateConstraints:@[
        [self.answerFeedbackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.answerFeedbackView.bottomAnchor constraintEqualToAnchor:self.questionCardMainStackView.topAnchor constant:-16],
        
        [self.questionCardView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:24],
        [self.questionCardView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-24],
        self.bookIllustrationHeightConstraint,
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
    NSInteger repetition = self.viewModel.repetitionCount;
    NSInteger totalRepetitions = self.viewModel.totalRepetitions;
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)repetition, (long)totalRepetitions];

    NSInteger totalNumbers = self.viewModel.totalNumberCount;
    NSInteger completedNumbers = self.viewModel.spelledNumberCount;
    CGFloat progress = totalNumbers > 0 ? (CGFloat)completedNumbers / (CGFloat)totalNumbers : 0.0f;
    self.progressLayer.strokeEnd = progress;
}

- (void)updateSessionProgress {
    GameSession *session = self.viewModel.currentSession;
    if (!session) {
        [self.sessionProgressView configureWithStatuses:@[] currentIndex:NSNotFound];
        return;
    }

    NSArray<NSNumber *> *statuses = session.questionStatuses;
    NSInteger highlightIndex = session.isCompleted ? NSNotFound : session.currentQuestionIndex;

    if (highlightIndex != NSNotFound) {
        NSInteger cappedIndex = (NSInteger)statuses.count - 1;
        if (cappedIndex < 0) {
            highlightIndex = NSNotFound;
        } else {
            highlightIndex = MIN(MAX(highlightIndex, 0), cappedIndex);
        }
    }

    [self.sessionProgressView configureWithStatuses:statuses currentIndex:highlightIndex];
}

- (void)updateQuestionCard {
    GameQuestionState *state = self.viewModel.currentQuestionState;

    if (!state) {
        [self resetProgressAnimation];
        [self.questionCardView setExpanded:NO animated:YES];
        [self.questionCardView setQuestionText:@""];
        [self.questionCardView setAnswerText:@""];
        [self.questionCardView setStatusText:@"Playing 🔊"];
        return;
    }

    [self.questionCardView setQuestionText:state.question.promptString];
    NSString *answerText = [NSString stringWithFormat:@"= %ld", (long)state.question.expectedResult];
    [self.questionCardView setAnswerText:answerText];

    if (state.isAwaitingAnswer) {
        [self applyPendingQuestionAppearance];
    } else {
        [self applyAnsweredQuestionAppearance];
    }
}

- (void)presentSessionSummary {
    GameSession *session = self.viewModel.currentSession;
    if (!session || self.presentedViewController) {
        return;
    }

    NSString *message = [NSString stringWithFormat:@"You answered %ld of %lu correctly.",
                         (long)session.correctAnswerCount,
                         (unsigned long)session.questions.count];

    ConfirmationModalViewController *modal = [[ConfirmationModalViewController new]
        initWithTitle:@"Session Complete"
             message:message
         confirmTitle:@"Play Again"
          cancelTitle:@"Close"];

    __weak typeof(self) weakSelf = self;
    modal.confirmHandler = ^{
        [weakSelf.viewModel start];
        [weakSelf updateProgress];
        [weakSelf updateSessionProgress];
        [weakSelf updateQuestionCard];
    };

    [self presentViewController:modal animated:YES completion:nil];
}

- (void)checkQuestionState {
    GameQuestionState *state = self.viewModel.currentQuestionState;

    if (!state) {
        [self presentSessionSummary];
        return;
    }

    if (state.isAwaitingAnswer) {
        ConfirmationModalViewController *modal = [[ConfirmationModalViewController new]
            initWithTitle:@"To open the question, you need to answer first"
                 message:nil
             confirmTitle:@"Answer Question"
              cancelTitle:nil];

        __weak typeof(self) weakSelf = self;
        modal.confirmHandler = ^{
            [weakSelf showAnswerQuestionModal];
        };

        [self presentViewController:modal animated:YES completion:nil];
    }
}

- (void) showAnswerQuestionModal {
    AnswerQuestionModalViewController *modal = [
        [AnswerQuestionModalViewController new]
        initWithTitle:@"Type your answer below and check if it’s true."
        placeholder:nil
    ];
    
    modal.submitHandler = ^(NSString * _Nullable answer) {
        [self checkAnswer:answer];
    };
    
    [self presentViewController:modal animated:true completion:nil];
}

- (void)checkAnswer:(NSString *)answer {
    [self.viewModel checkAnswer:answer];
    
    GameQuestionState *state = self.viewModel.currentQuestionState;
    if (state.answerStatus == GameQuestionAnswerStatusCorrect) {
        [self.answerFeedbackView configureWithAnswer:answer type:AnswerFeedbackTypeCorrect];
    } else {
        [self.answerFeedbackView configureWithAnswer:answer type:AnswerFeedbackTypeIncorrect];
    }
    
    [self updateQuestionCard];
    [self updateSessionProgress];
}

- (void) expandQuestionBox {
    [self.progressLayer setHidden:true];
    [self.trackLayer setHidden:true];
    [self.progressLabelStackView setHidden:true];
    self.answerFeedbackView.hidden = NO;
    
    [self.questionCardView setExpanded:YES animated:YES];

    self.bookIllustrationHeightConstraint.constant = 64;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showProgressUI {
    self.progressLayer.hidden = NO;
    self.trackLayer.hidden = NO;
    self.progressLabelStackView.hidden = NO;
}

- (void)applyPendingQuestionAppearance {
    [self resetProgressAnimation];
    [self showProgressUI];
    self.answerFeedbackView.hidden = YES;
    [self.questionCardView setExpanded:NO animated:YES];
    [self.questionCardView setStatusText:@"Playing 🔊"];
    [self changeAnswerButtonStyleForAdvanced:NO];

    self.bookIllustrationHeightConstraint.constant = 32;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

    [self startProgressAnimation];
}

- (void)applyAnsweredQuestionAppearance {
    [self stopProgressAnimation];
    [self expandQuestionBox];
    [self.questionCardView setStatusText:@"Question Revealed"];
    [self changeAnswerButtonStyleForAdvanced:YES];
}

- (void)startProgressAnimation {
    if (self.progressDisplayLink || ![self.viewModel hasActiveSession]) {
        return;
    }

    self.progressDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleProgressDisplayLink:)];
    [self.progressDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)handleProgressDisplayLink:(CADisplayLink *)displayLink {
    [self updateProgress];
}

- (void)stopProgressAnimation {
    if (!self.progressDisplayLink) {
        return;
    }

    [self.progressDisplayLink invalidate];
    self.progressDisplayLink = nil;
}

- (void)resetProgressAnimation {
    [self stopProgressAnimation];
    [self updateProgress];
}

- (void)changeAnswerButtonStyleForAdvanced:(BOOL)isAdvanced {
    if (isAdvanced) {
        [self.answerButton setTitle:@"Next Question" forState:UIControlStateNormal];
    } else {
        [self.answerButton setTitle:@"Answer Question" forState:UIControlStateNormal];
    }
}


- (void)resetViewToDefault {
    [self changeAnswerButtonStyleForAdvanced:false];
}

@end

//
//else {
//    BOOL advanced = [self.viewModel advanceToNextQuestion];
//    [self updateProgress];
//    [self updateSessionProgress];
//    [self updateQuestionCard];
//    if (!advanced) {
//        [self presentSessionSummary];
//    }
//}
