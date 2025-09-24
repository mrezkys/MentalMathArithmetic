#import <Foundation/Foundation.h>

@class GameQuestion;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GameQuestionAnswerStatus) {
    GameQuestionAnswerStatusPending = 0,
    GameQuestionAnswerStatusCorrect,
    GameQuestionAnswerStatusIncorrect,
};

@interface GameQuestionState : NSObject

@property (nonatomic, strong, readonly) GameQuestion *question;
@property (nonatomic, copy, readonly) NSString *userAnswer;
@property (nonatomic, assign, readonly) GameQuestionAnswerStatus answerStatus;
@property (nonatomic, assign, readonly) NSInteger attempts;

- (instancetype)initWithQuestion:(GameQuestion *)question NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (BOOL)isAwaitingAnswer;
- (void)recordAnswer:(nullable NSString *)answer status:(GameQuestionAnswerStatus)status;

@end

NS_ASSUME_NONNULL_END
