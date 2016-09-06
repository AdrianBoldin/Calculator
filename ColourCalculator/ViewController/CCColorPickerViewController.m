//
//  CCColorPickerViewController.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/7/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCColorPickerViewController.h"
#import "NKOColorPickerView.h"
#import "UIColor+Extra.h"
#import <QuartzCore/QuartzCore.h>

#import "CCCalculatorViewController.h"
#import "CCCalculatorNumberData.h"
#import "CCCalculatorButtonData.h"
#import "CCParticipantsTestResult.h"
#import "CCAppDelegate.h"
#import "CCInstructionPopUp.h"

typedef enum : NSUInteger {
    CCColorPickerModeButtonBackground,
    CCColorPickerModeCalculatorText,
} CCColorPickerMode;

@interface CCColorPickerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *calculatorLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonBackground;
@property (weak, nonatomic) IBOutlet UIButton *calculatorText;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) UIView *instructionview;
@property (strong, nonatomic) NSArray *buttonDataArray;
@property (strong, nonatomic) NSArray *numberDataArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allofButtons;

@property (assign, nonatomic) CCColorPickerMode currentMode;
@property (weak, nonatomic) UIButton *previousButtonSelected;

@property (strong, nonatomic) NKOColorPickerView *colorPickerView;

@property (strong, nonatomic) UIColor *selectedColor;
@property (nonatomic) Boolean colorPickerflag;
@property (assign, nonatomic) BOOL buttonChange;



@end

@implementation CCColorPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.buttonDataArray = [[CCUserDataManager sharedManager] standardButtonData];
    
    self.index = 0;
    self.temp = 100;
    [self setupButtons];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self initializeObjects:self.index];
    [self instructionView];
}

-(void)instructionView{
    
    self.instructionview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.05 , self.view.frame.size.height * 0.1, self.view.frame.size.width * 0.9, self.view.frame.size.height * 0.85)];
    self.instructionview.backgroundColor = [UIColor blackColor];
    self.instructionview.alpha = 0.8;
    
    NSArray *stringarray = [NSArray arrayWithObjects:@"INSTRUCTIONS:",@"To pick your colours:", @"1. Press a number or symbol on the keypad", @"2. The number or symbol will apper in the lager tile above the keypad.",@"3. Using the colour picker, select hue and saturation",@"4. To change a colour, simply re-press that number or symbol on the keypad.", @"5. When you have selected ALL your colours press the 'next' tile.",nil];
    for(int i = 1; i<stringarray.count + 1 ;i++){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 60*i, 650, 60)];
        label.textColor = [UIColor whiteColor];
        label.text = [stringarray objectAtIndex:i-1];
        if(i == 1){
           [label setFont:[UIFont systemFontOfSize:24]];
        }else{
           [label setFont:[UIFont systemFontOfSize:19]];
        }
        
        [self.instructionview addSubview:label];
    }
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.instructionview.frame.size.width-40, self.instructionview.frame.origin.y-20, 30, 30)];
    [button setTitle:@"X" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventAllEvents];
    
    [self.instructionview addSubview:button];
    [self.view addSubview:self.instructionview];
}

-(void)buttonPressed{
    [self.instructionview removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)initializeObjects:(int)tag
{
    if(self.index == 0){
        self.buttonData = nil;
    }else{
       self.buttonData = self.buttonDataArray[tag];
    }
    
    self.calculatorLabel.textColor = self.buttonData.displayNumberColor;
    self.calculatorLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.calculatorLabel.layer.borderWidth = 1.0;
    
    self.calculatorLabel.layer.masksToBounds = YES;
    self.calculatorLabel.layer.cornerRadius = 5.0f;
    self.calculatorLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    //self.calculatorLabel.text = self.buttonData.buttonDisplayString;
    self.selectedColor = self.calculatorLabel.textColor;
    
    
    [self setupColorPicker];
   
    self.calculatorText.titleLabel.textAlignment = NSTextAlignmentCenter;
    /*if (!isRetina){
        
        NSInteger shift = 25.0f;
        
        CGRect labelFrame = self.calculatorLabel.frame;
        labelFrame.origin.x -= shift;
        self.calculatorLabel.frame = labelFrame;
        
        CGRect textFrame = self.calculatorText.frame;
        textFrame.origin.x -= shift;
        self.calculatorText.frame = textFrame;
        
        CGRect bgFrame = self.buttonBackground.frame;
        bgFrame.origin.x -= shift;
        self.buttonBackground.frame = bgFrame;
    
    }*/
    
}

- (IBAction)nextbutton:(id)sender {
    
    self.colorPickerflag = true;
    // save buttondata and numberdata
    
    if(self.temp !=100){
        [self saveColor:self.temp];
    }
    
    int r = arc4random() % 6;
    CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    [ccParticipantsTestResult createDictionary:@"Block Order" value:[NSString stringWithFormat:@"%d",r]];
    CCCalculatorViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"calculatorView"];
    viewController.practiceflag = true;

    CCAppDelegate *ccAppDelegate = (CCAppDelegate*)[[UIApplication sharedApplication]delegate];
    ccAppDelegate.testordernumber = r;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)instructionPopUp:(id)sender {
    
    [self instructionView];
}


