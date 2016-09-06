//
//  CCCalculatorButtonData.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/4/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCCalculatorButtonData.h"
#import "CCConstants.h"

@implementation CCCalculatorButtonData

#define kButtonTag @"buttonTag"
#define kType @"type"
#define kHasSecondFunction @"hasSecondFunction"
#define kActivateSecondFunction @"activateSecondFunction"
#define kButtonColor @"buttonColor"

#define kDisplayNumberColor @"displayNumberColor"
#define kDisplayString @"displayString"
#define kEquationString @"equationString"
#define kSecondaryDisplayString @"secondaryDisplayString"
#define kSecondaryEquationString @"secondaryEquationString"
#define kButtonDisplayString @"buttonDisplayString"
#define kButtonSecondaryDisplayString @"buttonSecondaryDisplayString"

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self){
        NSArray *dictionaryKeys = [dictionary allKeys];
        
        self.buttonTag = [dictionary[kButtonTag] intValue];
        self.type = [dictionary[kType] intValue];
        self.hasSecondFunction = [dictionary[kHasSecondFunction] boolValue];
        self.displayString = dictionary[kDisplayString];
        self.equationString = dictionary[kEquationString];
        self.secondaryDisplayString = dictionary[kSecondaryDisplayString];
        self.secondaryEquationString = dictionary[kSecondaryEquationString];

        
        //optional keys
        if ([dictionaryKeys containsObject:kButtonDisplayString]){
            self.buttonDisplayString = dictionary[kButtonDisplayString];
        }
        if ([dictionaryKeys containsObject:kButtonSecondaryDisplayString]){
            self.buttonSecondaryDisplayString = dictionary[kButtonSecondaryDisplayString];
        }
        
        //default values
        self.displayNumberColor = [UIColor blackColor];
        
        switch (self.type) {
            case CCCalculatorButtonDataBasicTypeNumber:
                                break;
            case CCCalculatorButtonDataBasicTypeOperation:
            case CCCalculatorButtonDataBasicTypeAnswer:
            case CCCalculatorButtonDataBasicTypeOtherPunctuation:
                
                
                break;
            default:
                
                break;
        }
    }
    return self;
}

#pragma mark - properties
- (NSString *)displayString
{
    if(!_displayString || [_displayString isEqualToString:@""]){
        _displayString = self.equationString;
    }
    return _displayString;
}

- (NSString *)buttonDisplayString
{
    if (!_buttonDisplayString){
        _buttonDisplayString = self.displayString;
    }
    return _buttonDisplayString;
}

- (NSString *)secondaryDisplayString
{
    if (!_secondaryDisplayString || [_secondaryDisplayString isEqualToString:@""]){
        _secondaryDisplayString = self.secondaryEquationString;
    }
    return _secondaryDisplayString;
}

- (NSString *)buttonSecondaryDisplayString
{
    if (!_buttonSecondaryDisplayString){
        _buttonSecondaryDisplayString = self.secondaryDisplayString;
    }
    return _buttonSecondaryDisplayString;
}

- (UIColor *)displayNumberColor
{
    if (!_displayNumberColor){
        return [UIColor whiteColor];
    }
    return _displayNumberColor;
}

- (UIColor *)originaldisplayNumberColor
{
    if (!_originaldisplayNumberColor){
        return [UIColor whiteColor];
    }
    return _originaldisplayNumberColor;
}

- (UIColor *)symbolColor
{
    if (!_symbolColor){
        return [UIColor blackColor];
    }
    return _symbolColor;
}

#pragma mark - ns coding protocol
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self){
        self.buttonTag = [aDecoder decodeIntegerForKey:kButtonTag];
        self.type = [aDecoder decodeIntForKey:kType];
        self.hasSecondFunction = [aDecoder decodeBoolForKey:kHasSecondFunction];
        self.activateSecondFunction = [aDecoder decodeBoolForKey:kActivateSecondFunction];
        self.displayString = [aDecoder decodeObjectForKey:kDisplayString];
        self.equationString = [aDecoder decodeObjectForKey:kEquationString];
        self.secondaryDisplayString = [aDecoder decodeObjectForKey:kSecondaryDisplayString];
        self.secondaryEquationString = [aDecoder decodeObjectForKey:kSecondaryEquationString];
        self.buttonDisplayString = [aDecoder decodeObjectForKey:kButtonDisplayString];
        self.buttonSecondaryDisplayString = [aDecoder decodeObjectForKey:kButtonSecondaryDisplayString];

        self.displayNumberColor = [aDecoder decodeObjectForKey:kDisplayNumberColor];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInt:(int)self.buttonTag forKey:kButtonTag];
    [aCoder encodeInt:self.type forKey:kType];
    [aCoder encodeBool:self.hasSecondFunction forKey:kHasSecondFunction];
    [aCoder encodeBool:self.activateSecondFunction forKey:kActivateSecondFunction];
    
    [aCoder encodeObject:self.displayString forKey:kDisplayString];
    [aCoder encodeObject:self.equationString forKey:kEquationString];
    [aCoder encodeObject:self.secondaryDisplayString forKey:kSecondaryDisplayString];
    [aCoder encodeObject:self.secondaryEquationString forKey:kSecondaryEquationString];
    [aCoder encodeObject:self.buttonDisplayString forKey:kButtonDisplayString];
    [aCoder encodeObject:self.buttonSecondaryDisplayString forKey:kButtonSecondaryDisplayString];
    

    [aCoder encodeObject:self.displayNumberColor forKey:kDisplayNumberColor];
}


@end
