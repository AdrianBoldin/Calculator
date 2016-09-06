//
//  CCConstants.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/28/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#ifndef ColourCalculator_CCConstants_h
#define ColourCalculator_CCConstants_h

#pragma mark - View/Phone Method
#define isRetina ([[UIScreen mainScreen] bounds].size.height == 568)

typedef enum : NSUInteger {
    CCCalculatorButtonDataBasicTypeNumber = 0,
    CCCalculatorButtonDataBasicTypeOperation,
    CCCalculatorButtonDataBasicTypeFunction,
    CCCalculatorButtonDataBasicTypeOtherPunctuation,
    CCCalculatorButtonDataBasicTypeConstant,
    CCCalculatorButtonDataBasicTypeCalculatorFunction,
    CCCalculatorButtonDataBasicTypeAnswer,
    CCCalculatorButtonDataBasicTypeM
} CCCalculatorButtonDataBasicType;

typedef enum : NSUInteger {
    CCNumberButtonZero = 0,
    CCNumberButtonOne,
    CCNumberButtonTwo,
    CCNumberButtonThree,
    CCNumberButtonFour,
    CCNumberButtonFive,
    CCNumberButtonSix,
    CCNumberButtonSeven,
    CCNumberButtonEight,
    CCNumberButtonNine
} CCNumberButton;

typedef enum : NSUInteger {
    CCOperationButtonAdd = 11,
    CCOperationButtonSubtract,
    CCOperationButtonMultiply,
    CCOperationButtonDivide
} CCOperationButton;

typedef enum : NSUInteger {
    CCOtherBasicFunctionsButtonPoint = 21,
    CCOtherBasicFunctionsButtonPercentage,
    CCOtherBasicFunctionsButtonNegate,
    CCOtherBasicFunctionsButtonLeftParenthesis,
    CCOtherBasicFunctionsButtonRightParenthesis,
    CCOtherBasicFunctionsButtonAC
} CCOtherBasicFunctionsButton;

typedef enum : NSUInteger {
    CCTrigonometricButtonSin = 31,
    CCTrigonometricButtonArcSin,
    CCTrigonometricButtonCos,
    CCTrigonometricButtonArcCos,
    CCTrigonometricButtonTan,
    CCTrigonometricButtonArcTan
} CCTrigonometricButton;

typedef enum : NSUInteger {
    CCHyperbolicButtonSinh = 41,
    CCHyperbolicButtonArcSinh,
    CCHyperbolicButtonCosh,
    CCHyperbolicButtonArcCosh,
    CCHyperbolicButtonTanh,
    CCHyperbolicButtonArcTanh
} CCHyperbolicButton;

typedef enum : NSUInteger {
    CCExponentialButtonEuler = 61,
    CCExponentialButtonY, 
    CCExponentialButtonBase10,
    CCExponentialButtonBase2
} CCExponentialButton;

typedef enum : NSUInteger {
    CCLogarithmicButtonNaturalLog = 71,
    CCLogarithmicButtonLogBaseY,
    CCLogarithmicButtonLogBase10,
    CCLogarithmicButtonLogBase2
} CCLogarithmicButton;

typedef enum : NSUInteger {
    CCPowerButtonSquare = 81,
    CCPowerButtonCube,
    CCPowerButtonNegative1,
    CCPowerButtonX
} CCPowerButton;

typedef enum : NSUInteger {
    CCRootButtonSquare = 91,
    CCRootButtonCube,
    CCRootButtonX
} CCRootButton;

typedef enum : NSUInteger {
    CCConstantsAndRandomButtonEuler = 101,
    CCConstantsAndRandomButtonPi,
    CCConstantsAndRandomButtonRandom
} CCConstantsAndRandomButton;

typedef enum : NSUInteger {
    CCOtherScientificFunctionsButton2ndFunction = 111,
    CCOtherScientificFunctionsButtonFactorial,
    CCOtherScientificFunctionsButtonDegreeOrRadians,
    CCOtherScientificFunctionsButtonBackspace
} CCOtherScientificFunctionsButton;

typedef enum : NSUInteger {
    CCMButtonMC = 121,
    CCMButtonMPlus,
    CCMButtonMMinus,
    CCMButtonMR
} CCMButton;

#endif
