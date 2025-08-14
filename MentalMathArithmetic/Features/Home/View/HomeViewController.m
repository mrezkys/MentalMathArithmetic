//
//  HomeViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 11/08/25.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)initWithViewModel:(HomeViewModel *)vm {
    if (self = [super init]) {
        _viewModel = vm;
    }
    return self;
}

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [[UIStackView alloc] init];
        _mainStackView.alignment = UIStackViewAlignmentFill;
        _mainStackView.distribution = UIStackViewDistributionFill;
        _mainStackView.spacing = 20;
        _mainStackView.axis = UILayoutConstraintAxisVertical;
        _mainStackView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _mainStackView;
}

- (UIImageView *)mainIllustrationImageView {
    if(!_mainIllustrationImageView) {
        _mainIllustrationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainIllustration"]];
        _mainIllustrationImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainIllustrationImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _mainIllustrationImageView;
}

- (UIStackView *)buttonWrapperStackView {
    if (!_buttonWrapperStackView) {
        _buttonWrapperStackView = [[UIStackView alloc] init];
        _buttonWrapperStackView.alignment = UIStackViewAlignmentFill;
        _buttonWrapperStackView.distribution = UIStackViewDistributionFill;
        _buttonWrapperStackView.spacing = 16;
        _buttonWrapperStackView.axis = UILayoutConstraintAxisHorizontal;
        _buttonWrapperStackView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _buttonWrapperStackView;
}

- (UIButton *)startGameButton {
    if(!_startGameButton) {
        _startGameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_startGameButton setTitle:@"Start Game" forState:UIControlStateNormal];
        _startGameButton.backgroundColor = [UIColor colorWithRed:0.22 green:0.60 blue:0.84 alpha:1.0]; // hex #3799D6
        
        _startGameButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];

        _startGameButton.layer.cornerRadius = 8;
        _startGameButton.layer.masksToBounds = true;
        [_startGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal]; 

        _startGameButton.translatesAutoresizingMaskIntoConstraints = false;
        
        [_startGameButton addTarget:self action:@selector(didTapStart) forControlEvents:UIControlEventTouchUpInside];

    }
    return _startGameButton;
}

- (UIButton *)learnButton {
    if (!_learnButton) {
        _learnButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        UIImage *icon = [UIImage systemImageNamed:@"book.pages"];
        if (icon) {
            icon = [icon imageWithTintColor:[UIColor whiteColor] renderingMode:UIImageRenderingModeAlwaysOriginal];
            [_learnButton setImage:icon forState:UIControlStateNormal];
            _learnButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        
        _learnButton.backgroundColor = [UIColor colorWithRed:0.192 green:0.671 blue:0.271 alpha:1.0];
        
        _learnButton.layer.cornerRadius = 16;
        _learnButton.layer.masksToBounds = YES;
        
        _learnButton.tintColor = [UIColor whiteColor];
        
        _learnButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _learnButton;
}


- (UIImageView *)footerIllustrationImageView {
    if(!_footerIllustrationImageView) {
        _footerIllustrationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bookIllustration"]];
        _footerIllustrationImageView.contentMode = UIViewContentModeScaleAspectFit;
        _footerIllustrationImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _footerIllustrationImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultView];
}

- (void)setupDefaultView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupFooterIllustrationImageView];
    [self setupMainStackView];
}


- (void)setupFooterIllustrationImageView {
    [self.view addSubview:self.footerIllustrationImageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.footerIllustrationImageView.bottomAnchor
         constraintEqualToAnchor:self.view.bottomAnchor
        ],
        [self.footerIllustrationImageView.leadingAnchor
         constraintEqualToAnchor:self.view.leadingAnchor
         constant:16
        ],
        [self.footerIllustrationImageView.trailingAnchor
         constraintEqualToAnchor:self.view.trailingAnchor
         constant:-16
        ]
    ]];
}

- (void)setupMainStackView {
    [self.view addSubview:self.mainStackView];

    [NSLayoutConstraint activateConstraints:@[
        [
            self.mainStackView.leadingAnchor
            constraintEqualToAnchor:self.view.leadingAnchor
            constant:16
        ],
        [
            self.mainStackView.trailingAnchor
            constraintEqualToAnchor:self.view.trailingAnchor
            constant:-16
        ],
        [
            self.mainStackView.centerYAnchor
            constraintEqualToAnchor:self.view.centerYAnchor
        ]
    ]];
    
    
    [self setupMainIllustrationImageView];
    [self setupButtonWrapperStackView];
}

- (void)setupMainIllustrationImageView {
    [self.mainStackView addArrangedSubview:self.mainIllustrationImageView];
}

- (void)setupButtonWrapperStackView {
    
    [self.mainStackView addArrangedSubview:self.buttonWrapperStackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [
            self.buttonWrapperStackView.heightAnchor
            constraintEqualToConstant:80
        ],
    ]];
    
    [self.buttonWrapperStackView addArrangedSubview:self.startGameButton];
    [self.buttonWrapperStackView addArrangedSubview:self.learnButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [
            self.learnButton.heightAnchor
            constraintEqualToConstant:80
        ],
        [
            self.learnButton.widthAnchor
            constraintEqualToConstant:80
        ],
    ]];
    
}

- (void)didTapStart {
    [self.viewModel startGameTapped];
}


@end
