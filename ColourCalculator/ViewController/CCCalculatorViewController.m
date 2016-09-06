//
//  CCCalculatorViewController.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 8/27/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCCalculatorViewController.h"

#import "CCCalculatorButton.h"
#import "DDMathParser.h"
#import "NSString+DDMathParsing.h"
#import "UIColor+Extra.h"
#import "CCCalculatorButtonData.h"
#import "CCUserDataManager.h"
#import "CCParticipantsTestResult.h"
#import "CCAdminViewController.h"
#import "CCAppDelegate.h"
#import "CCCalculatorNumberData.h"
#import "CCStartTestViewController.h"
#import "CCRestViewController.h"
#import "CCFinalViewController.h"
#import "CCOutlinedString.h"
#import "CCLabel.h"

#define YOUR_AFFDEX_LICENSE_STRING_GOES_HERE @"{\"token\":\"a1bf4dbe03f52feea228e1e425492dfe2ed18f412b75b9959b9edd72d657b4d7\",\"licensor\":\"Affectiva Inc.\",\"expires\":\"2016-09-28\",\"developerId\":\"jber8397@uni.sydney.edu.au\",\"software\":\"Affdex SDK\"}"

typedef enum : NSUInteger {
    CCCalculatorModeDegree = 0,
    CCCalculatorModeRadians
} CCCalculatorMode;

@interface CCCalculatorViewController ()

@property (strong, nonatomic) IBOutletCollection(CCCalculatorButton) NSArray *allCalculatorButtons;

//text view
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

@property (weak, nonatomic) IBOutlet UITextView *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextbtn;

@property (weak, nonatomic) IBOutlet UITextView *testQuestions;


//NOTE: buttons are grouped according to function, differentiated by their tags
@property (strong, nonatomic) CCOutlinedString *outlinedStringModel;
@property (strong, nonatomic) CCCalculatorButtonData *buttondata;
@property (strong, nonatomic) NSArray *numberDataArray;
@property (strong, nonatomic) IBOutletCollection(CCCalculatorButton) NSArray *numberButtons;
@property (strong, nonatomic) IBOutletCollection(CCCalculatorButton) NSArray *operationButtons;
@property (strong, nonatomic) IBOutletCollection(CCCalculatorButton) NSArray *parenthesisButtons;
@property (strong, nonatomic) IBOutletCollection(CCCalculatorButton) NSArray *inputButtons;
@property (weak, nonatomic) IBOutlet UIView *inputBtnContentView;
@property (weak, nonatomic) IBOutlet UIView *calculatorContentView;
@property (weak, nonatomic) IBOutlet UIView *TestingView;

@property (weak, nonatomic) IBOutlet UILabel *conditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) UIView *instructionview;
//temp data
@property (strong, nonatomic) NSMutableArray *calculatorDisplayTexts;
@property (strong, nonatomic) NSMutableArray *calculatorEquationTexts;

@property (strong, nonatomic) NSNumber *previousNumber;
@property (strong, nonatomic) NSString *previousNumberString;

@property (strong, nonatomic) NSMutableAttributedString *attributedText;
@property (strong, nonatomic) NSMutableAttributedString *temp;
@property (strong, nonatomic) NSMutableAttributedString *inputtemp;
@property (strong, nonatomic) NSDictionary *numberColorDictionary;

@property (strong, nonatomic) NSString *tempInputText;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;
@property (strong, nonatomic) NSMutableAttributedString *tempattributedText;

@property (strong, nonatomic) NSString *equationText;
@property (assign, nonatomic) CCCalculatorMode mode;

//for cube root and x root
@property (assign, nonatomic) BOOL isCubeRoot;
@property (assign, nonatomic) BOOL isXRoot;
@property (strong, nonatomic) NSMutableArray *cubeRootXRootOperations;

@property(strong, nonatomic)NSMutableAttributedString *numberTempString;
@property(strong, nonatomic)NSDictionary *testQuestionDic;
@property (nonatomic)int questionOrderNumber;
@property (nonatomic)CFTimeInterval questionTimewhenfirstloaded;
@property  (nonatomic)CFTimeInterval questionStarttime;
@property(nonatomic)CFTimeInterval time1;
@property(nonatomic)CFTimeInterval time3;
@property(nonatomic)CFTimeInterval time2;
@property(nonatomic)CFTimeInterval time4;
@property (nonatomic) int questionNum;
@property (nonatomic) Boolean colorflag;
@property (nonatomic) int checknum;
@property (nonatomic)int practice;
@property (nonatomic) int i;
@end