-(void)setupButtons{
    
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSStrokeColorAttributeName : [UIColor blackColor],
                                       NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]
                                       };
    
    self.nextButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.nextButton.layer.borderWidth = 1.0;
    self.nextButton.layer.cornerRadius = 7;
    self.nextButton.clipsToBounds = YES;
    
    self.instructionButton.layer.borderColor = [[UIColor grayColor]CGColor];
    self.instructionButton.layer.borderWidth = 1.0;
    self.instructionButton.layer.cornerRadius = 7;
    self.instructionButton.clipsToBounds = YES;
    
    for(UIButton *button in self.allofButtons){
        
        button.layer.borderColor = [[UIColor grayColor]CGColor];
        button.layer.borderWidth = 1.0;
        button.layer.cornerRadius = 7;
        button.clipsToBounds = YES;
        
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:button.currentTitle attributes:buttonAttributes];
        if(button.tag < 10){
            [button setAttributedTitle:str forState:UIControlStateNormal];
        }
        
        UITapGestureRecognizer *longPress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [button addGestureRecognizer:longPress];
    }
    
    if(self.handRightFlag == true){
        self.keypadX = [NSLayoutConstraint constraintWithItem:self.cotentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5f constant:0.0f];
        [self updateViewConstraints];
        
        [self.view addConstraint:self.keypadX];

    }else{
        
        self.keypadX = [NSLayoutConstraint constraintWithItem:self.cotentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.5f constant:0.0f];
        [self updateViewConstraints];
        
        [self.view addConstraint:self.keypadX];
    }
}

-(void)longPress:(UITapGestureRecognizer*)sender{
    
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSStrokeColorAttributeName : [UIColor blackColor],
                                       NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]
                                       };
    NSDictionary *symbolAttributes = @{
                                       NSForegroundColorAttributeName : [UIColor blackColor]
                                       };
    
    if(sender.state){
        self.tempButton = (UIButton *)sender.view;
        self.calculatorLabel.text = [NSString stringWithFormat:@"%@",self.tempButton.currentTitle];
        if(self.tempButton.tag<10){
            
            NSAttributedString *strcalbulatorLabel = [[NSAttributedString alloc]initWithString:self.calculatorLabel.text attributes:buttonAttributes];
            [self.calculatorLabel setAttributedText:strcalbulatorLabel];
        }else{
            
            NSAttributedString *strcalbulatorLabel = [[NSAttributedString alloc]initWithString:self.calculatorLabel.text attributes:symbolAttributes];
            [self.calculatorLabel setAttributedText:strcalbulatorLabel];
        }
        
        int tag = self.tempButton.tag;
        if(self.index != 0){
            [self saveColor:self.temp];
        }
        self.index = 1;
        self.temp = tag;
    }
    
    
}

