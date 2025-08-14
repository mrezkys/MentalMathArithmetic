//
//  NavRouter.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "NavRouter.h"

@interface NavRouter ()
@property (nonatomic, weak) UINavigationController *nav;
@end

@implementation NavRouter

- (instancetype)initWithNavigationController:(UINavigationController *)nav {
    if (self = [super init]) {
        _nav = nav;
    }
    return self;
}

- (void)setRoot:(UIViewController *)vc {
    [self.nav setViewControllers:@[vc] animated:NO];
}

- (void)push:(UIViewController *)vc animated:(BOOL)animated {
    [self.nav pushViewController:vc animated:animated];
}

- (void)present:(UIViewController *)vc animated:(BOOL)animated completion:(void (^)(void))completion {
    [self.nav presentViewController:vc animated:animated completion:completion];
}

- (void)popAnimated:(BOOL)animated {
    [self.nav popViewControllerAnimated:animated];
}

@end
