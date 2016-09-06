//
//  CCColorPickerViewController.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/7/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUserDataManager.h"
#import "MPColorTools.h"

@interface CCColorPickerViewController : UIViewController

@property (strong, nonatomic) CCCalculatorButtonData *buttonData;
@property (strong, nonatomic) CCCalculatorNumberData *numberData;
@property (strong, nonatomic) UIButton * tempButton;
@property (nonatomic)int index;
@property (nonatomic)Boolean handRightFlag;
@property (nonatomic)int temp;

@property (weak, nonatomic) IBOutlet UIView *cotentView;
@property (weak, nonatomic) IBOutlet UIView *colourPickerView;
@property (weak, nonatomic) IBOutlet UIButton *instructionButton;

@property (weak, nonatomic) NSLayoutConstraint *keypadX;
@property (weak, nonatomic) NSLayoutConstraint *colourPickerViewX;
@end
