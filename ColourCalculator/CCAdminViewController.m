//
//  CCAdminViewController.m
//  ColourCalculator
//
//  Created by Adrian on 4/8/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCAdminViewController.h"
#import "CCReportViewController.h"
#import "CCReporNViewController.h"
#import "CCAppDelegate.h"
@interface CCAdminViewController ()

@end

@implementation CCAdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController]setNavigationBarHidden:YES];
    [self setNeedsStatusBarAppearanceUpdate];
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    ccAppDelegate.surveycalltimes = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goReportPage:(id)sender {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Password" message:@"Enter Password" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textfield){
        textfield.placeholder = NSLocalizedString(@"Password", @"PasswordPlaceholder");
        textfield.secureTextEntry = YES;
        
    }];
    
    UIAlertAction * gobutton = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        
        UITextField *password = alert.textFields.firstObject;
        
        if([password.text isEqualToString:@"joshua"]){
            
            CCReporNViewController * ccReportNViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"reportNVC"];
            [self presentViewController:ccReportNViewController animated:YES completion:nil];
        }else{
            
            [self presentViewController:alert animated:YES completion:nil];
            alert.title = @"Wrong Password!";
            alert.message = @"Input valid password!";
        }
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * cancelaAction){
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:gobutton];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
