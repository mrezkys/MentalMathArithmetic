//
//  Router.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 14/08/25.
//

#ifndef Router_h
#define Router_h

#import <UIKit/UIKit.h>

@protocol Router <NSObject>

- (void)setRoot:(UIViewController *)vc;
- (void)push:(UIViewController *)vc animated:(BOOL)animated;
- (void)present:(UIViewController *)vc animated:(BOOL)animated completion:(void (^_Nullable)(void))completion;
- (void)popAnimated:(BOOL)animated;


@end

#endif /* Router_h */
