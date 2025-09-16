//
//  ConfirmationModalViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//
#import "TimeCounterModalViewController.h"
#import "UIColor+Theme.h"

@interface TimeCounterModalViewController ()

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic) NSInteger remainingSeconds;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *counterLabel;
@property (nonatomic, strong) UIImageView *bookImageView;

@property (nonatomic, strong, nullable) NSTimer *timer;

@end

@implementation TimeCounterModalViewController

- (instancetype)initWithTitle:(NSString *)title
                startingValue:(NSInteger)seconds {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _titleText = [title copy];
        _remainingSeconds = MAX(seconds, 0);
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    [self buildViewHierarchy];
    [self setupConstraints];
    [self updateCounterLabel];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    // start countdown one second after showed
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.timer) {
            [self startTimer];
        }
    });
}

- (void)buildViewHierarchy {
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = UIColor.whiteColor;
    self.containerView.layer.cornerRadius = 28;
    self.containerView.layer.masksToBounds = YES;
    [self.view addSubview:self.containerView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = self.titleText;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.titleLabel.textColor = UIColor.labelColor;
    [self.containerView addSubview:self.titleLabel];

    self.counterLabel = [[UILabel alloc] init];
    self.counterLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.counterLabel.textAlignment = NSTextAlignmentCenter;
    self.counterLabel.font = [UIFont systemFontOfSize:48 weight:UIFontWeightBold];
    self.counterLabel.textColor = UIColor.labelColor;
    [self.containerView addSubview:self.counterLabel];

    self.bookImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bookIllustration"]];
    self.bookImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.bookImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bookImageView];
}

- (void)setupConstraints {
    self.containerView.layoutMargins = UIEdgeInsetsMake(32, 28, 28, 28);
    UILayoutGuide *margins = self.containerView.layoutMarginsGuide;

    [NSLayoutConstraint activateConstraints:@[
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-40],
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:72],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-72],

        [self.titleLabel.topAnchor constraintEqualToAnchor:margins.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor],

        [self.counterLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:20],
        [self.counterLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor],
        [self.counterLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor],
        [self.counterLabel.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor],

        [self.bookImageView.topAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:-48],
        [self.bookImageView.centerXAnchor constraintEqualToAnchor:self.containerView.centerXAnchor],
        [self.bookImageView.widthAnchor constraintEqualToAnchor:self.containerView.widthAnchor constant:40],
    ]];
}


- (void)startTimer {
    if (self.remainingSeconds <= 0) {
        [self finishCountdown];
        return;
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(handleTick)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)handleTick {
    if (self.remainingSeconds > 0) {
        self.remainingSeconds -= 1;
        [self updateCounterLabel];
    }

    if (self.remainingSeconds <= 0) {
        [self finishCountdown];
    }
}

- (void)finishCountdown {
    [self.timer invalidate];
    self.timer = nil;
    TimeCounterModalCompletionHandler handler = self.completionHandler;
    [self dismissViewControllerAnimated:YES completion:^{
        if (handler) {
            handler();
        }
    }];
}

- (void)updateCounterLabel {
    self.counterLabel.text = [NSString stringWithFormat:@"%ld", (long)self.remainingSeconds];
}


@end
