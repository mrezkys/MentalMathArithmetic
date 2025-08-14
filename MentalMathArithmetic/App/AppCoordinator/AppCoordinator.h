//
//  AppCoordinator.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef AppCoordinator_h
#define AppCoordinator_h

#import <Foundation/Foundation.h>
#import "Router.h"

@interface AppCoordinator : NSObject
-(instancetype)initWithRouter:(id<Router>)router;
-(void)start;
@end

#endif /* AppCoordinator_h */
