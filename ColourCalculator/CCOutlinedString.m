//
//  CCOutlinedString.m
//  ColourCalculator
//
//  Created by Adrian on 7/19/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCOutlinedString.h"

@implementation CCOutlinedString

-(NSAttributedString *)str:(UIColor *)color String:(NSString *)string{
    
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName : color,
                                       NSStrokeColorAttributeName : [UIColor blackColor],
                                       NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]
                                       };
    
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:string attributes:buttonAttributes];
    
    return str;
    
}


@end
