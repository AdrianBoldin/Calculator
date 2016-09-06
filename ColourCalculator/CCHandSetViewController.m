//
//  CCHandSetViewController.m
//  ColourCalculator
//
//  Created by Adrian on 7/10/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCHandSetViewController.h"
#import "CCColorPickerViewController.h"
#import "CCAppDelegate.h"
@interface CCHandSetViewController ()

@end

@implementation CCHandSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)gotoColourPickerView:(UIButton *)sender {
    
    CCColorPickerViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"colorpickerview"];
    if(sender.tag == 1){
        
        viewController.handRightFlag = true;
        CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
        ccAppDelegate.handRightFlag = true;
    }
    
    [self presentViewController:viewController animated:YES completion:nil];
    
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
