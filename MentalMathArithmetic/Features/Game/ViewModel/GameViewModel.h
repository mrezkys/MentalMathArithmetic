//
//  GameViewModel.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef GameViewModel_h
#define GameViewModel_h

#import <Foundation/Foundation.h>

@class GameQuestionState;
@class GameSession;

NS_ASSUME_NONNULL_BEGIN

@interface GameViewModel : NSObject

@property (nonatomic, readonly) NSInteger repetitionCount;
@property (nonatomic, readonly) NSInteger totalRepetitions;
@property (nonatomic, readonly) NSInteger spelledNumberCount;
@property (nonatomic, readonly) NSInteger totalNumberCount;
@property (nonatomic, strong, readonly, nullable) GameQuestionState *currentQuestionState;
@property (nonatomic, strong, readonly, nullable) GameSession *currentSession;

@property (nonatomic, assign, readonly) BOOL isPaused;

- (void)start;
- (void)togglePause;
- (void)checkAnswer:(NSString *)answer;
- (BOOL)advanceToNextQuestion;
- (BOOL)hasActiveSession;

@end

NS_ASSUME_NONNULL_END


#endif /* GameViewModel_h */
