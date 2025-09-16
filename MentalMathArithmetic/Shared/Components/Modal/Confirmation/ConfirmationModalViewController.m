//
//  ConfirmationModalViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

#import <UIKit/UIKit.h>
#import "ConfirmationModalViewController.h"
#import "ConfirmationModalViewController.h"
#import "UIColor+Theme.h"

@interface ConfirmationModalViewController ()

@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy, nullable) NSString *messageText;
@property (nonatomic, copy) NSString *confirmButtonTitle;
@property (nonatomic, copy) NSString *cancelButtonTitle;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIStackView *contentStackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation ConfirmationModalViewController

- (instancetype)initWithTitle:(NSString *)title
                      message:(nullable NSString *)message
                 confirmTitle:(nullable NSString *)confirmTitle
                  cancelTitle:(nullable NSString *)cancelTitle {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _titleText = [title copy];
        _messageText = [message copy];
        _confirmButtonTitle = [confirmTitle copy] ?: @"Confirm";
        _cancelButtonTitle = [cancelTitle copy] ?: @"Cancel";
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
    self.containerView.layer.cornerRadius = 20.f;
    self.containerView.layer.masksToBounds = YES;
    [self.view addSubview:self.containerView];

    self.contentStackView = [[UIStackView alloc] init];
    self.contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentStackView.axis = UILayoutConstraintAxisVertical;
    self.contentStackView.spacing = 20.f;
    [self.containerView addSubview:self.contentStackView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.titleLabel.textColor = UIColor.labelColor;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = self.titleText;
    [self.contentStackView addArrangedSubview:self.titleLabel];

    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.messageLabel.textColor = UIColor.secondaryLabelColor;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.text = self.messageText;
    self.messageLabel.hidden = (self.messageText.length == 0);
    [self.contentStackView addArrangedSubview:self.messageLabel];

    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.confirmButton setTitle:self.confirmButtonTitle forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.confirmButton.backgroundColor = [UIColor primaryGreen];
    self.confirmButton.layer.cornerRadius = 12.f;
    self.confirmButton.layer.masksToBounds = YES;
    [self.confirmButton addTarget:self action:@selector(handleConfirmTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentStackView addArrangedSubview:self.confirmButton];

    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:UIColor.secondaryLabelColor forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [self.cancelButton addTarget:self action:@selector(handleCancelTap) forControlEvents:UIControlEventTouchUpInside];
    [self.contentStackView addArrangedSubview:self.cancelButton];

    UITapGestureRecognizer *backgroundTap =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackgroundTap:)];
    backgroundTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:backgroundTap];
}

- (void)setupConstraints {
    self.containerView.layoutMargins = UIEdgeInsetsMake(28.f, 24.f, 24.f, 24.f);

    [NSLayoutConstraint activateConstraints:@[
        [self.containerView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.containerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.containerView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:32.f],
        [self.containerView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-32.f],
        [self.containerView.widthAnchor constraintGreaterThanOrEqualToConstant:self.view.frame.size.width * 0.9],


        [self.contentStackView.topAnchor constraintEqualToAnchor:self.containerView.layoutMarginsGuide.topAnchor],
        [self.contentStackView.leadingAnchor constraintEqualToAnchor:self.containerView.layoutMarginsGuide.leadingAnchor],
        [self.contentStackView.trailingAnchor constraintEqualToAnchor:self.containerView.layoutMarginsGuide.trailingAnchor],
        [self.contentStackView.bottomAnchor constraintEqualToAnchor:self.containerView.layoutMarginsGuide.bottomAnchor],

        [self.confirmButton.heightAnchor constraintEqualToConstant:52.f]
    ]];
}

- (void)handleConfirmTap {
    if (self.confirmHandler) {
        [self dismissViewControllerAnimated:true completion:^{
            self.confirmHandler();
        }];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)handleCancelTap {
    if (self.cancelHandler) {
        [self dismissViewControllerAnimated:true completion:^{
            self.cancelHandler();
        }];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)handleBackgroundTap:(UITapGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:self.view];
    if (!CGRectContainsPoint(self.containerView.frame, location)) {
        [self handleCancelTap];
    }
}

@end
