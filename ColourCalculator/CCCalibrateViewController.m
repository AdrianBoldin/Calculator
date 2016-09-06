//
//  CCCalibrateViewController.m
//  ColourCalculator
//
//  Created by Adrian on 4/5/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCCalibrateViewController.h"
#import "CCColorPickerViewController.h"
#import "CCParticipantsTestResult.h"
#import "CCAppDelegate.h"
#import "CCHandSetViewController.h"
#import "CCUserDataManager.h"
@interface CCCalibrateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nametxt;
@property (strong, nonatomic) NSArray *buttonDataArray;
@property (strong, nonatomic) NSArray *numberDataArray;
@end

@implementation CCCalibrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CCUserDataManager sharedManager]removeDisplayData];
    [[CCUserDataManager sharedManager]resetData];
    
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.i = [defaults integerForKey:@"participantNumber"];

    self.buttonDataArray = [[CCUserDataManager sharedManager] standardButtonData];
    
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    self.tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:self.tapRecognizer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sowColorpickerView:(id)sender {
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    ccAppDelegate.participantTestInfo = [[NSMutableDictionary alloc]init];
    if(self.i<36){
        
        CCParticipantsTestResult *ccParticipantsTestResult = [[CCParticipantsTestResult alloc]init];
        ccParticipantsTestResult.flag = false;
        [ccParticipantsTestResult createDictionary:@"name" value:self.nametxt.text];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:self.i+1 forKey:@"participantNumber"];
        [defaults synchronize];
    }else {
        
        self.i = 0;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:self.i forKey:@"participantNumber"];
        [defaults synchronize];

    }
    
    CCHandSetViewController *ViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"handSetView"];
    
    [self presentViewController:ViewController animated:YES completion:nil];
}

- (void)didTapAnywhere:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
