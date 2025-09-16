//
//  ConfirmationModalViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

#ifndef TimeCounterModalViewController_h
#define TimeCounterModalViewController_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TimeCounterModalCompletionHandler)(void);

@interface TimeCounterModalViewController : UIViewController

@property (nonatomic, copy, nullable) TimeCounterModalCompletionHandler completionHandler;

- (instancetype)initWithTitle:(NSString *)title
                startingValue:(NSInteger)seconds;
- (instancetype)initWithCoder:(NSCoder *)coder;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil;

@end

NS_ASSUME_NONNULL_END


#endif
