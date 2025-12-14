#import "GameSession.h"
#import "GameQuestion.h"

@interface GameSession ()

@property (nonatomic, copy, readwrite) NSArray<GameQuestion *> *questions;
@property (nonatomic, assign, readwrite) NSInteger currentQuestionIndex;
@property (nonatomic, assign, readwrite) NSInteger score;
@property (nonatomic, assign, readwrite) NSInteger correctAnswerCount;
@property (nonatomic, assign, readwrite, getter=isCompleted) BOOL completed;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *mutableQuestionStatuses;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *mutableQuestionRepetitionCounts;

@end

@implementation GameSession

- (instancetype)initWithQuestions:(NSArray<GameQuestion *> *)questions {
    NSParameterAssert(questions.count > 0);
    self = [super init];
    if (self) {
        _questions = [questions copy];
        _currentQuestionIndex = 0;
        _score = 0;
        _correctAnswerCount = 0;
        _completed = NO;
        _mutableQuestionStatuses = [NSMutableArray arrayWithCapacity:questions.count];
        _mutableQuestionRepetitionCounts = [NSMutableArray arrayWithCapacity:questions.count];

        for (NSUInteger index = 0; index < questions.count; index++) {
            [_mutableQuestionStatuses addObject:@(GameQuestionAnswerStatusPending)];
            [_mutableQuestionRepetitionCounts addObject:@0];
        }
    }
    return self;
}

- (NSArray<NSNumber *> *)questionStatuses {
    return [self.mutableQuestionStatuses copy];
}

- (NSArray<NSNumber *> *)questionRepetitionCounts {
    return [self.mutableQuestionRepetitionCounts copy];
}

- (GameQuestion *)currentQuestion {
    if (self.completed) {
        return nil;
    }

    if (self.currentQuestionIndex < self.questions.count) {
        return self.questions[self.currentQuestionIndex];
    }

    return nil;
}

- (BOOL)advanceToNextQuestion {
    if (self.completed) {
        return NO;
    }

    NSInteger nextIndex = self.currentQuestionIndex + 1;
    if (nextIndex >= self.questions.count) {
        self.completed = YES;
        return NO;
    }

    self.currentQuestionIndex = nextIndex;
    return YES;
}

- (void)recordAnswerStatus:(GameQuestionAnswerStatus)status {
    if (status == GameQuestionAnswerStatusPending) {
        return;
    }

    if (self.completed || self.currentQuestionIndex >= self.mutableQuestionStatuses.count) {
        return;
    }

    GameQuestionAnswerStatus previousStatus = (GameQuestionAnswerStatus)self.mutableQuestionStatuses[self.currentQuestionIndex].unsignedIntegerValue;

    if (previousStatus == status) {
        return;
    }

    self.mutableQuestionStatuses[self.currentQuestionIndex] = @(status);

    if (status == GameQuestionAnswerStatusCorrect) {
        if (previousStatus != GameQuestionAnswerStatusCorrect) {
            self.correctAnswerCount += 1;
            self.score += 1;
        }
    } else if (previousStatus == GameQuestionAnswerStatusCorrect && status != GameQuestionAnswerStatusCorrect) {
        // Adjust score if a correct answer was overwritten by a wrong one.
        self.correctAnswerCount = MAX(self.correctAnswerCount - 1, 0);
        self.score = MAX(self.score - 1, 0);
    }
}

- (void)recordRepetitionCountForCurrentQuestion:(NSInteger)count {
    if (self.completed || self.currentQuestionIndex >= self.mutableQuestionRepetitionCounts.count) {
        return;
    }

    NSInteger sanitized = MAX(count, 0);
    self.mutableQuestionRepetitionCounts[self.currentQuestionIndex] = @(sanitized);
}

- (NSInteger)remainingQuestions {
    if (self.completed) {
        return 0;
    }

    return (NSInteger)self.questions.count - self.currentQuestionIndex - 1;
}

@end
