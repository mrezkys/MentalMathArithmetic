#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GameQuestionOperator) {
    GameQuestionOperatorNone = 0,
    GameQuestionOperatorAdd,
    GameQuestionOperatorSubtract,
    GameQuestionOperatorMultiply,
    GameQuestionOperatorDivide,
};

FOUNDATION_EXPORT NSString *GameQuestionOperatorSymbol(GameQuestionOperator operatorType);
FOUNDATION_EXPORT NSString *GameQuestionOperatorSpeech(GameQuestionOperator operatorType);

@interface GameQuestionComponent : NSObject

@property (nonatomic, assign, readonly) GameQuestionOperator operatorType;
@property (nonatomic, assign, readonly) NSInteger value;

- (instancetype)initWithOperator:(GameQuestionOperator)operatorType value:(NSInteger)value NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

@interface GameQuestion : NSObject

@property (nonatomic, copy, readonly) NSArray<GameQuestionComponent *> *components;
@property (nonatomic, assign, readonly) NSInteger expectedResult;

- (instancetype)initWithComponents:(NSArray<GameQuestionComponent *> *)components NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (NSString *)promptString;

@end

NS_ASSUME_NONNULL_END