@implementation CCCalculatorViewController

#pragma mark - vc lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)processedImageReady:(AFDXDetector *)detector image:(UIImage *)image faces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
{
    //iterate on the valuses of the faces dictionary
    CCParticipantsTestResult *faceEmotionResult = [[CCParticipantsTestResult alloc]init];
    
    for (AFDXFace *face in [faces allValues])
    {
        NSString *emotionwithTests = [[NSString alloc]init];
        if(self.temppageorder == 0){
        
            emotionwithTests = @"Test1Emotion";
        }
        if(self.temppageorder == 1){
            
            emotionwithTests = @"Test2Emotion";
        }
        if(self.temppageorder == 2){
            
            emotionwithTests = @"Test3Emotion";
        }
        
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Joy%d",emotionwithTests, self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.joy]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Anger%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.anger]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Contempt%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.contempt]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Disgust%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.disgust]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Fear%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.fear]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Sadness%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.sadness]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Suprise%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.surprise]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Engagement%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.engagement]];
        [faceEmotionResult createDictionary:[NSString stringWithFormat:@"%@Valence%d",emotionwithTests,self.i] value:[NSString stringWithFormat:@"%.2f",face.emotions.valence]];

        self.i++;
        
    }
    
}

// This is a convenience method that is called by the detector:hasResults:forImage:atTime:delegate method below.
// It handles all Unprocessed imsges from the detector.
-(void)unprocessedImageReady:(AFDXDetector *)detector image:(UIImage *)image atTime:(NSTimeInterval)time;
{
    __block CCCalculatorViewController *weakSelf = self;
    
    //UI work must be on the main thread, so dispatch it there.
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.cameraView setImage:image];
    });
}

-(void)destroyDetector;
{
    [self.detector stop];
}

-(void)createDetector;
{
    //ensure the detector has stopped
    [self destroyDetector];
    
    //create a new detector, set the processing frame rate in frames per second, and set the license string
    self.detector = [[AFDXDetector alloc]initWithDelegate:self usingCamera:AFDX_CAMERA_FRONT maximumFaces:1];
    self.detector.maxProcessRate = 2;
    self.detector.licenseString = YOUR_AFFDEX_LICENSE_STRING_GOES_HERE;
    
    //turn on gender and glasses
    self.detector.gender = TRUE;
    self.detector.glasses = TRUE;
    //turning on a few emotions
    [self.detector setDetectAllEmotions:YES];
    
    //turning on a few expressions
    self.detector.smile = YES;
    self.detector.browRaise = YES;
    self.detector.browFurrow = YES;
    
    //start the detector and check for failure
    NSError *error = [self.detector start];
    
    if(nil !=error){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detector Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{}];
        
        return;
    }
}

#pragma mark -
#pragma mark AFDXDetectorDelegate Methods

// This is the delegate method of the AFDXDetectorDelegate protocol. This method gets called for:
// -Every frame coming in from the camera. In this case, faces is nil
// -Every PROCESSED frame that the detector
-(void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time
{
    if (nil == faces && [self.nextbtn.currentTitle isEqualToString:@"Finish Test"]){
        [self unprocessedImageReady:detector image:image atTime:time];
        [self destroyDetector];
    }
    else
    {
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(q, ^{
            [self processedImageReady:detector image:image faces:faces atTime:time];

        });
        

    }
}

#pragma mark -
#pragma  mark View Methods

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.practiceflag != true){
     
         // create the detector just before the view appears
        self.i=0;
        [self createDetector];
    }
    
    [self clearCalculator:nil];
    self.numberColorFlag = true;
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self destroyDetector]; // destroy the detector before the view disappears
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [self.answerLabel addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    [super viewDidLoad];

    if(self.practiceflag == true){
        self.congruentcolorflag = true;
        self.incongruentcolorflag = false;
        self.blackflag = false;
    }
    
    [self conditionSetup];
    [self viewFrame];
    [self timeSetup];
    
    _numberTempString = [[NSMutableAttributedString alloc]init];
    self.numberDataArray = [[CCUserDataManager sharedManager]numberDisplayData];
    
    [self setup];
    
    //self.questionNum = 1;

}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self instructionView];
}

