//
//  CCCalculatorNumberData.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/7/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNumberText @"numberText"
#define kNumber @"number"
#define kColor @"color"
#define kOColor @"originalcolor"

@interface CCCalculatorNumberData : NSObject<NSCoding>

@property (strong, nonatomic) NSString *numberText;
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *originalcolor;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
