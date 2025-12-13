//
//  GameViewModel.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import "GameViewModel.h"
#import "GameSession.h"
#import "GameQuestion.h"
#import "GameQuestionState.h"

static const NSInteger GameViewModelDefaultRepetitionCount = 3;
static const NSTimeInterval GameViewModelSpellingInterval = 1.0;

@interface GameViewModel ()

@property (nonatomic, strong, readwrite, nullable) GameQuestionState *currentQuestionState;
@property (nonatomic, strong, readwrite, nullable) GameSession *currentSession;
@property (nonatomic, strong) NSTimer *spellingTimer;
@property (nonatomic, assign, readwrite) NSInteger repetitionCount;
@property (nonatomic, assign, readwrite) NSInteger totalRepetitions;
@property (nonatomic, assign, readwrite) NSInteger spelledNumberCount;
@property (nonatomic, assign, readwrite) NSInteger totalNumberCount;
@property (nonatomic, assign, readwrite) BOOL isPaused;

@end

@implementation GameViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _totalRepetitions = GameViewModelDefaultRepetitionCount;
        _repetitionCount = 0;
        _spelledNumberCount = 0;
        _totalNumberCount = 0;
        _isPaused = NO;
    }
    return self;
}
    
- (void)togglePause {
    self.isPaused = !self.isPaused;
    if (self.isPaused) {
        [self invalidateSpellingTimer];
    } else {
        if (self.currentQuestionState && [self.currentQuestionState isAwaitingAnswer]) {
            [self startSpellingTimerIfNeeded];
        }
    }
}

- (void)dealloc {
    [self invalidateSpellingTimer];
}

- (void)start {
    [self invalidateSpellingTimer];

    self.currentSession = [self buildSessionWithQuestionCount:4];
    [self prepareCurrentQuestion];
    [self startSpellingTimerIfNeeded];
}