-(void)instructionView{
    
    self.instructionview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.05 , self.view.frame.size.height * 0.07, self.view.frame.size.width * 0.9, self.view.frame.size.height * 0.85)];
    self.instructionview.backgroundColor = [UIColor blackColor];
    self.instructionview.alpha = 0.8;
    NSArray *stringarray;
    if(self.practiceflag == false){
         stringarray = [NSArray arrayWithObjects:@"INSTRUCTIONS:", @"1. There are three tests of 30 questions each.", @"2. You will be given the option to rest between each one.",@"3. The calculator's colours will be randomly set, for each test, to one of three conditions: Neutral(Black), Congruent(Colours you have picked), Incongruent(Colours complementary to those you have picked)",nil];
    }else{
        stringarray = [NSArray arrayWithObjects:@"INSTRUCTIONS:", @"1. Please read the questions fully.", @"2. For all questions use the calculator to solve.",@"3. Use the separate 'answer' pad to type in the answer.", @"4. To submit and move on press next.",nil];
    }
    
    for(int i = 1; i<stringarray.count + 1 ;i++){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 60*i, 650, 30)];
        if(i == 4 && self.practiceflag == false){
            label = [[UILabel alloc]initWithFrame:CGRectMake(20, 60*i, 650, 70)];
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.numberOfLines = 3;
        }
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


-(void)viewFrame {
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    if(ccAppDelegate.handRightFlag == true){
        NSLayoutConstraint *testingViewLeft = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.TestingView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        [self.view addConstraint:testingViewLeft];
        
        NSLayoutConstraint *calulatorViewX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.calculatorContentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [self.view addConstraint:calulatorViewX];
    }else{
        NSLayoutConstraint *testingViewLeft = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.TestingView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        [self.view addConstraint:testingViewLeft];
        
        NSLayoutConstraint *calulatorViewX = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.calculatorContentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
        [self.view addConstraint:calulatorViewX];
    }
}

-(void)timeSetup {
    
    self.time1 = CACurrentMediaTime();

    self.questionTimewhenfirstloaded = CACurrentMediaTime();
}

