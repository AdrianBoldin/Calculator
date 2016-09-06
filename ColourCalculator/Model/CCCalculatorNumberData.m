//
//  CCCalculatorNumberData.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/7/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCCalculatorNumberData.h"

@implementation CCCalculatorNumberData

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self){
        self.number = dictionary[kNumber];
        self.numberText = dictionary[kNumberText] ? dictionary[kNumberText] : [NSString stringWithFormat:@"%@",self.number];
        self.color = dictionary[kColor];
        self.originalcolor = dictionary[kOColor];
    }
    return self;
}

#pragma mark - properties
- (UIColor *)color
{
    if (!_color){
        return [UIColor blackColor];
    }
    return _color;
}

- (UIColor *)originalcolor
{
    if (!_originalcolor){
        return [UIColor blackColor];
    }
    return _originalcolor;
}

#pragma mark - ns coding protocol
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self){
        self.number = [aDecoder decodeObjectForKey:kNumber];
        self.numberText = [aDecoder decodeObjectForKey:kNumberText];
        self.color = [aDecoder decodeObjectForKey:kColor];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{    
    [aCoder encodeObject:self.number forKey:kNumber];
    [aCoder encodeObject:self.numberText forKey:kNumberText];
    [aCoder encodeObject:self.color forKey:kColor];
}

@end
