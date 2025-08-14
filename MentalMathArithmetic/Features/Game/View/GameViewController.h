//
//  GameViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <UIKit/UIKit.h>
#import "GameViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

- (instancetype)initWithViewModel: (GameViewModel *)vm;

@end

NS_ASSUME_NONNULL_END