-(void)conditionSetup{
    if(self.congruentcolorflag == true){
        
        for (CCCalculatorButton *button in self.allCalculatorButtons){
            
            [button reloadButtonColor];
            if(button.buttonData.buttonTag<10){
                [button setAttributedTitle: [self str:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
            }else{
                [button setAttributedTitle: [self symbolStr:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
            }
        }
        self.questionOrderNumber = 1;
        self.questionNum = 1;
    }
    if(self.incongruentcolorflag == true){
        
        for(CCCalculatorButton *button in self.allCalculatorButtons){
            
            [button loadincongruentBottonColor];
            if(button.buttonData.buttonTag<10){
                
                [button setAttributedTitle: [self str:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
                
            }else{
                [button setAttributedTitle:[self symbolStr:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
            }
            
            
        }
        self.questionOrderNumber = 31;
        self.questionNum = 31;
        
    }
    if(self.blackflag == true){
        
        for(CCCalculatorButton *button in self.allCalculatorButtons){
            
            [button loadbalkButtonColor];
            if(button.buttonData.buttonTag<10){
                [button setAttributedTitle: [self str:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
            }else{
                [button setAttributedTitle: [self symbolStr:button.buttonData.displayNumberColor String:button.buttonData.displayString] forState:UIControlStateNormal];
            }
            
        }
        self.questionOrderNumber = 61;
        self.questionNum = 61;
    }
    
    self.numberColorDictionary = [[CCUserDataManager sharedManager]getNumberColorDictionary];
}

#pragma mark - setup
- (void)setup
{
    [CCUserDataManager sharedManager];
    
    self.inputTextView.text = @"";
    self.outputTextView.text = @"";
    //self.questionOrderNumber = 1;
    CCParticipantsTestResult *ccparticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    self.testQuestionDic = [[NSDictionary alloc]init];
    self.testQuestionDic = [ccparticipantsTestResult readingStringFromQuestionFile];
    
    if(self.practiceflag == false){
       
        self.topLabel.text = [NSString stringWithFormat:@"QUESTION-%d",self.questionOrderNumber];
        NSString *string = [[NSString alloc]initWithFormat:@"Q%d",self.questionOrderNumber];
        self.testQuestions.text = [self.testQuestionDic objectForKey:string];
        self.conditionLabel.hidden = true;
    }
    
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithArray:self.operationButtons];
    
    [buttons addObjectsFromArray:self.parenthesisButtons];
    for (CCCalculatorButton *button in self.allCalculatorButtons){
        if ([self.numberButtons containsObject:button]){
            [button addTarget:self action:@selector(tapNumberButton:) forControlEvents:UIControlEventTouchUpInside];
        }else if ([buttons containsObject:button]){
            [button addTarget:self action:@selector(tapOperationButton:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
    // ---------------layer border and cornerRadius----------------------
    
    self.testQuestions.layer.borderColor = [[UIColor blackColor]CGColor];
    self.testQuestions.layer.borderWidth = 2.0;
    
    self.answerLabel.layer.borderColor = [[UIColor blackColor]CGColor];
    self.answerLabel.layer.borderWidth = 2.0;
    
    self.nextbtn.layer.cornerRadius = 8.0;
    
    self.inputBtnContentView.layer.cornerRadius = 10.0;
    
    self.calculatorContentView.layer.cornerRadius = 10.0;
    
    self.testQuestions.layer.borderColor = [[UIColor grayColor]CGColor];
    self.testQuestions.layer.borderWidth = 2.0;
    
    self.answerLabel.layer.borderColor = [[UIColor grayColor]CGColor];
    self.answerLabel.layer.borderWidth = 2.0;
    
    self.inputTextView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.inputTextView.layer.borderWidth = 2.0;
    
    self.outputTextView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    self.outputTextView.layer.borderWidth = 2.0;
    
    for(UIButton *numberbuttons in self.allCalculatorButtons){
        
        numberbuttons.layer.borderColor = [[UIColor darkGrayColor]CGColor];
        numberbuttons.layer.borderWidth = 2.0;
    }
    
    for(UIButton *button in self.inputButtons){
        
        button.layer.borderColor = [[UIColor grayColor]CGColor];
        button.layer.borderWidth = 2.0;
    }
    //-----------------condition block------------------------------------

    if(self.practiceflag == true){
        
        self.testQuestions.text = @" 0 + 1 = ";
        if(self.incongruentcolorflag == true){
            
            self.testQuestions.text = @" 0 + 2 = ";
        }
        
        if(self.blackflag == true){
            
            self.testQuestions.text = @" 0 + 3 = ";
        }
    }
    
}


#pragma mark - properties
- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter){
        _numberFormatter = [[NSNumberFormatter alloc] init];
    }
    return _numberFormatter;
}

- (NSString *)equationText
{
    if (!_equationText){
        _equationText = @"";
    }
    return _equationText;
}

- (NSMutableAttributedString *)attributedText
{
    if (!_attributedText){
        _attributedText = [[NSMutableAttributedString alloc] init];
    }
    return _attributedText;
}

- (NSMutableAttributedString *)temp;
{
    if (!_temp){
        _temp = [[NSMutableAttributedString alloc] init];
    }
    return _temp;
}

- (NSMutableAttributedString *)inputtemp;
{
    if (!_inputtemp){
        _inputtemp = [[NSMutableAttributedString alloc] init];
    }
    return _inputtemp;
}

- (NSMutableAttributedString *)tempattributedText
{
    if (!_tempattributedText){
        _tempattributedText = [[NSMutableAttributedString alloc] init];
    }
    return _tempattributedText;
}

- (NSMutableArray *)calculatorDisplayTexts
{
    if (!_calculatorDisplayTexts){
        _calculatorDisplayTexts = [[NSMutableArray alloc] init];
    }
    return _calculatorDisplayTexts;
}

- (NSMutableArray *)calculatorEquationTexts
{
    if (!_calculatorEquationTexts){
        _calculatorEquationTexts = [[NSMutableArray alloc] init];
    }
    return _calculatorEquationTexts;
}

#pragma mark - ibactions/calculator functions
- (void)tapNumberButton:(CCCalculatorButton *)sender
{
    if(self.time2flag == false){
        
        self.time2 = CACurrentMediaTime();
        CFTimeInterval Time1 = self.time2-self.time1;
        NSString *readingtime = [[NSString alloc]initWithFormat:@"%.2f",Time1];
        CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
        [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Q%dReadingtime",self.questionNum] value:readingtime];
    }
    
    self.checknum++;
    self.previousNumberString = self.previousNumberString.length == 0 ? [sender equationString] : [self.previousNumberString stringByAppendingString:[sender equationString]];

    [self updateButton:sender withInput:sender.buttonData];

    self.time2flag = true;
}

- (void)tapOperationButton:(CCCalculatorButton *)sender
{
    self.checknum = 0;
    //[self formatInputWithCustomColors];
    self.previousNumberString = @"";
    
    if(self.inputflag == true){
        
        self.attributedText = self.tempattributedText;
    }
    self.inputflag = false;
    [self updateButton:sender withInput:sender.buttonData];
    self.temp = nil;
    self.inputtemp = nil;
    [self.inputtemp appendAttributedString: self.attributedText];
}

- (IBAction)tapOtherBasicCalculatorButton:(CCCalculatorButton *)sender
{
    [self updateButton:sender withInput:sender.buttonData];
}

- (IBAction)clearCalculator:(CCCalculatorButton *)sender
{
    self.inputTextView.text = @"";
    self.outputTextView.text = @"";
    self.equationText = @"";
    self.previousNumberString = @"";
    self.attributedText = [[NSMutableAttributedString alloc] init];
    self.tempattributedText = [[NSMutableAttributedString alloc]init];
    self.inputtemp = [[NSMutableAttributedString alloc]init];
    self.calculatorDisplayTexts = nil;
    self.calculatorEquationTexts = nil;
    self.checknum = 0;
    self.temp = nil;
}

- (IBAction)deleteButtonPressed:(CCCalculatorButton *)sender
{
    if (self.calculatorDisplayTexts.count > 0){
        NSString *toBeRemoved = self.calculatorDisplayTexts[0];
        [self.calculatorDisplayTexts removeObjectAtIndex:0];
        
        NSString *equationToBeRemoved = self.calculatorEquationTexts[0];
        [self.calculatorEquationTexts removeObjectAtIndex:0];
        self.equationText = [self.equationText substringToIndex:self.equationText.length-equationToBeRemoved.length];
        
        self.attributedText = [[self.attributedText attributedSubstringFromRange:NSMakeRange(0,self.attributedText.length-toBeRemoved.length)] mutableCopy];
        self.inputTextView.attributedText = self.attributedText;
        self.inputTextView.textAlignment = NSTextAlignmentRight;
        
        self.outputTextView.text = @"";
    }
}

- (IBAction)getAnswer:(CCCalculatorButton *)sender
{
    [self getAnswer];
}

#pragma mark - private
- (void)updateButton:(CCCalculatorButton *)button withInput:(CCCalculatorButtonData *)data
{
    NSAttributedString *buttonAttributedText = [[NSAttributedString alloc]init];
    if(button.buttonData.buttonTag>10){
        buttonAttributedText = button.currentAttributedTitle;
    }else{
        
        buttonAttributedText = button.currentAttributedTitle;
    }
    
    [self.attributedText appendAttributedString:buttonAttributedText];

    [self.calculatorDisplayTexts insertObject:buttonAttributedText.string atIndex:0];
    [self.calculatorEquationTexts insertObject:[button equationString] atIndex:0];
    [self.attributedText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:27] range:NSMakeRange(0, self.attributedText.string.length)];
    self.inputTextView.attributedText = self.attributedText;
    self.inputTextView.textAlignment = NSTextAlignmentRight;
    self.tempattributedText = self.attributedText;
    
    self.equationText = [self.equationText stringByAppendingString:[button equationString]];
   
}

- (NSMutableAttributedString *)formatOutputStringForAnswerforinputtext:(NSNumber *)answer
{
    return [self formatOutputStringForAnswer:answer];
}

- (NSMutableAttributedString *)formatOutputStringForAnswer:(NSNumber *)answer
{
    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] init];
    
    NSData *colorData = [self.numberColorDictionary objectForKey:answer];
    NSString *numberString = [[NSString alloc]init];
    if([answer intValue]>999999){
        numberString = [NSString stringWithFormat:@"%@",answer];
    }else{
       
        numberString = [NSString stringWithFormat:@"%g",answer.floatValue];
    }

    UIColor *matchColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    if (matchColor){
        [temp appendAttributedString:[[NSAttributedString alloc] initWithString:numberString attributes:@{NSForegroundColorAttributeName:matchColor,NSStrokeColorAttributeName:[UIColor blackColor],NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]}]];
        [temp addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:27] range:NSMakeRange(0, numberString.length)];
        self.outputTextView.attributedText = temp;
        self.outputTextView.textAlignment = NSTextAlignmentRight;
        return temp;
    }
    
    for (int i=0 ;i<numberString.length; i++){
        char character = [numberString characterAtIndex:i];
        NSString *string = [NSString stringWithFormat:@"%c",character];
        UIColor *matchColor = [[UIColor alloc]init];
        if([string isEqualToString:@"."] || [string isEqualToString:@"-"]){
        
            if([string isEqualToString:@"."]){
                
                matchColor = [[CCUserDataManager sharedManager] getButtonDataForTag:21].displayNumberColor;
                if (matchColor){
                    [temp appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:matchColor}]];
                }
            }else{
                matchColor = [[CCUserDataManager sharedManager] getButtonDataForTag:12].displayNumberColor;
                [temp appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:matchColor}]];
            }
            
        }else{
            
            NSData *colorData = [self.numberColorDictionary objectForKey:@(string.intValue)];
            matchColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
            if (matchColor){
                [temp appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName:matchColor,NSStrokeColorAttributeName:[UIColor blackColor],NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]}]];
            }
        }
    }
    [temp addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:27] range:NSMakeRange(0, numberString.length)];
    self.outputTextView.attributedText = temp;
    self.outputTextView.textAlignment = NSTextAlignmentRight;
    return temp;
}

