//
//  CCCalibrateViewController.h
//  ColourCalculator
//
//  Created by Adrian on 4/5/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCUserDataManager.h"
@interface CCCalibrateViewController : UIViewController

@property(nonatomic)NSInteger i;
@property (nonatomic) UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) CCCalculatorButtonData *buttonData;

@end
