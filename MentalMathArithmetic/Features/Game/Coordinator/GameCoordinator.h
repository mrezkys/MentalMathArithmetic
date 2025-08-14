//
//  GameCoordinator.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef GameCoordinator_h
#define GameCoordinator_h

#import <Foundation/Foundation.h>
#import "Router.h"

@interface GameCoordinator : NSObject
- (instancetype)initWithRouter:(id<Router>)router;
@end

#endif /* GameCoordinator_h */
