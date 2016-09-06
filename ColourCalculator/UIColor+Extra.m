//
//  UIColor+Extra.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/7/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "UIColor+Extra.h"

@implementation UIColor (Extra)

- (BOOL)isColorDark
{
    const CGFloat *componentColors = CGColorGetComponents(self.CGColor);
    CGFloat colorBrightness = ((componentColors[0] * 299) + (componentColors[1] * 587) + (componentColors[2] * 114)) / 1000;
    if (colorBrightness < 0.6){
        return YES;
    }else{
        return NO;
    }
}

@end