- (void)formatInputWithCustomColors
{
    if ([self.previousNumberString isEqualToString:@""]){
        return;
    }
    
    self.previousNumber = [self.numberFormatter numberFromString:self.previousNumberString];
    NSInteger ans = self.previousNumber.integerValue;
    NSData *colorData = [self.numberColorDictionary objectForKey:@(ans)];
    
    UIColor *matchColor = [NSKeyedUnarchiver unarchiveObjectWithData:colorData];
    if (colorData!=nil){
        NSError *_error;
        NSRegularExpression *_regexp = [NSRegularExpression regularExpressionWithPattern:self.previousNumberString options:NSRegularExpressionCaseInsensitive error:&_error];
        if (_error == nil) {
            [_regexp enumerateMatchesInString:self.temp.string options:NSMatchingReportProgress range:NSMakeRange(0, self.temp.string.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                if (result.numberOfRanges > 0) {
                    
                    NSMutableAttributedString *temp = [[NSMutableAttributedString alloc] initWithAttributedString:self.temp];
                    [temp addAttribute:NSForegroundColorAttributeName value:matchColor range:[result rangeAtIndex:result.numberOfRanges-1]];
                    
                    NSMutableAttributedString *mergeText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputtemp];
                    [mergeText appendAttributedString:temp];
                    
                    self.attributedText = mergeText;
                }
            }];
        }
    }
    else{
        
        NSMutableAttributedString *mergeText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputtemp];
        [mergeText appendAttributedString:self.temp];
        self.attributedText = nil;
        [self.attributedText appendAttributedString: mergeText];
    }
}

