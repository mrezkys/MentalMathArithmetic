//
//  HomeViewModel.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef HomeViewModel_h
#define HomeViewModel_h

#import <Foundation/Foundation.h>


@interface HomeViewModel : NSObject
@property(nonatomic, copy) void (^onStartGame)(void);
- (void)startGameTapped;
@end

#endif /* HomeViewModel_h */
