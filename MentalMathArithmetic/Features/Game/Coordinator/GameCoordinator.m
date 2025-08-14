//
//  GameCoordinator.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "GameCoordinator.h"
#import "Router.h"

@interface GameCoordinator ()
@property (nonatomic, strong) id<Router> router;
@end

@implementation GameCoordinator

- (instancetype)initWithRouter:(id<Router>)router {
    if(self = [super init]) {
        _router = router;
    }
    return  self;
}

@end
