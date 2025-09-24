#import "GameQuestion.h"

NSString *GameQuestionOperatorSymbol(GameQuestionOperator operatorType) {
    switch (operatorType) {
        case GameQuestionOperatorAdd:
            return @"+";
        case GameQuestionOperatorSubtract:
            return @"-";
        case GameQuestionOperatorMultiply:
            return @"×";
        case GameQuestionOperatorDivide:
            return @"÷";
        case GameQuestionOperatorNone:
        default:
            return @"";
    }
}

NSString *GameQuestionOperatorSpeech(GameQuestionOperator operatorType) {
    switch (operatorType) {
        case GameQuestionOperatorAdd:
            return @"plus";
        case GameQuestionOperatorSubtract:
            return @"minus";
        case GameQuestionOperatorMultiply:
            return @"times";
        case GameQuestionOperatorDivide:
            return @"divided by";
        case GameQuestionOperatorNone:
        default:
            return @"";
    }
}

@interface GameQuestionComponent ()

@property (nonatomic, assign, readwrite) GameQuestionOperator operatorType;
@property (nonatomic, assign, readwrite) NSInteger value;

@end

@implementation GameQuestionComponent

- (instancetype)initWithOperator:(GameQuestionOperator)operatorType value:(NSInteger)value {
    self = [super init];
    if (self) {
        _operatorType = operatorType;
        _value = value;
    }
    return self;
}

@end

@interface GameQuestion ()

@property (nonatomic, copy, readwrite) NSArray<GameQuestionComponent *> *components;
@property (nonatomic, assign, readwrite) NSInteger expectedResult;

@end

@implementation GameQuestion

- (instancetype)initWithComponents:(NSArray<GameQuestionComponent *> *)components {
    NSParameterAssert(components.count > 0);
    self = [super init];
    if (self) {
        _components = [components copy];
        [self recalculateExpectedResult];
    }
    return self;
}

- (void)recalculateExpectedResult {
    GameQuestionComponent *firstComponent = self.components.firstObject;
    NSAssert(firstComponent.operatorType == GameQuestionOperatorNone, @"First component must not have an operator");

    NSInteger runningTotal = firstComponent.value;

    for (NSUInteger index = 1; index < self.components.count; index++) {
        GameQuestionComponent *component = self.components[index];
        switch (component.operatorType) {
            case GameQuestionOperatorAdd:
                runningTotal += component.value;
                break;
            case GameQuestionOperatorSubtract:
                runningTotal -= component.value;
                break;
            case GameQuestionOperatorMultiply:
                runningTotal *= component.value;
                break;
            case GameQuestionOperatorDivide:
                if (component.value != 0) {
                    runningTotal /= component.value;
                }
                break;
            case GameQuestionOperatorNone:
            default:
                break;
        }
    }

    self.expectedResult = runningTotal;
}

- (NSString *)promptString {
    NSMutableArray<NSString *> *parts = [NSMutableArray arrayWithCapacity:self.components.count * 2];

    for (NSUInteger index = 0; index < self.components.count; index++) {
        GameQuestionComponent *component = self.components[index];
        if (index == 0) {
            [parts addObject:[NSString stringWithFormat:@"%ld", (long)component.value]];
        } else {
            NSString *symbol = GameQuestionOperatorSymbol(component.operatorType);
            [parts addObject:[NSString stringWithFormat:@"%@ %ld", symbol, (long)component.value]];
        }
    }

    return [parts componentsJoinedByString:@" "];
}

@end
