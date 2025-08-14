//
//  UIView+Borders.h
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 15/08/25.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIBorderSide) {
    UIBorderSideTop = 1 << 0,
    UIBorderSideBottom = 1 << 1,
    UIBorderSideLeft = 1 << 2,
    UIBorderSideRight = 1 << 3,
    UIBorderSideAll = UIBorderSideTop | UIBorderSideBottom | UIBorderSideLeft | UIBorderSideRight
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Borders)

- (void)addBorderOnSide:(UIBorderSide)side color:(UIColor *)color width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
