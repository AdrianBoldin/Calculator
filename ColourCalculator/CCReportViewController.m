//
//  CCReportViewController.m
//  ColourCalculator
//
//  Created by Adrian on 4/8/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCReportViewController.h"
#import "CCParticipantsTestResult.h"
#import "CCTestResultViewController.h"

@interface CCReportViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allParticipantName;
@property (strong, nonatomic) CCParticipantsTestResult *ccParticipantsTestResult;
@end

@implementation CCReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.scrollview.contentSize = self.contentview.bounds.size;
    
    self.participantTestInfo = [[NSDictionary alloc]init];
    
    self.ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    
    [self initwithUserNames];
    

}

-(void)initwithUserNames{
    
    CGFloat superViewWidth = self.view.frame.size.width;

    
    for(int i = 0;i<12;i++){
        
        for(int j = 0; j<3; j++){
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((j+1)*(superViewWidth-600)/4 + j*200, i*75 + 40*(i+1), 200, 75)];
            [button setTag:(j + 1)+i*3];
            [button setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:121.0f/255.0f blue:255.0f/255.0f alpha:0.72f]];
            [button setTitle:[[self.ccParticipantsTestResult readingStringFromFile:button.tag] objectForKey:@"name"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(showTestResultView:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentview addSubview:button];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.participantTestInfo = [[NSDictionary alloc]init];
    
    self.ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
    for(UIButton *buttton in self.allParticipantName){
        
        [buttton setTitle:[[self.ccParticipantsTestResult readingStringFromFile:buttton.tag] objectForKey:@"name"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)showTestResultView:(UIButton *)sender {
    
    CCTestResultViewController *ccTestResultViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ccTestResultView"];
    
    ccTestResultViewController.participantTestInfo = [self.ccParticipantsTestResult readingStringFromFile:sender.tag];
    ccTestResultViewController.particpantNumber = sender.tag;
    
    NSLog(@"jghgj%@",ccTestResultViewController.participantTestInfo);
    
    [self.navigationController pushViewController:ccTestResultViewController animated:YES];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
