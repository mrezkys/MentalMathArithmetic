//
//  GameViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <UIKit/UIKit.h>
#import "GameViewModel.h"

typedef void (^SessionEndHandler)(CGFloat averageRepetition, CGFloat accuracy, NSInteger correctAnswerCount, NSInteger totalQuestionCount);

@interface GameViewController : UIViewController <GameViewModelDelegate>
@property (nonatomic, copy, nullable) SessionEndHandler onSessionEnd;
- (instancetype)initWithViewModel:(GameViewModel *)vm;
@end