- (void)setupColorPicker
{
    
    //Color did change block declaration
    __weak typeof(self) weakSelf = self;
    
    NKOColorPickerDidChangeColorBlock colorDidChangeBlock = ^(UIColor *color){
        if(self.calculatorLabel.text.length>0){
            
            weakSelf.selectedColor = color;
            weakSelf.calculatorLabel.textColor = weakSelf.selectedColor;
            NSDictionary *buttonAttributes = @{
                                               NSForegroundColorAttributeName : weakSelf.selectedColor,
                                               NSStrokeColorAttributeName : [UIColor blackColor],
                                               NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]
                                               };
            NSDictionary *symbolAttributes = @{
                                               NSForegroundColorAttributeName: weakSelf.selectedColor
                                               };
            
            NSAttributedString *strcalbulatorLabel = [[NSAttributedString alloc]initWithString:weakSelf.calculatorLabel.text attributes:buttonAttributes];
            NSAttributedString *symbolStrLabel = [[NSAttributedString alloc]initWithString:weakSelf.calculatorLabel.text attributes:symbolAttributes];
            
            if(weakSelf.tempButton!=nil){
                
                NSAttributedString *str = [[NSAttributedString alloc]initWithString:weakSelf.tempButton.currentTitle attributes:buttonAttributes];
                NSAttributedString *nonOutlinedStr = [[NSAttributedString alloc]initWithString:weakSelf.tempButton.currentTitle attributes:symbolAttributes];
                if(weakSelf.tempButton.tag < 10){
                    
                    [weakSelf.calculatorLabel setAttributedText:strcalbulatorLabel];
                    [weakSelf.tempButton setAttributedTitle:str forState:UIControlStateNormal];
                }else{
                    [weakSelf.calculatorLabel setAttributedText:symbolStrLabel];
                    [weakSelf.tempButton setAttributedTitle:nonOutlinedStr forState:UIControlStateNormal];
                }
            }
   
            
        }
        

    };
    
    if(self.handRightFlag == false){

        self.colourPickerViewX = [NSLayoutConstraint constraintWithItem:self.colourPickerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.5f constant:0.0f];
        [self.view addConstraint:self.colourPickerViewX];
        
        self.colorPickerView = [[NKOColorPickerView alloc] initWithFrame:CGRectMake(0, -15, self.colourPickerView.frame.size.width, self.colourPickerView.frame.size.height*1.1) color:[UIColor blackColor] andDidChangeColorBlock:colorDidChangeBlock];
        [self.colourPickerView addSubview:self.colorPickerView];
    }else{
       
        self.colourPickerViewX = [NSLayoutConstraint constraintWithItem:self.colourPickerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:0.5f constant:0.0f];
        [self.view addConstraint:self.colourPickerViewX];
        
        self.colorPickerView = [[NKOColorPickerView alloc] initWithFrame:CGRectMake(0, -15, self.colourPickerView.frame.size.width, self.colourPickerView.frame.size.height*1.1) color:[UIColor blackColor] andDidChangeColorBlock:colorDidChangeBlock];
        [self.colourPickerView addSubview:self.colorPickerView];
    }
    
    self.calculatorLabel.textColor = self.selectedColor;

}

#pragma mark - ibactions

-(NSString *)getRGBValue:(UIColor *)color{
    
    CGColorRef colorRef = [color CGColor];
    
    const CGFloat *rgbint = CGColorGetComponents(colorRef);
    CGFloat redf = rgbint[0];
    int redi = (int)roundf(redf*255);
    NSString *redS = [[NSString alloc]initWithFormat:@"%d",redi];
    
    CGFloat greenf = rgbint[1];
    int greeni = (int)roundf(greenf*255);
    NSString *greenS = [[NSString alloc]initWithFormat:@"%d",greeni];
    
    CGFloat bluef = rgbint[2];
    int bluei = (int)roundf(bluef*255);
    NSString *blueS = [[NSString alloc]initWithFormat:@"%d",bluei];
    
    NSArray *colorArray = [NSArray arrayWithObjects:redS,greenS,blueS, nil];
    
    NSString * result = [colorArray componentsJoinedByString:@","];

    NSLog(@"selectedcolor%@",self.selectedColor);
    
    return result;
}

-(void)saveColor:(int)tag{
    
    self.buttonData = self.buttonDataArray[tag];
    [[CCUserDataManager sharedManager] updateButtonColor:self.selectedColor forButtonData:self.buttonData];
    
    CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    
    [self.colorPickerView removeFromSuperview];
    
    UIColor *complementary = [self.selectedColor complementaryColor];
    
        if(tag == 15){
            
            [ccParticipantsTestResult createDictionary:@"/" value:[self getRGBValue:self.selectedColor]];
            
            [ccParticipantsTestResult createDictionary:@"complementaryColor /" value:[self getRGBValue:complementary]];
            
            
        }else{
            [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"%@",self.buttonData.displayString] value:[self getRGBValue:self.selectedColor]];
            
            [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"complementaryColor %@",self.buttonData.displayString] value:[self getRGBValue:complementary]];
            
        }
        
    if(self.colorPickerflag != true){
        [self initializeObjects:tag];
    }
    
    
}

@end
