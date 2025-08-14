//
//  UIView+Borders.m
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 15/08/25.
//

#import "UIView+Borders.h"

@implementation UIView (Borders)

- (void)addBorderOnSide:(UIBorderSide)side color:(UIColor *)color width:(CGFloat)width {
    if (side & UIBorderSideTop) {
        [self removeBorderOnSide:UIBorderSideTop];
        CALayer *topBorder = [CALayer layer];
        topBorder.name = @"topBorder";
        topBorder.backgroundColor = color.CGColor;
        [self.layer addSublayer:topBorder];
        
        UIView *borderView = [self viewWithTag:[self tagForSide:UIBorderSideTop]];
        if(borderView) [borderView removeFromSuperview];

        borderView = [[UIView alloc] init];
        borderView.tag = [self tagForSide:UIBorderSideTop];
        borderView.backgroundColor = color;
        borderView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:borderView];
        
        [NSLayoutConstraint activateConstraints:@[
            [borderView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [borderView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [borderView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [borderView.heightAnchor constraintEqualToConstant:width]
        ]];
    }
    
    if (side & UIBorderSideBottom) {
        UIView *borderView = [self viewWithTag:[self tagForSide:UIBorderSideBottom]];
        if(borderView) [borderView removeFromSuperview];

        borderView = [[UIView alloc] init];
        borderView.tag = [self tagForSide:UIBorderSideBottom];
        borderView.backgroundColor = color;
        borderView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:borderView];
        
        [NSLayoutConstraint activateConstraints:@[
            [borderView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [borderView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [borderView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [borderView.heightAnchor constraintEqualToConstant:width]
        ]];
    }
    
    if (side & UIBorderSideLeft) {
        UIView *borderView = [self viewWithTag:[self tagForSide:UIBorderSideLeft]];
        if(borderView) [borderView removeFromSuperview];

        borderView = [[UIView alloc] init];
        borderView.tag = [self tagForSide:UIBorderSideLeft];
        borderView.backgroundColor = color;
        borderView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:borderView];
        
        [NSLayoutConstraint activateConstraints:@[
            [borderView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [borderView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [borderView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [borderView.widthAnchor constraintEqualToConstant:width]
        ]];
    }
    
    if (side & UIBorderSideRight) {
        UIView *borderView = [self viewWithTag:[self tagForSide:UIBorderSideRight]];
        if(borderView) [borderView removeFromSuperview];

        borderView = [[UIView alloc] init];
        borderView.tag = [self tagForSide:UIBorderSideRight];
        borderView.backgroundColor = color;
        borderView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:borderView];
        
        [NSLayoutConstraint activateConstraints:@[
            [borderView.topAnchor constraintEqualToAnchor:self.topAnchor],
            [borderView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [borderView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
            [borderView.widthAnchor constraintEqualToConstant:width]
        ]];
    }
}

- (NSInteger)tagForSide:(UIBorderSide)side {
    return 8000 + side;
}

- (void)removeBorderOnSide:(UIBorderSide)side {
    for (CALayer *layer in [self.layer.sublayers copy]) {
        if (side & UIBorderSideTop && [layer.name isEqualToString:@"topBorder"]) {
            [layer removeFromSuperlayer];
        }
        if (side & UIBorderSideBottom && [layer.name isEqualToString:@"bottomBorder"]) {
            [layer removeFromSuperlayer];
        }
        if (side & UIBorderSideLeft && [layer.name isEqualToString:@"leftBorder"]) {
            [layer removeFromSuperlayer];
        }
        if (side & UIBorderSideRight && [layer.name isEqualToString:@"rightBorder"]) {
            [layer removeFromSuperlayer];
        }
    }
}

@end