- (void)checkAnswer:(NSString *)answer {
    if (!self.currentQuestionState) {
        return;
    }

    NSString *normalizedAnswer = answer != nil ? answer : @"";
    NSString *trimmedAnswer = [normalizedAnswer stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL hasInput = trimmedAnswer.length > 0;

    NSInteger providedValue = 0;
    BOOL isNumeric = NO;

    if (hasInput) {
        NSScanner *scanner = [NSScanner scannerWithString:trimmedAnswer];
        isNumeric = [scanner scanInteger:&providedValue] && scanner.isAtEnd;
    }

    GameQuestionAnswerStatus status = GameQuestionAnswerStatusPending;
    if (isNumeric) {
        status = (providedValue == self.currentQuestionState.question.expectedResult)
                     ? GameQuestionAnswerStatusCorrect
                     : GameQuestionAnswerStatusIncorrect;
    }

    [self.currentQuestionState recordAnswer:trimmedAnswer status:status];

    if (status != GameQuestionAnswerStatusPending) {
        [self.currentSession recordAnswerStatus:status];
        [self stopSpellingAndResetProgress];
    }
}

- (BOOL)advanceToNextQuestion {
    if (![self hasActiveSession]) {
        return NO;
    }

    BOOL advanced = [self.currentSession advanceToNextQuestion];
    if (advanced) {
        [self prepareCurrentQuestion];
        [self startSpellingTimerIfNeeded];
    } else {
        [self handleSessionCompleted];
    }
    return advanced;
}

- (BOOL)hasActiveSession {
    return self.currentSession != nil && !self.currentSession.isCompleted;
}

- (NSInteger)repetitionCount {
    return _repetitionCount;
}

- (NSInteger)totalRepetitions {
    return _totalRepetitions;
}

- (NSInteger)spelledNumberCount {
    return _spelledNumberCount;
}

- (NSInteger)totalNumberCount {
    return _totalNumberCount;
}

#pragma mark - Private

- (GameSession *)buildSessionWithQuestionCount:(NSInteger)count {
    NSMutableArray<GameQuestion *> *questions = [NSMutableArray arrayWithCapacity:count];

    for (NSInteger index = 0; index < count; index++) {
        [questions addObject:[self generateRandomQuestion]];
    }

    return [[GameSession alloc] initWithQuestions:questions];
}

- (GameQuestion *)generateRandomQuestion {
    NSUInteger componentCount = 3 + arc4random_uniform(3); // 3 - 5 components
    NSMutableArray<GameQuestionComponent *> *components = [NSMutableArray arrayWithCapacity:componentCount];

    NSInteger firstValue = 1 + arc4random_uniform(9);
    [components addObject:[[GameQuestionComponent alloc] initWithOperator:GameQuestionOperatorNone value:firstValue]];

    for (NSUInteger index = 1; index < componentCount; index++) {
        GameQuestionOperator operatorType = [self randomOperator];
        NSInteger value = 1 + arc4random_uniform(9);
        [components addObject:[[GameQuestionComponent alloc] initWithOperator:operatorType value:value]];
    }

    return [[GameQuestion alloc] initWithComponents:components];
}

- (GameQuestionOperator)randomOperator {
    uint32_t random = arc4random_uniform(2);
    return random == 0 ? GameQuestionOperatorAdd : GameQuestionOperatorSubtract;
}

- (void)prepareCurrentQuestion {
    GameQuestion *question = self.currentSession.currentQuestion;
    if (!question) {
        self.currentQuestionState = nil;
        [self resetProgressCountersWithTotalComponents:0];
        return;
    }

    self.currentQuestionState = [[GameQuestionState alloc] initWithQuestion:question];
    NSInteger componentCount = (NSInteger)question.components.count;
    [self resetProgressCountersWithTotalComponents:componentCount];
}

- (void)resetProgressCountersWithTotalComponents:(NSInteger)componentCount {
    [self invalidateSpellingTimer];

    self.totalRepetitions = GameViewModelDefaultRepetitionCount;
    self.repetitionCount = self.totalRepetitions > 0 ? 1 : 0;
    self.spelledNumberCount = 0;
    self.totalNumberCount = MAX(componentCount, 1);
}

- (void)startSpellingTimerIfNeeded {
    if (self.repetitionCount == 0 || self.totalNumberCount == 0) {
        return;
    }

    [self invalidateSpellingTimer];
    self.spellingTimer = [NSTimer scheduledTimerWithTimeInterval:GameViewModelSpellingInterval
                                                          target:self
                                                        selector:@selector(handleSpellingTick)
                                                        userInfo:nil
                                                         repeats:YES];
}

- (void)handleSpellingTick {
    if (self.spelledNumberCount < self.totalNumberCount) {
        self.spelledNumberCount += 1;
        
        NSInteger componentIndex = self.spelledNumberCount - 1;
        if (componentIndex < self.currentQuestionState.question.components.count) {
            GameQuestionComponent *component = self.currentQuestionState.question.components[componentIndex];
            [self.delegate gameViewModel:self didSpellComponent:component];
        }
        
    } else {
        if (self.repetitionCount < self.totalRepetitions) {
            self.repetitionCount += 1;
            self.spelledNumberCount = 0;
            // The timer will fire again and the count will start from 0.
            // But since it's not invalidated, it will continue.
        } else {
            [self invalidateSpellingTimer];
            // Keep the spelledNumberCount at totalNumberCount to show a full circle.
        }
    }
}

- (void)handleSessionCompleted {
    self.currentQuestionState = nil;
    [self invalidateSpellingTimer];
    self.totalRepetitions = GameViewModelDefaultRepetitionCount;
    self.repetitionCount = 0;
    self.spelledNumberCount = 0;
    self.totalNumberCount = 0;
}

- (void)invalidateSpellingTimer {
    if (self.spellingTimer) {
        [self.spellingTimer invalidate];
        self.spellingTimer = nil;
    }
}

- (void)stopSpellingAndResetProgress {
    [self invalidateSpellingTimer];

    if (self.totalRepetitions > 0) {
        self.repetitionCount = 1;
    } else {
        self.repetitionCount = 0;
    }

    self.spelledNumberCount = 0;
}

@end
