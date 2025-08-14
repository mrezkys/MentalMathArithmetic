//
//  HomeCoordinator.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "HomeCoordinator.h"
#import "../ViewModel/HomeViewModel.h"
#import "../View/HomeViewController.h"

@interface HomeCoordinator ()
@property (nonatomic, strong) id<Router> router;
@end


@implementation HomeCoordinator

- (instancetype)initWithRouter:(id<Router>)router {
    if (self = [super init]) {
        _router = router;
    }
    return self;
}

- (void)start {
    HomeViewModel *viewModel = [[HomeViewModel alloc] init];
    __weak typeof(self) weakSelf = self;
    viewModel.onStartGame = ^{ [weakSelf showGame]; };
    HomeViewController *vc = [[HomeViewController alloc] initWithViewModel:viewModel];
    [self.router setRoot:vc];
}

- (void)showGame {
}

@end
