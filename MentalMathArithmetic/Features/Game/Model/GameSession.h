#import <Foundation/Foundation.h>
#import "GameQuestionState.h"

@class GameQuestion;

NS_ASSUME_NONNULL_BEGIN

@interface GameSession : NSObject

@property (nonatomic, copy, readonly) NSArray<GameQuestion *> *questions;
@property (nonatomic, assign, readonly) NSInteger currentQuestionIndex;
@property (nonatomic, assign, readonly) NSInteger score;
@property (nonatomic, assign, readonly) NSInteger correctAnswerCount;
@property (nonatomic, assign, readonly, getter=isCompleted) BOOL completed;
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *questionStatuses;
@property (nonatomic, copy, readonly) NSArray<NSNumber *> *questionRepetitionCounts;

- (instancetype)initWithQuestions:(NSArray<GameQuestion *> *)questions NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (nullable GameQuestion *)currentQuestion;
- (BOOL)advanceToNextQuestion;
- (void)recordAnswerStatus:(GameQuestionAnswerStatus)status;
- (void)recordRepetitionCountForCurrentQuestion:(NSInteger)count;
- (NSInteger)remainingQuestions;

@end

NS_ASSUME_NONNULL_END
