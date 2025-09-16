//
//  ConfirmationModalViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

#ifndef ConfirmationModalView_h
#define ConfirmationModalView_h
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ConfirmationModalActionHandler)(void);

@interface ConfirmationModalViewController : UIViewController

@property(nonatomic, copy, nullable) ConfirmationModalActionHandler confirmHandler;
@property(nonatomic, copy, nullable) ConfirmationModalActionHandler cancelHandler;

- (instancetype)initWithTitle:(NSString *)title
                      message:(nullable NSString *)message
                 confirmTitle:(nullable NSString *)confirmTitle
                  cancelTitle:(nullable NSString *)cancelTitle;

- (instancetype)initWithCoder:(NSCoder *)coder;

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil
                         bundle:(nullable NSBundle *)nibBundleOrNil;

@end

NS_ASSUME_NONNULL_END

#endif
