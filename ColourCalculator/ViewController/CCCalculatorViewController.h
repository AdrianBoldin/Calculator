//
//  CCCalculatorViewController.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/27/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MPColorTools.h"
#import <Affdex/Affdex.h>
@interface CCCalculatorViewController : UIViewController <AFDXDetectorDelegate>

- (IBAction)unwindToCalculator:(UIStoryboardSegue *)sender;
@property (strong) AFDXDetector *detector;

@property(nonatomic)Boolean practiceflag;
@property(nonatomic)Boolean congruentcolorflag;
@property(nonatomic)Boolean incongruentcolorflag;
@property(nonatomic)Boolean blackflag;
@property(nonatomic)Boolean numberColorFlag;
@property(nonatomic)Boolean inputflag;
@property(nonatomic) int condition;
@property (nonatomic) int temppageorder;
@property (nonatomic)Boolean finishtestflag;
@property (nonatomic)Boolean time3flag;
@property (nonatomic)Boolean time2flag;
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;

@end
