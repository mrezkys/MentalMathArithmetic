//
//  AnswerQuestionModalViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

#import <UIKit/UIKit.h>
#import "AnswerQuestionModalViewController.h"
#import "UIColor+Theme.h"

@interface AnswerQuestionModalViewController () <UITextFieldDelegate>

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy, nullable) NSString *placeholderText;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *answerField;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation AnswerQuestionModalViewController

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(nullable NSString *)placeholder {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _titleText = [title copy];
        _placeholderText = [placeholder copy];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45f];
    [self setupViews];
    [self setupConstraints];
}

- (void)setupViews {
    self.containerView = [[UIView alloc] init];
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.containerView.backgroundColor = UIColor.whiteColor;
    self.containerView.layer.cornerRadius = 24 ;
    self.containerView.layer.masksToBounds = YES;
    [self.view addSubview:self.containerView];

    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    UIImageSymbolConfiguration *closeConfig =
        [UIImageSymbolConfiguration configurationWithPointSize:18 weight:UIImageSymbolWeightSemibold];
    UIImage *closeImage = [UIImage systemImageNamed:@"xmark" withConfiguration:closeConfig];
    [self.closeButton setImage:closeImage forState:UIControlStateNormal];
    self.closeButton.tintColor = UIColor.secondaryLabelColor;
    [self.closeButton addTarget:self action:@selector(handleCloseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.closeButton];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = self.titleText;
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightSemibold];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.numberOfLines = 0;
    [self.containerView addSubview:self.titleLabel];

    self.answerField = [[UITextField alloc] init];
    self.answerField.translatesAutoresizingMaskIntoConstraints = NO;
    self.answerField.delegate = self;
    self.answerField.placeholder = self.placeholderText ?: @"Your Answer";
    self.answerField.backgroundColor = [UIColor systemGray6Color];
    self.answerField.textColor = UIColor.labelColor;
    self.answerField.font = [UIFont systemFontOfSize:17 ];
    self.answerField.layer.cornerRadius = 16 ;
    self.answerField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    self.answerField.leftViewMode = UITextFieldViewModeAlways;
    self.answerField.returnKeyType = UIReturnKeyDone;
    [self.containerView addSubview:self.answerField];

    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    UIImageSymbolConfiguration *chevronConfig =
        [UIImageSymbolConfiguration configurationWithPointSize:22 weight:UIImageSymbolWeightSemibold];
    UIImage *chevron = [UIImage systemImageNamed:@"chevron.right" withConfiguration:chevronConfig];
    [self.confirmButton setImage:chevron forState:UIControlStateNormal];
    self.confirmButton.tintColor = UIColor.whiteColor;
    self.confirmButton.backgroundColor = [UIColor primaryGreen];
    self.confirmButton.layer.cornerRadius = 16 ;
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton addTarget:self action:@selector(handleConfirmTap) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.confirmButton];

    UITapGestureRecognizer *tap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)setupConstraints {
    self.containerView.layoutMargins = UIEdgeInsetsMake(16, 16, 16, 16);
    UILayoutGuide *margins = self.containerView.layoutMarginsGuide;

    [NSLayoutConstraint activateConstraints:@[
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.containerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100],
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:16],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-16],

        [self.closeButton.topAnchor constraintEqualToAnchor:margins.topAnchor],
        [self.closeButton.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor],
        [self.closeButton.widthAnchor constraintEqualToConstant:32 ],
        [self.closeButton.heightAnchor constraintEqualToConstant:32 ],

        [self.titleLabel.topAnchor constraintEqualToAnchor:self.closeButton.bottomAnchor constant:16 ],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor constant:32],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor constant:-32],

        [self.answerField.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:24 ],
        [self.answerField.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor],
        [self.answerField.heightAnchor constraintEqualToConstant:56 ],

        [self.confirmButton.leadingAnchor constraintEqualToAnchor:self.answerField.trailingAnchor constant:12 ],
        [self.confirmButton.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor],
        [self.confirmButton.centerYAnchor constraintEqualToAnchor:self.answerField.centerYAnchor],
        [self.confirmButton.widthAnchor constraintEqualToConstant:56],
        [self.confirmButton.heightAnchor constraintEqualToConstant:56 ],

        [self.answerField.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor],
        [self.confirmButton.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor]
    ]];
}


- (void)handleConfirmTap {
    NSString *answer = self.answerField.text;
    AnswerQuestionModalSubmitHandler handler = self.submitHandler;
    [self dismissViewControllerAnimated:YES completion:^{
        if (handler) { handler(answer); }
    }];
}

- (void)handleCloseTap {
    AnswerQuestionModalCancelHandler handler = self.cancelHandler;
    [self dismissViewControllerAnimated:YES completion:^{
        if (handler) { handler(); }
    }];
}

- (void)handleBackgroundTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    if (!CGRectContainsPoint(self.containerView.frame, location)) {
        [self handleCloseTap];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self handleConfirmTap];
    return NO;
}

@end
