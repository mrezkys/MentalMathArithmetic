#import "GameQuestionState.h"
#import "GameQuestion.h"

@interface GameQuestionState ()

@property (nonatomic, strong, readwrite) GameQuestion *question;
@property (nonatomic, copy, readwrite) NSString *userAnswer;
@property (nonatomic, assign, readwrite) GameQuestionAnswerStatus answerStatus;
@property (nonatomic, assign, readwrite) NSInteger attempts;

@end

@implementation GameQuestionState

- (instancetype)initWithQuestion:(GameQuestion *)question {
    NSParameterAssert(question != nil);
    self = [super init];
    if (self) {
        _question = question;
        _userAnswer = @"";
        _answerStatus = GameQuestionAnswerStatusPending;
        _attempts = 0;
    }
    return self;
}

- (BOOL)isAwaitingAnswer {
    return self.answerStatus == GameQuestionAnswerStatusPending;
}

- (void)recordAnswer:(NSString *)answer status:(GameQuestionAnswerStatus)status {
    self.userAnswer = answer ?: @"";
    self.answerStatus = status;
    self.attempts += 1;
}

@end
