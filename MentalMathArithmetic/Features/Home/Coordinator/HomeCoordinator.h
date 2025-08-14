//
//  HomeCoordinator.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//



#ifndef HomeCoordinator_h
#define HomeCoordinator_h

#import <Foundation/Foundation.h>
#import "../../../App/Router/Router.h"


@interface HomeCoordinator : NSObject
- (instancetype)initWithRouter:(id<Router>)router;
- (void)start;
@end

#endif /* HomeCoordinator_h */
