//
//  GameViewController.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#import <UIKit/UIKit.h>
#import "GameViewModel.h"

@interface GameViewController : UIViewController <GameViewModelDelegate>
- (instancetype)initWithViewModel:(GameViewModel *)vm;
@end
