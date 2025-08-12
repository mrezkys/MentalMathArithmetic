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
- (UIImageView *)mainIllustrationImageView {
    if(!_mainIllustrationImageView) {
        _mainIllustrationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainIllustration"]];
        _mainIllustrationImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainIllustrationImageView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return  _mainIllustrationImageView;
}

- (UIStackView *)mainStackView {
    if (!_mainStackView) {
        _mainStackView = [[UIStackView alloc] init];
        _mainStackView.alignment = UIStackViewAlignmentCenter;
        _mainStackView.distribution = UIStackViewDistributionFill;
        _mainStackView.spacing = 20;
        _mainStackView.axis = UILayoutConstraintAxisVertical;
        _mainStackView.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _mainStackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultView];
}

- (void)setupDefaultView {
    printf("triggered");
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    [self.mainStackView addArrangedSubview:self.mainIllustrationImageView];
    
    
}






@end
