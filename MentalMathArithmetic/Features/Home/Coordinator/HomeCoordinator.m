//
//  HomeCoordinator.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "HomeCoordinator.h"
#import "HomeViewModel.h"
#import "HomeViewController.h"
#import "GameViewModel.h"
#import "GameViewController.h"
#import "GameResultViewController.h"

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
    GameViewModel *vm = [GameViewModel new];
    GameViewController *vc = [[GameViewController alloc] initWithViewModel:vm];
    
    __weak typeof(self) weakSelf = self;
    vc.onSessionEnd = ^(CGFloat averageRepetition, CGFloat accuracy, NSInteger correctAnswerCount, NSInteger totalQuestionCount) {
        [weakSelf showGameResultWithAverageRepetition:averageRepetition
                                             accuracy:accuracy
                                    correctAnswerCount:correctAnswerCount
                                    totalQuestionCount:totalQuestionCount];
    };
    
    [self.router push:vc animated:true];
}

- (void)showGameResultWithAverageRepetition:(CGFloat)averageRepetition
                                    accuracy:(CGFloat)accuracy
                           correctAnswerCount:(NSInteger)correctAnswerCount
                           totalQuestionCount:(NSInteger)totalQuestionCount {
    GameResultViewController *vc = [[GameResultViewController alloc]
        initWithAverageRepetition:averageRepetition
                         accuracy:accuracy
                correctAnswerCount:correctAnswerCount
                totalQuestionCount:totalQuestionCount];
    
    __weak typeof(self) weakSelf = self;
    vc.backToHomeHandler = ^{
        [weakSelf.router popToRootAnimated:YES];
    };
    
    [self.router push:vc animated:YES];
}

@end
