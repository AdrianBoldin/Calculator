//
//  CCAppDelegate.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/27/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCCalculatorButtonData.h"
@interface CCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong, nonatomic)NSMutableDictionary *participantTestInfo;
@property (nonatomic)int surveycalltimes;
@property (nonatomic)int testordernumber;
@property (nonatomic)int callCalculatorVCcounts;
@property (strong, nonatomic) CCCalculatorButtonData *tempbuttonData;
@property (nonatomic) int nuberdatacount;
@property (nonatomic)Boolean handRightFlag;

@end
