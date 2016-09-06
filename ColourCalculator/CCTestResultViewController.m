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
    self.test1FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test1FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test1FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test1FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test1FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test1FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test1FaceEmotionEngagement = [[NSMutableArray alloc]init];
    
    self.test2FaceEmotionJoy = [[NSMutableArray alloc]init];
    self.test2FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test2FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test2FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test2FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test2FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test2FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test2FaceEmotionEngagement = [[NSMutableArray alloc]init];
    
    self.test3FaceEmotionJoy = [[NSMutableArray alloc]init];
    self.test3FaceEmotionAnger = [[NSMutableArray alloc]init];
    self.test3FaceEmotionFear = [[NSMutableArray alloc]init];
    self.test3FaceEmotionDisgust = [[NSMutableArray alloc]init];
    self.test3FaceEmotionSadness = [[NSMutableArray alloc]init];
    self.test3FaceEmotionSuprise = [[NSMutableArray alloc]init];
    self.test3FaceEmotionValence = [[NSMutableArray alloc]init];
    self.test3FaceEmotionEngagement = [[NSMutableArray alloc]init];
    self.timeFrame = [[NSMutableArray alloc]init];
    self.cumstomNumbers = 0;
    
    self.testResult = [NSString stringWithFormat:@"%@",self.participantTestInfo];

    [self initialize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)initialize{
    
    
    CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    self.participantName.text = [self.participantTestInfo objectForKey:@"name"];
    self.testOrderLabel.text = [self.participantTestInfo objectForKey:@"Block Order"];
    self.testQuestionDic = [ccParticipantsTestResult readingStringFromQuestionFile];
    for(int i=1;i<91;i++){
        
        [self.testResutlTableData addObject:[NSString stringWithFormat:@"Q%d",i]];
        //[self.testanswer addObject:[NSString stringWithFormat:@"%@",[self.testQuestionDic objectForKey:[NSString stringWithFormat:@"Answer%d",i]]]];
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
    
    
    for(int i=0; i<600; i++){
        NSString *stringAnger1 = [NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionAnger%d",i]]];
        if(stringAnger1!=nil){
            [self.test1FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionAnger%d",i]]]];
        }
       
        [self.test1FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionContempt%d",i]]]];
        [self.test1FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionDisgust%d",i]]]];
        [self.test1FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionFear%d",i]]]];
        [self.test1FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionJoy%d",i]]]];
        [self.test1FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionSadness%d",i]]]];
        [self.test1FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionSuprise%d",i]]]];
        [self.test1FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionEngagement%d",i]]]];
        [self.test1FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test1EmotionValence%d",i]]]];
        [self.timeFrame addObject:[NSString stringWithFormat:@"%.1f",0.2 * (i +1)]];
        
        [self.test2FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionAnger%d",i]]]];
        [self.test2FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionContempt%d",i]]]];
        [self.test2FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionDisgust%d",i]]]];
        [self.test2FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionFear%d",i]]]];
        [self.test2FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionJoy%d",i]]]];
        [self.test2FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionSadness%d",i]]]];
        [self.test2FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionSuprise%d",i]]]];
        [self.test2FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionEngagement%d",i]]]];
        [self.test2FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test2EmotionValence%d",i]]]];
        
        [self.test3FaceEmotionAnger addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionAnger%d",i]]]];
        [self.test3FaceEmotionContempt addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionContempt%d",i]]]];
        [self.test3FaceEmotionDisgust addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionDisgust%d",i]]]];
        [self.test3FaceEmotionFear addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionFear%d",i]]]];
        [self.test3FaceEmotionJoy addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionJoy%d",i]]]];
        [self.test3FaceEmotionSadness addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionSadness%d",i]]]];
        [self.test3FaceEmotionSuprise addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionSuprise%d",i]]]];
        [self.test3FaceEmotionEngagement addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionEngagement%d",i]]]];
        [self.test3FaceEmotionValence addObject:[NSString stringWithFormat:@"%@",[self.participantTestInfo objectForKey:[NSString stringWithFormat:@"Test3EmotionValence%d",i]]]];
        
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
        
        return self.timeFrame.count;
        
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
                    cell.fear.text = [self.test1FaceEmotionFear objectAtIndex:indexPath.row];
                    cell.disgust.text = [self.test1FaceEmotionDisgust objectAtIndex:indexPath.row];
                    cell.sandess.text = [self.test1FaceEmotionSadness objectAtIndex:indexPath.row];
                    cell.engagement.text = [self.test1FaceEmotionEngagement objectAtIndex:indexPath.row];
                    cell.suprise.text = [self.test1FaceEmotionSuprise objectAtIndex:indexPath.row];
                    cell.valence.text = [self.test1FaceEmotionValence objectAtIndex:indexPath.row];
                    cell.times.text = [self.timeFrame objectAtIndex:indexPath.row];
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
                    cell.times.text = [self.timeFrame objectAtIndex:indexPath.row];
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
                    cell.times.text = [self.timeFrame objectAtIndex:indexPath.row];
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
    
    NSString *messageBody = string;
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"joshua.1.berger@gmail.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
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

@end
