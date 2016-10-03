//
//  CCTestResultViewController.m
//  ColourCalculator
//
//  Created by Adrian on 4/9/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCTestResultViewController.h"
#import "CCColorValueTableViewCell.h"
#import "CCTestResultTableViewCell.h"
#import "CCParticipantsTestResult.h"
#import "CCEmotion_Test1Cell.h"

@interface CCTestResultViewController ()

@property (nonatomic) int cumstomNumbers;
@end

@implementation CCTestResultViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self initialize];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height * 2);
    self.scrollView.contentSize = self.contentView.bounds.size;
    self.participantName.text = [self.participantTestInfo objectForKey:@"name"];
    self.buttonString = [[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"AC",@"+",@"-",@"x",@"÷",@".",@"%",@"=",@"(",@")", nil];
    self.numberColors = [[NSMutableArray alloc]init];
    self.customNumberString = [[NSMutableArray alloc]init];
    self.testResutlTableData = [[NSMutableArray alloc]init];
    self.testanswer = [[NSMutableArray alloc]init];
    self.startTimeArray = [[NSMutableArray alloc]init];
    self.time1Array = [[NSMutableArray alloc]init];
    self.time2Array = [[NSMutableArray alloc]init];
    self.time3Array = [[NSMutableArray alloc]init];
    self.time4Array = [[NSMutableArray alloc]init];
    self.testQuestionDic = [[NSDictionary alloc]init];
    self.testanswerresult = [[NSMutableArray alloc]init];
    self.test1FaceEmotionJoy = [[NSMutableArray alloc]init];
    self.test1FaceEmotionContempt = [[NSMutableArray alloc]init];
    self.test1FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test1FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test1FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test1FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test1FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test1FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test1FaceEmotionEngagement = [[NSMutableArray alloc]init];
    
    self.test2FaceEmotionJoy = [[NSMutableArray alloc]init];
    self.test2FaceEmotionContempt = [[NSMutableArray alloc]init];
    self.test2FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test2FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test2FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test2FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test2FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test2FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test2FaceEmotionEngagement = [[NSMutableArray alloc]init];
    
    self.test3FaceEmotionJoy = [[NSMutableArray alloc]init];
    self.test3FaceEmotionContempt = [[NSMutableArray alloc]init];
    self.test3FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test3FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test3FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test3FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test3FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test3FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test3FaceEmotionEngagement = [[NSMutableArray alloc]init];
    
    self.test1TimeFrame = [[NSMutableArray alloc]init];
    self.test2TimeFrame = [[NSMutableArray alloc]init];
    self.test3TimeFrame = [[NSMutableArray alloc]init];
    
    self.numberOfmeasurements = [[NSMutableArray alloc]init];
    
    self.cumstomNumbers = 0;
    
    self.testResult = [NSString stringWithFormat:@"%@",self.participantTestInfo];

    [self initialize];
    
    NSMutableString *csv = [NSMutableString stringWithString:@"Symbols,RGB-Calibrated(Red),RGB-Calibrated(Green),RGB-Calibrated(Blue),RGB-Complementary(Red),RGB-Complementary(Green),RGB-Complementary(Blue)"];
    
    NSUInteger count = [self.buttonString count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count; i++ ) {
        [csv appendFormat:@"\n\%@,\%@,\%@,",
         [self. buttonString objectAtIndex:i],
         [self.colorValueTableData objectAtIndex:i],
         [self.complementaryColorData objectAtIndex:i]
         ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }
    
    NSMutableString *csv1 = [NSMutableString stringWithFormat:@"Question Number,Participant Answer,Correct Answer,Start Time(s),Reading Time(s),Transcribing Time(s),Working Time(s),Whole Question Time(s)"];
    
    NSUInteger count1 = [self.testResutlTableData count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count1; i++ ) {
        [csv1 appendFormat:@"\n\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@",
         [self. testResutlTableData objectAtIndex:i],
         [self.testanswerresult objectAtIndex:i],
         [self.testanswer objectAtIndex:i],
         [self.startTimeArray objectAtIndex:i],
         [self.time1Array objectAtIndex:i],
         [self.time2Array objectAtIndex:i],
         [self.time3Array objectAtIndex:i],
         [self.time4Array objectAtIndex:i]
         ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }

    NSMutableString *csv2 = [NSMutableString stringWithString:@"Measurement Number,Time,Anger Score,Contempt Score, Disgust Score, Engagement Score,Fear Score,Joy Score,Sadness Score,Suprise Score,Valence Score"];
    
    NSUInteger count2 = [self.test1TimeFrame count];
    // provided all arrays are of the same length
    for (NSUInteger i=0; i<count2; i++ ) {
        [csv2 appendFormat:@"\n\%d,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@",
         i,
         [self.test1TimeFrame objectAtIndex:i],
         [self.test1FaceEmotionAnger objectAtIndex:i],
         [self.test1FaceEmotionContempt objectAtIndex:i],
         [self.test1FaceEmotionDisgust objectAtIndex:i],
         [self.test1FaceEmotionFear objectAtIndex:i],
         [self.test1FaceEmotionJoy objectAtIndex:i],
         [self.test1FaceEmotionSadness objectAtIndex:i],
         [self.test1FaceEmotionSuprise objectAtIndex:i],
         [self.test1FaceEmotionEngagement objectAtIndex:i],
         [self.test1FaceEmotionValence objectAtIndex:i]
         ];
    }
        NSMutableString *csv3 = [NSMutableString stringWithString:@"Measurement Number,Time,Anger Score,Contempt Score, Disgust Score, Engagement Score,Fear Score,Joy Score,Sadness Score,Suprise Score,Valence Score"];
        
        NSUInteger count3 = [self.test2TimeFrame count];
        // provided all arrays are of the same length
        for (NSUInteger i=0; i<count3; i++ ) {
            [csv3 appendFormat:@"\n\%d,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@",
             i,
             [self.test2TimeFrame objectAtIndex:i],
             [self.test2FaceEmotionAnger objectAtIndex:i],
             [self.test2FaceEmotionContempt objectAtIndex:i],
             [self.test2FaceEmotionDisgust objectAtIndex:i],
             [self.test2FaceEmotionFear objectAtIndex:i],
             [self.test2FaceEmotionJoy objectAtIndex:i],
             [self.test2FaceEmotionSadness objectAtIndex:i],
             [self.test2FaceEmotionSuprise objectAtIndex:i],
             [self.test2FaceEmotionEngagement objectAtIndex:i],
             [self.test2FaceEmotionValence objectAtIndex:i]
             ];
        }
            NSMutableString *csv4 = [NSMutableString stringWithString:@"Measurement Number,Time,Anger Score,Contempt Score, Disgust Score, Engagement Score,Fear Score,Joy Score,Sadness Score,Suprise Score,Valence Score"];
            
            NSUInteger count4 = [self.test3TimeFrame count];
            // provided all arrays are of the same length
            for (NSUInteger i=0; i<count4; i++ ) {
                [csv4 appendFormat:@"\n\%d,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@,\%@",
                 i,
                 [self.test3TimeFrame objectAtIndex:i],
                 [self.test3FaceEmotionAnger objectAtIndex:i],
                 [self.test3FaceEmotionContempt objectAtIndex:i],
                 [self.test3FaceEmotionDisgust objectAtIndex:i],
                 [self.test3FaceEmotionFear objectAtIndex:i],
                 [self.test3FaceEmotionJoy objectAtIndex:i],
                 [self.test3FaceEmotionSadness objectAtIndex:i],
                 [self.test3FaceEmotionSuprise objectAtIndex:i],
                 [self.test3FaceEmotionEngagement objectAtIndex:i],
                 [self.test3FaceEmotionValence objectAtIndex:i]
                 ];
        // instead of integerValue may be used intValue or other, it depends how array was created
    }
    
    self.testResult = [NSString stringWithFormat:@"Participant Code,\"\",\"\",\"\",Original Metrics,Block Order,%@,\%@,\%@,\%@\n\%@\n\n\Colour Data\n\n\%@\n\n\%@\n\n\Test1 Emotion Metrics,\"\",Condition:,%@\n\n\%@\n\n\Test2 Emotion Metrics,\"\",Condition:,%@\n\n\%@\n\n\Test3 Emotion Metrics,\"\",Condition:,%@\n\n\%@",self.testOrderLabel.text,[self.order objectAtIndex:0],[self.order objectAtIndex:1],[self.order objectAtIndex:2],self.participantName.text, csv,csv1,[self.order objectAtIndex:0],csv2,[self.order objectAtIndex:1],csv3,[self.order objectAtIndex:2],csv4];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)initialize{
    
    
    CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    self.participantName.text = [self.participantTestInfo objectForKey:@"name"];
    self.testOrderLabel.text = [self.participantTestInfo objectForKey:@"Block Order"];
    int n = [self.testOrderLabel.text intValue];
    switch (n) {
        case 0:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Congruent",@"Incongruent",@"Black", nil];
            NSLog(@"%@",self.order);
            break;
        case 1:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Congruent",@"Black",@"Incongruent", nil];
            break;
        case 2:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Incongruent",@"Congruent",@"Black", nil];
            break;
        case 3:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Incongruent",@"Blakc",@"Congruent", nil];
            break;
        case 4:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Black",@"Congruent",@"Incongruent", nil];
            break;
        case 5:
            self.order = [[NSMutableArray alloc]initWithObjects:@"Black",@"Incongruent",@"Congruent", nil];
            break;
        
        default:
            break;
    }
    self.testQuestionDic = [ccParticipantsTestResult readingStringFromQuestionFile];
    for(int i=1;i<91;i++){
        
        [self.testResutlTableData addObject:[NSString stringWithFormat:@"Q%d",i]];
        [self.testanswer addObject:[NSString stringWithFormat:@"%@",[self.testQuestionDic objectForKey:[NSString stringWithFormat:@"Answer%d",i]]]];
        [self.testanswerresult addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Answer%d",i]]]];
        
        [self.startTimeArray addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Q%dStartTime",i]]]];
        [self.time1Array addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Q%dReadingtime",i]]]];
        [self.time2Array addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Q%dWorkingtime",i]]]];
        [self.time3Array addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Q%dTranscribingtime",i]]]];
        [self.time4Array addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Q%dWholequestiontime",i]]]];
    }
    
    NSString *string0 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"0"]];
    NSString *string1 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"1"]];
    NSString *string2 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"2"]];
    NSString *string3 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"3"]];
    NSString *string4 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"4"]];
    NSString *string5 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"5"]];
    NSString *string6 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"6"]];
    NSString *string7 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"7"]];
    NSString *string8 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"8"]];
    NSString *string9 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"9"]];
    NSString *stringPlus = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"+"]];
    NSString *stringMinus = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"-"]];
    NSString *stringMultiple = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"x"]];
    NSString *stringDevide = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"/"]];
    NSString *stringDot = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"."]];
    NSString *stringPercent = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"%"]];
    NSString *stringEqual = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"="]];
    NSString *stringAC = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"AC"]];
    NSString *stringInvoke1 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"("]];
    NSString *stringInvoke2 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@")"]];
    self.colorValueTableData = [[NSMutableArray alloc]initWithObjects:string0,string1,string2,string3,string4,string5,string6,string7,string8,string9,stringPlus,stringMinus,stringMultiple,stringDevide,stringDot,stringPercent,stringEqual,stringAC, stringInvoke1,stringInvoke2,nil];
    
    
    NSString *complementarystring0 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 0"]];
    NSString *complementarystring1 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 1"]];
    NSString *complementarystring2 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 2"]];
    NSString *complementarystring3 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 3"]];
    NSString *complementarystring4 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 4"]];
    NSString *complementarystring5 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 5"]];
    NSString *complementarystring6 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 6"]];
    NSString *complementarystring7 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 7"]];
    NSString *complementarystring8 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 8"]];
    NSString *scomplementarystring9 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor 9"]];
    NSString *complementarystringPlus = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor +"]];
    NSString *complementarystringMinus = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor -"]];
    NSString *scomplementarystringMultiple = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"x"]];
    NSString *complementarystringDevide = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor /"]];
    NSString *complementarystringDot = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor ."]];
    NSString *complementarystringPercent = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor %"]];
    NSString *complementarystringEqual = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor ="]];
    NSString *complementarystringAC = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor AC"]];
    NSString *complementarystringInvoke1 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor ("]];
    NSString *complementarystringInvoke2 = [[NSString alloc]initWithFormat:@"%@",[self.participantTestInfo objectForKey:@"complementaryColor )"]];
    
     self.complementaryColorData = [[NSMutableArray alloc]initWithObjects:complementarystring0,complementarystring1,complementarystring2,complementarystring3,complementarystring4,complementarystring5,complementarystring6,complementarystring7,complementarystring8,scomplementarystring9,complementarystringPlus,complementarystringMinus,scomplementarystringMultiple,complementarystringDevide,complementarystringDot,complementarystringPercent,complementarystringEqual,complementarystringAC, complementarystringInvoke1,complementarystringInvoke2,nil];
    
    NSArray * array1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"faceResult0"];
    for(int i=0;i<array1.count;i+=10){
        
        [self.test1TimeFrame addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i]]];
        [self.test1FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+1]]];
        [self.test1FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+2]]];
        [self.test1FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+3]]];
        [self.test1FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+4]]];
        [self.test1FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+5]]];
        [self.test1FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+6]]];
        [self.test1FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+7]]];
        [self.test1FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+8]]];
        [self.test1FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+9]]];
    }
    
    NSArray * array2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"faceResult1"];
    for(int i=0;i<array2.count;i+=10){
        
        [self.test2TimeFrame addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i]]];
        [self.test2FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+1]]];
        [self.test2FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+2]]];
        [self.test2FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+3]]];
        [self.test2FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+4]]];
        [self.test2FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+5]]];
        [self.test2FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+6]]];
        [self.test2FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+7]]];
        [self.test2FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+8]]];
        [self.test2FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[array2 objectAtIndex:i+9]]];
    }
    
    NSArray * array3 = [[NSUserDefaults standardUserDefaults]objectForKey:@"faceResult2"];
    for(int i=0;i<array3.count;i+=10){
        
        [self.test3TimeFrame addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i]]];
        [self.test3FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+1]]];
        [self.test3FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+2]]];
        [self.test3FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+3]]];
        [self.test3FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+4]]];
        [self.test3FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+5]]];
        [self.test3FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+6]]];
        [self.test3FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+7]]];
        [self.test3FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[array1 objectAtIndex:i+8]]];
        [self.test3FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[array3 objectAtIndex:i+9]]];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.colorValueTableview)
    {
        return 1;
    }
    else if(tableView == self.testResultTableView){
        
        return 1;
    }
    else{
        
        return 3;
      }
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(tableView == self.colorValueTableview){
        
        return NULL;
    }else if(tableView == self.testResultTableView){
        
        
        return NULL;
    }else{
        if(section == 0){
            return @"Emotion Recognition Metrics - Test1";
        }else if(section == 1){
            return @"Emotion Recognition Metrics - Test2";
        }else{
            return @"Emotion Recognition Metrics - Test3";
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(tableView == self.colorValueTableview){
        
        return self.buttonString.count;
        
    }else if(tableView == self.testResultTableView){
        
        return self.testResutlTableData.count;
    }else{
        
        if (section == 0){
            return self.test1TimeFrame.count;
        }else if (section == 1){
            return self.test2TimeFrame.count;
        }else{
            return self.test3TimeFrame.count;
        }
            
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == self.colorValueTableview){
    
        static NSString *simpletableIdentifier = @"colortableviewcel";
        
        CCColorValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpletableIdentifier forIndexPath:indexPath];
        cell.buttonString.text = [self.buttonString objectAtIndex:indexPath.row];
        cell.colorValue.text = [self.colorValueTableData objectAtIndex:indexPath.row];
        cell.complementary_colour.text = [self.complementaryColorData objectAtIndex:indexPath.row];
        return  cell;
   
    }else if(tableView == self.testResultTableView){
        
        static NSString *tableindentifier = @"testresultcell";
         CCTestResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableindentifier forIndexPath:indexPath];
        cell.questionLabel.text = [self.testResutlTableData objectAtIndex:indexPath.row];
        
        if(self.startTimeArray.count>0){
            if(indexPath.row == 0 || indexPath.row == 30 || indexPath.row == 60){
                cell.startTime.text = @"0.00";
            }else{
                cell.startTime.text = [self.startTimeArray objectAtIndex:indexPath.row - 1];
            }
            
        }
        
        if(self.time1Array.count>0){
            cell.time1.text = [self.time1Array objectAtIndex:indexPath.row];
        }
        if(self.time2Array.count>0){
            cell.time2.text = [self.time2Array objectAtIndex:indexPath.row];
        }
        if(self.time3Array.count>0){
            cell.time3.text = [self.time3Array objectAtIndex:indexPath.row];
        }
        if(self.time4Array){
            cell.time4
            .text = [self.time4Array objectAtIndex:indexPath.row];
        }
            cell.answerLabel.text = [self.testanswerresult objectAtIndex:indexPath.row];
        
        
        return cell;
    }else {
        
        static NSString *emotiontableindentifier = @"emotionCell1";
        CCEmotion_Test1Cell *cell = [tableView dequeueReusableCellWithIdentifier:emotiontableindentifier forIndexPath:indexPath];

        if(self.test1FaceEmotionJoy.count>0){
            switch (indexPath.section) {
                case 0:
                {
                    cell.joy.text = [self.test1FaceEmotionJoy objectAtIndex:indexPath.row];
                    cell.anger.text = [self.test1FaceEmotionAnger objectAtIndex:indexPath.row];
                    cell.contempt.text = [self.test1FaceEmotionContempt objectAtIndex:indexPath.row];
                    NSLog(@"cccccc%@",self.test1FaceEmotionContempt);
                    cell.fear.text = [self.test1FaceEmotionFear objectAtIndex:indexPath.row];
                    cell.disgust.text = [self.test1FaceEmotionDisgust objectAtIndex:indexPath.row];
                    cell.sandess.text = [self.test1FaceEmotionSadness objectAtIndex:indexPath.row];
                    cell.engagement.text = [self.test1FaceEmotionEngagement objectAtIndex:indexPath.row];
                    cell.suprise.text = [self.test1FaceEmotionSuprise objectAtIndex:indexPath.row];
                    cell.valence.text = [self.test1FaceEmotionValence objectAtIndex:indexPath.row];
                    cell.times.text = [self.test1TimeFrame objectAtIndex:indexPath.row];
                    cell.measurement.text = [NSString stringWithFormat:@"%d",indexPath.row];
                }
                    break;
                case 1:
                {
                    cell.joy.text = [self.test2FaceEmotionJoy objectAtIndex:indexPath.row];
                    cell.anger.text = [self.test2FaceEmotionAnger objectAtIndex:indexPath.row];
                    cell.contempt.text = [self.test2FaceEmotionContempt objectAtIndex:indexPath.row];
                    cell.fear.text = [self.test2FaceEmotionFear objectAtIndex:indexPath.row];
                    cell.disgust.text = [self.test2FaceEmotionDisgust objectAtIndex:indexPath.row];
                    cell.sandess.text = [self.test2FaceEmotionSadness objectAtIndex:indexPath.row];
                    cell.engagement.text = [self.test2FaceEmotionEngagement objectAtIndex:indexPath.row];
                    cell.suprise.text = [self.test2FaceEmotionSuprise objectAtIndex:indexPath.row];
                    cell.valence.text = [self.test2FaceEmotionValence objectAtIndex:indexPath.row];
                    cell.times.text = [self.test2TimeFrame objectAtIndex:indexPath.row];
                    cell.measurement.text = [NSString stringWithFormat:@"%d",indexPath.row];
                }
                    break;
                case 2:
                {
                    cell.joy.text = [self.test3FaceEmotionJoy objectAtIndex:indexPath.row];
                    cell.anger.text = [self.test3FaceEmotionAnger objectAtIndex:indexPath.row];
                    cell.contempt.text = [self.test3FaceEmotionContempt objectAtIndex:indexPath.row];
                    cell.fear.text = [self.test3FaceEmotionFear objectAtIndex:indexPath.row];
                    cell.disgust.text = [self.test3FaceEmotionDisgust objectAtIndex:indexPath.row];
                    cell.sandess.text = [self.test3FaceEmotionSadness objectAtIndex:indexPath.row];
                    cell.engagement.text = [self.test3FaceEmotionEngagement objectAtIndex:indexPath.row];
                    cell.suprise.text = [self.test3FaceEmotionSuprise objectAtIndex:indexPath.row];
                    cell.valence.text = [self.test3FaceEmotionValence objectAtIndex:indexPath.row];
                    cell.times.text = [self.test3TimeFrame objectAtIndex:indexPath.row];
                    cell.measurement.text = [NSString stringWithFormat:@"%d",indexPath.row];
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        return  cell;
    }
}

- (IBAction)sendemail:(id)sender {
    
    

    [self sendEmail:self.testResult];
}

-(void)sendEmail:(NSString*)string{
    // Email Subject
    NSString *emailTitle = @"Test Result";
    // Email Content
    
    NSString *messageBody = @"Here is a Test Result";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"adrin-boldin@outlook.com"];
    NSData *data = [self.testResult dataUsingEncoding:NSUTF8StringEncoding];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc addAttachmentData:data mimeType:@"text/plain" fileName:@"Data.txt"];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}




- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    
    
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:NO completion:NULL];
    
}


- (IBAction)deleteReport:(id)sender {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warining!" message:@"Are you sure you want to delete it?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * gobutton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
        [ccParticipantsTestResult removeFile:self.particpantNumber];
        [ccParticipantsTestResult resort];
        
        [self.navigationController popViewControllerAnimated:YES];

    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * cancelaAction){
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:gobutton];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    }

//-(void)createCSV{
//    
//    CHCSVWriter *writer
//}

@end
