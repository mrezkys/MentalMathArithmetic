//
//  AppCoordinator.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "AppCoordinator.h"
#import "HomeCoordinator.h"

@interface AppCoordinator ()
@property (nonatomic, strong) id<Router> router;
@property (nonatomic, strong) HomeCoordinator *homeCoordinator;
@end

@implementation AppCoordinator

- (instancetype)initWithRouter:(id<Router>)router {
    if (self = [super init]) {
        _router = router;
    }
    return self;
}

- (void)start {
    self.homeCoordinator = [[HomeCoordinator alloc] initWithRouter:self.router];
    [self.homeCoordinator start];
}

@end
