//
//  HomeViewModel.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "HomeViewModel.h"

@implementation HomeViewModel

- (void)startGameTapped {
    if (self.onStartGame) {
        self.onStartGame();
    }
}

@end