- (NSNumber *)getAnswer
{
    [self formatInputWithCustomColors];
    
    DDMathEvaluator *defaultEvaluator = [DDMathEvaluator defaultMathEvaluator];
    defaultEvaluator.angleMeasurementMode = self.mode == CCCalculatorModeDegree ? DDAngleMeasurementModeDegrees : DDAngleMeasurementModeRadians;
    [defaultEvaluator setUsesHighPrecisionEvaluation:YES];
    NSNumber *answer = [self.equationText numberByEvaluatingString];
    self.equationText = [answer stringValue];
    if (answer){
        self.outputTextView.attributedText = [self formatOutputStringForAnswer:answer];
        self.outputTextView.textAlignment = NSTextAlignmentRight;
        self.tempattributedText = [self formatOutputStringForAnswerforinputtext:answer];
        
        self.inputflag = true;
       
    }else{
        self.outputTextView.text = @"Error";
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please double check your input" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    return answer;
    
    
}

- (IBAction)answerValue:(UIButton *)sender {
    
    if(self.time3flag == false){
        
        self.time3 = CACurrentMediaTime();
        
        CFTimeInterval Time2 = self.time3-self.time2;
        NSString *workingtime = [[NSString alloc]initWithFormat:@"%.2f",Time2];
        CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
        [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Q%dWorkingtime",self.questionNum] value:workingtime];
    }
    
    NSAttributedString *string = [[NSAttributedString alloc]init];
    string = sender.currentAttributedTitle;
    [self.numberTempString appendAttributedString:string];
    [self.numberTempString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:27] range:NSMakeRange(0, self.numberTempString.length)];
    self.answerLabel.attributedText = self.numberTempString;
    self.time3flag = true;
}

- (IBAction)nextButtonPressed:(id)sender {
    
    if(self.practiceflag == true){
        if(self.practice == 0 || self.practice == 1){
            self.conditionLabel.text = @"Congruent";
            if(self.practice == 0){
               self.testQuestions.text = @" 0 + 2 = ";
            }
            if(self.practice == 1){
                self.testQuestions.text = @" 0 + 3 = ";
            }
            self.incongruentcolorflag = false;
            self.congruentcolorflag = true;
            self.blackflag = false;
        }
        if(self.practice == 2 || self.practice == 3 || self.practice == 4){
            self.conditionLabel.text = @"Incongruent";
            switch (self.practice) {
                case 2:
                    self.testQuestions.text = @" 0 + 1 = ";
                    break;
                case 3:
                    self.testQuestions.text = @" 0 + 2 = ";
                    break;
                case 4:
                    self.testQuestions.text = @" 0 + 3 = ";
                    break;
                    
                default:
                    break;
            }
            self.incongruentcolorflag = true;
            self.congruentcolorflag = false;
            self.blackflag = false;
        }
        if(self.practice == 5 || self.practice == 6 || self.practice == 7){
            self.conditionLabel.text = @"Black";
            switch (self.practice) {
                case 5:
                    self.testQuestions.text = @" 0 + 1 = ";
                    break;
                case 6:
                    self.testQuestions.text = @" 0 + 2 = ";
                    break;
                case 7:
                    self.testQuestions.text = @" 0 + 3 = ";
                    break;
                    
                default:
                    break;
            }
            self.incongruentcolorflag = false;
            self.congruentcolorflag = false;
            self.blackflag = true;
        }
        [self conditionSetup];
        self.practice ++;
        if(self.practice>7){
            [self.nextbtn setTitle:@"Finish" forState:UIControlStateNormal];
            CCStartTestViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"startTestVC"];
            [self presentViewController:viewController animated:YES completion:nil];
        }
    }else{
        
        if([self.nextbtn.currentTitle isEqualToString:@"Finish Test"]){
            
            [self finishTest];
            return;
        }
        self.topLabel.text = [NSString stringWithFormat:@"QUESTION-%d",self.questionOrderNumber+1];
        self.conditionLabel.hidden = true;
        self.time4 = CACurrentMediaTime();
        
        self.questionStarttime = self.time4 - self.questionTimewhenfirstloaded;
        NSString *starttime = [[NSString alloc]initWithFormat:@"%.2f",self.questionStarttime];
        
        CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
        [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Q%dStartTime",self.questionNum] value:starttime];
        self.time3flag = false;
        self.time2flag = false;
        self.questionOrderNumber ++;
        
        [self savetestresult];
        
        _numberTempString = [[NSMutableAttributedString alloc]init];
        NSString *string = [[NSString alloc]initWithFormat:@"Q%d",self.questionOrderNumber];
        self.testQuestions.text = [self.testQuestionDic objectForKey:string];
        
        self.time1 = CACurrentMediaTime();
        if(self.questionOrderNumber==30 || self.questionOrderNumber == 60 || self.questionOrderNumber == 90){
            
            [self.nextbtn setTitle:@"Finish Test" forState:UIControlStateNormal];
            
        }
        self.questionNum++;
        
    }
    
    [self clearCalculator];
    
    self.answerLabel.attributedText = nil;
    _numberTempString = [[NSMutableAttributedString alloc]init];
    
}

- (IBAction)delete:(id)sender {
    
    self.answerLabel.text = @"";
    _numberTempString = [[NSMutableAttributedString alloc]init];
}


#pragma mark - unwind segues
- (IBAction)unwindToCalculator:(UIStoryboardSegue *)sender
{
    [self clearCalculator:nil];
}


-(void)clearCalculator{
    
    self.inputTextView.text = @"";
    self.outputTextView.text = @"";
    self.equationText = @"";
    self.previousNumberString = @"";
    self.attributedText = [[NSMutableAttributedString alloc] init];
    self.tempattributedText = [[NSMutableAttributedString alloc]init];
    self.calculatorDisplayTexts = nil;
    self.calculatorEquationTexts = nil;
    self.temp = nil;
}


- (void)finishTest{
    
    self.time4 = CACurrentMediaTime();
    self.time3flag = false;
    self.time2flag = false;
    
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    self.temppageorder = ccAppDelegate.surveycalltimes;
    self.temppageorder++;

    if(self.temppageorder == 1 || self.temppageorder == 2){
        
        self.finishtestflag = true;
    }
    ccAppDelegate.surveycalltimes = self.temppageorder;
    
    [self savetestresult];
    
    if(self.finishtestflag == true){
        
        CCRestViewController *viewController  = [self.storyboard instantiateViewControllerWithIdentifier:@"restVC"];
        viewController.pageorder = _temppageorder;
        [self presentViewController:viewController animated:YES completion:nil];
    }
    if(self.finishtestflag == false){

        CCFinalViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"finalTestVC"];
        [self presentViewController:viewController animated:YES completion:nil];
    }

}

