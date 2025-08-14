//
//  HomeViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 11/08/25.
//

#import <UIKit/UIKit.h>
#import "../ViewModel/HomeViewModel.h"

@interface HomeViewController : UIViewController
- (instancetype)initWithViewModel:(HomeViewModel *)vm;

@property (nonatomic, strong) UIStackView *mainStackView;
@property (nonatomic, strong) UIImageView *mainIllustrationImageView;
@property (nonatomic, strong) UIStackView *buttonWrapperStackView;
@property (nonatomic, strong) UIButton *startGameButton;
@property (nonatomic, strong) UIButton *learnButton;

@property (nonatomic, strong) UIImageView *footerIllustrationImageView;

@property (nonatomic, strong) HomeViewModel *viewModel;

@end
