//
//  AnswerFeedbackView.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 20/08/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AnswerFeedbackType) {
    AnswerFeedbackTypeCorrect,
    AnswerFeedbackTypeIncorrect
};

@interface AnswerFeedbackView : UIView

- (void)configureWithAnswer:(NSString *)answer type:(AnswerFeedbackType)type;

@end

NS_ASSUME_NONNULL_END
