//
//  AnswerQuestionModalViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

#ifndef AnswerQuestionModalViewController_h
#define AnswerQuestionModalViewController_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AnswerQuestionModalSubmitHandler)(NSString * _Nullable answer);
typedef void (^AnswerQuestionModalCancelHandler)(void);

@interface AnswerQuestionModalViewController : UIViewController

@property (nonatomic, copy, nullable) AnswerQuestionModalSubmitHandler submitHandler;
@property (nonatomic, copy, nullable) AnswerQuestionModalCancelHandler cancelHandler;

- (instancetype)initWithTitle:(NSString *)title
                  placeholder:(nullable NSString *)placeholder ;
- (instancetype)initWithCoder:(NSCoder *)coder;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil;

@end

NS_ASSUME_NONNULL_END

#endif /* AnswerQuestionModalViewController_h */
