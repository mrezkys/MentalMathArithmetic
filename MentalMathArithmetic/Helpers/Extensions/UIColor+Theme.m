//
//  UIColor+Theme.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 15/08/25.
//

#import <UIKit/UIKit.h>

@implementation UIColor (Theme)

+ (UIColor *) primaryBlue {
    return [self named:@"primaryBlue" fallback:[UIColor systemBlueColor]];
}

+ (UIColor *)lightBlue {
    return [self named:@"lightBlue" fallback:[UIColor colorWithRed:0.90 green:0.96 blue:1.0 alpha:1.0]];
}

+ (UIColor *)primaryGreen {
    return [self named:@"primaryGreen" fallback:[UIColor systemGreenColor]];
}

+ (UIColor *)primaryPurple {
    return [self named:@"primaryPurple" fallback:[UIColor systemPurpleColor]];
}

+ (UIColor *)darkPurple {
    return [self named:@"darkPurple" fallback:[UIColor colorWithRed:0.27 green:0.25 blue:0.53 alpha:1.0]];
}

+ (UIColor *)primaryRed {
    return [self named:@"primaryRed" fallback:[UIColor systemRedColor]];
}

+ (UIColor *)primaryYellow {
    return [self named:@"primaryYellow" fallback:[UIColor systemYellowColor]];
}


// private helper
+ (UIColor *)named:(NSString *)name fallback:(UIColor *)fallback {
    UIColor *c = nil;
    if (@available(iOS 11.0, *)) {
        // looks in main bundle's Assets.xcassets
        c = [UIColor colorNamed:name];
    }
    return c ?: fallback;
}

@end
