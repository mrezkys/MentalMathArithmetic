//
//  NavRouter.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef NavRouter_h
#define NavRouter_h

#import <UIKit/UIKit.h>
#import "Router.h"

@interface NavRouter : NSObject<Router>
- (instancetype)initWithNavigationController: (UINavigationController *)nav;
@end

#endif /* NavRouter_h */
