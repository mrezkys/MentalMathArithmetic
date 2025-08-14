//
//  GameViewController.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import "GameViewController.h"


@interface GameViewController ()
@property (nonatomic, strong) GameViewModel * viewModel;
@end

@implementation GameViewController

- (instancetype)initWithViewModel:(GameViewModel *)vm {
    if(self = [super init]) {
        _viewModel = vm;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
