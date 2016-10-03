//
//  CCTestResultViewController.h
//  ColourCalculator
//
//  Created by Adrian on 4/9/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CCUserDataManager.h"

@interface CCTestResultViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate> 
@property (weak, nonatomic) IBOutlet UILabel *testOrderLabel;

@property (weak, nonatomic) IBOutlet UILabel *participantName;
@property (weak, nonatomic) IBOutlet UILabel *blockOrder;
@property (weak, nonatomic) IBOutlet UITableView *colorValueTableview;
@property (weak, nonatomic) IBOutlet UITableView *testResultTableView;
@property (weak, nonatomic) IBOutlet UITableView *emotionTest1TableView;
@property (strong, nonatomic) NSString *testResult;

@property (nonatomic, retain)NSMutableArray *colorValueTableData;
@property (nonatomic, retain)NSMutableArray *buttonString;
@property (nonatomic,retain)NSMutableArray *customNumberString;
@property (nonatomic, retain)NSMutableArray *numberColors;
@property (strong, nonatomic)NSMutableArray *testResutlTableData;
@property (nonatomic,retain)NSMutableArray *testanswer;
@property (nonatomic,retain)NSMutableArray *testanswerresult;
@property (nonatomic,retain)NSMutableArray *startTimeArray;
@property (nonatomic, retain)NSMutableArray *time1Array;
@property (nonatomic, retain)NSMutableArray *time2Array;
@property (nonatomic, retain)NSMutableArray *time3Array;
@property (nonatomic, retain)NSMutableArray *time4Array;
@property (nonatomic, retain)NSMutableArray *complementaryColorData;
@property (nonatomic, retain)NSMutableArray *complementaryNumberColorData;
@property (nonatomic, retain)NSMutableArray *surverytabledata;
@property (nonatomic, retain)NSMutableArray *surveryResulttabledata;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionJoy;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionAnger;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionContempt;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionFear;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionDisgust;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionSadness;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionSuprise;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionEngagement;
@property (nonatomic, retain)NSMutableArray *test1FaceEmotionValence;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionJoy;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionAnger;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionContempt;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionFear;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionDisgust;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionSadness;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionSuprise;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionEngagement;
@property (nonatomic, retain)NSMutableArray *test2FaceEmotionValence;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionJoy;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionAnger;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionContempt;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionFear;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionDisgust;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionSadness;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionSuprise;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionEngagement;
@property (nonatomic, retain)NSMutableArray *test3FaceEmotionValence;
@property (nonatomic,retain) NSMutableArray *test1TimeFrame;
@property (nonatomic,retain) NSMutableArray *test2TimeFrame;
@property (nonatomic,retain) NSMutableArray *test3TimeFrame;
@property (nonatomic, retain) NSMutableArray *numberOfmeasurements;
@property (nonatomic, retain) NSMutableArray *order;

@property(strong, nonatomic)NSDictionary *participantTestInfo;
@property (strong, nonatomic)NSDictionary * testQuestionDic;
@property (strong, nonatomic) NSArray *numberDataArray;
@property (nonatomic)NSInteger particpantNumber;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) Boolean presentFlag;
@end
