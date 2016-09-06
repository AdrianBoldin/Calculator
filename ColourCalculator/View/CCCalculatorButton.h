//
//  CCCalculatorButton.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/27/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CCCalculatorButtonData;


@interface CCCalculatorButton : UIButton

@property (strong, nonatomic) CCCalculatorButtonData *buttonData;
@property (strong, nonatomic) CCCalculatorButtonData *tempbuttonData;
@property (strong, nonatomic) UIColor *buttonColor;
@property (strong, nonatomic) NSString *baseTextString;
@property (strong, nonatomic) NSAttributedString *textString;

@property (assign, nonatomic) BOOL hasSecondFunction;
@property (assign, nonatomic) BOOL secondFunction;
@property (nonatomic)int i;
@property (nonatomic)Boolean callmethodflag;
- (void)reloadButtonColor;
- (void)loadincongruentBottonColor;
- (void)reloadButtonData;
-(void)loadbalkButtonColor;

- (NSAttributedString *)coloredDisplayString;
- (NSString *)buttonDisplayString;
- (NSString *)equationString;

@end
