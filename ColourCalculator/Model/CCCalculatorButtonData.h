//
//  CCCalculatorButtonData.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/4/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCCalculatorButtonData : NSObject<NSCoding>

@property (assign, nonatomic) NSInteger buttonTag;

@property (assign, nonatomic) CCCalculatorButtonDataBasicType type;
@property (assign, nonatomic) BOOL hasSecondFunction;
@property (assign, nonatomic) BOOL activateSecondFunction;

@property (strong, nonatomic) UIColor *displayNumberColor;

@property (strong, nonatomic) UIColor *originaldisplayNumberColor;

@property (strong, nonatomic) UIColor *symbolColor;

@property (strong, nonatomic) NSString *displayString;
@property (strong, nonatomic) NSString *equationString;

@property (strong, nonatomic) NSString *secondaryDisplayString;
@property (strong, nonatomic) NSString *secondaryEquationString;

@property (strong, nonatomic) NSString *buttonDisplayString;
@property (strong, nonatomic) NSString *buttonSecondaryDisplayString;

@property (strong, nonatomic) NSString *buttonString;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
