//
//  GameResultViewController.h
//  MentalMathArithmetic
//
//  Created by Codex on 2025/xx/xx.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GameResultViewControllerBackHandler)(void);

@interface GameResultViewController : UIViewController

- (instancetype)initWithAverageRepetition:(CGFloat)averageRepetition
                                 accuracy:(CGFloat)accuracy
                        correctAnswerCount:(NSInteger)correctAnswerCount
                        totalQuestionCount:(NSInteger)totalQuestionCount NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;

@property (nonatomic, copy, nullable) GameResultViewControllerBackHandler backToHomeHandler;

@end

NS_ASSUME_NONNULL_END
