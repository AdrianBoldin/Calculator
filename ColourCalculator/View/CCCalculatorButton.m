//
//  CCCalculatorButton.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/27/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCCalculatorButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extra.h"

#import "CCUserDataManager.h"
#import "CCCalculatorButtonData.h"
#import "MPColorTools.h"
#import "CCAppDelegate.h"


@interface CCCalculatorButton ()

@property (strong, nonatomic) NSString *displayString;

@end

@implementation CCCalculatorButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){

        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5.0f;
        
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.i++;
        
        self.buttonData = [[CCUserDataManager sharedManager] getButtonDataForTag:self.tag];
        
        [self setupButton];

    }
    return self;
}

#pragma mark - properties
- (CCCalculatorButtonData *)buttonData
{
    if (!_buttonData){
        _buttonData = [[CCUserDataManager sharedManager] getButtonDataForTag:self.tag];
    }
    return _buttonData;
}

- (void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    self.backgroundColor = buttonColor;
}

- (void)setSecondFunction:(BOOL)secondFunction
{
    if (self.hasSecondFunction){
        _secondFunction = secondFunction;
        [self reloadButtonData];
    }

}
- (BOOL)hasSecondFunction
{
    return self.buttonData.hasSecondFunction;
}

- (NSString *)displayString
{
    return (self.secondFunction && self.hasSecondFunction) ? self.buttonData.secondaryDisplayString : self.buttonData.displayString;
}

#pragma mark - private methods
- (void)setupButton
{
    if (!self.buttonData){
        _baseTextString = @"ERROR";
        self.titleLabel.text = _baseTextString;
        return;
    }
    self.titleLabel.text = self.secondFunction ? self.buttonData.secondaryDisplayString : self.buttonData.buttonDisplayString;
    _baseTextString = self.secondFunction ? self.buttonData.secondaryEquationString : self.buttonData.equationString;
}

#pragma mark - public 
- (void)reloadButtonColor
{
    _buttonData = nil;    
    // UIColor *textColor = (self.buttonData.displayNumberColor ? self.buttonData.displayNumberColor : ([self.buttonData.buttonColor isColorDark] ? [UIColor whiteColor] : [UIColor blackColor]));
    if(self.buttonData.buttonTag<10){
        [self setTitleColor:self.buttonData.originaldisplayNumberColor forState:UIControlStateNormal];
        self.buttonData.displayNumberColor = self.buttonData.originaldisplayNumberColor;
    }else{
        [self setTitleColor:self.buttonData.symbolColor forState:UIControlStateNormal];
        self.buttonData.displayNumberColor = self.buttonData.symbolColor;
    }
    
    

}

- (void)loadincongruentBottonColor{
    
    _buttonData = nil;
    if(self.buttonData.displayNumberColor){
        if(self.buttonData.buttonTag<10){
           
            UIColor *textColor = [self complementaryColor:self.buttonData.originaldisplayNumberColor];
            [self setTitleColor:textColor forState:UIControlStateNormal];
            self.buttonData.displayNumberColor = textColor;
        }else{
            UIColor *textColor = [self complementaryColor:self.buttonData.symbolColor];
            [self setTitleColor:textColor forState:UIControlStateNormal];
            self.buttonData.displayNumberColor = textColor;
        }
 
    }

}

-(void)loadbalkButtonColor {
    
    _buttonData = nil;
    
    UIColor *textColor = [UIColor blackColor] ;
    [self setTitleColor:textColor forState:UIControlStateNormal];
    self.buttonData.displayNumberColor = textColor;
    //[[CCUserDataManager sharedManager] updateButtonColor:textColor forButtonData:self.buttonData];
}

-(UIColor *)complementaryColor:(UIColor *)incongruentcolor {
    
    CGFloat r,g,b,a;
    UIColor *complementary = [incongruentcolor complementaryColor];
    [complementary getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

- (void)reloadButtonData
{
    self.titleLabel.text = self.secondFunction ? self.buttonData.secondaryDisplayString : self.buttonData.buttonDisplayString;
    [self setTitle:self.titleLabel.text forState:UIControlStateNormal];
    _baseTextString = self.secondFunction ? self.buttonData.secondaryEquationString : self.buttonData.equationString;
}

- (NSAttributedString *)coloredDisplayString
{
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithString:self.displayString attributes:@{NSForegroundColorAttributeName:self.buttonData.displayNumberColor}];
    [temp addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:16] range:NSMakeRange(0, self.displayString.length)];
    
    return temp;
}

- (NSString *)buttonDisplayString
{
    return (self.secondFunction && self.hasSecondFunction) ? self.buttonData.buttonSecondaryDisplayString : self.buttonData.buttonDisplayString;
}

- (NSString *)equationString
{
    return (self.secondFunction && self.hasSecondFunction) ? self.buttonData.secondaryEquationString : self.buttonData.equationString;
}



@end
