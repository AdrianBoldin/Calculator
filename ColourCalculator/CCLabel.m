//
//  CCLabel.m
//  ColourCalculator
//
//  Created by Adrian on 7/20/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCLabel.h"

@implementation CCLabel

-(void)drawTextInRect:(CGRect)rect{
    UIEdgeInsets insets = {10 ,0};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

@end