-(void)savetestresult{
    
    CFTimeInterval Time3 = self.time4-self.time3;
    CFTimeInterval Time4 = self.time4-self.time1;
    
    NSString *Transcribingtime = [[NSString alloc]initWithFormat:@"%.2f",Time3];
    NSString *Wholequestiontime = [[NSString alloc]initWithFormat:@"%.2f",Time4];
    
    CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Q%dTranscribingtime",self.questionNum] value:Transcribingtime];
    [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Q%dWholequestiontime",self.questionNum] value:Wholequestiontime];
    if(self.temppageorder == 3){
    
        ccParticipantsTestResult.flag = true;
    }
    [ccParticipantsTestResult createDictionary:[NSString stringWithFormat:@"Answer%d",self.questionNum] value:self.answerLabel.text];
    
}


-(UIColor *)getcolorfromstring:(int )num{
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *colorAsString = [ccAppDelegate.participantTestInfo objectForKey:[NSString stringWithFormat:@"number%d",num+1]];
 
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    
    CGFloat r = [[components objectAtIndex:0] floatValue]/255;
    
    CGFloat g = [[components objectAtIndex:1] floatValue]/255;

    CGFloat b = [[components objectAtIndex:2] floatValue]/255;

    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    return color;
}

-(UIColor *)complementarycolorfromstring:(int )num{
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *colorAsString = [ccAppDelegate.participantTestInfo objectForKey:[NSString stringWithFormat:@"numberComplmentaryColor%d",num+1]];
    
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    
    CGFloat r = [[components objectAtIndex:0] floatValue]/255;
    
    CGFloat g = [[components objectAtIndex:1] floatValue]/255;
    
    CGFloat b = [[components objectAtIndex:2] floatValue]/255;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
    
    return color;
}

-(NSString *)getnumberString:(int )num{
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    NSString *numberString = [ccAppDelegate.participantTestInfo objectForKey:[NSString stringWithFormat:@"numbercolor%d",num+1]];
    return numberString;
}

-(NSAttributedString *)str:(UIColor *)color String:(NSString *)string{
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName : color,
                                       NSStrokeColorAttributeName : [UIColor blackColor],
                                       NSStrokeWidthAttributeName : [NSNumber numberWithFloat:-2.0]
                                       };
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:string attributes:buttonAttributes];
    return str;
}

-(NSAttributedString *)symbolStr:(UIColor *)color String:(NSString *)string{
    NSDictionary *buttonAttributes = @{
                                       NSForegroundColorAttributeName : color
                                       };
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:string attributes:buttonAttributes];
    return str;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    UITextView *tv = object;
    CGFloat topCorrect = 1.0;
    
    tv.contentOffset = (CGPoint){.x = 0, .y = 0};
}

@end
