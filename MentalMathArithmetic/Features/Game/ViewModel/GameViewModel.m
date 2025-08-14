//
//  GameViewModel.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <Foundation/Foundation.h>
#import "GameViewModel.h"

@interface GameViewModel ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation GameViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _repetitionCount = 1;
        _totalRepetitions = 3;
        _spelledNumberCount = 0;
        _totalNumberCount = 10; // Example value
    }
    return self;
}

- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
}

- (void)tick {
    if (self.spelledNumberCount < self.totalNumberCount) {
        _spelledNumberCount++;
        [self.delegate viewModelDidUpdate:self];
    } else {
        [self.timer invalidate];
        self.timer = nil;

        if (self.repetitionCount < self.totalRepetitions) {
            _repetitionCount++;
            _spelledNumberCount = 0;
            [self.delegate viewModelDidUpdate:self];
            [self start];
        }
    }
}

@end
