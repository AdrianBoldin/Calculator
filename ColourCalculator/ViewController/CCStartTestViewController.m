//
//  CCStartTestViewController.m
//  ColourCalculator
//
//  Created by Adrian on 7/12/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCStartTestViewController.h"
#import "CCCalculatorViewController.h"
#import "CCAppDelegate.h"

@interface CCStartTestViewController ()

@end

@implementation CCStartTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    int index = ccAppDelegate.testordernumber;
    CCCalculatorViewController * controller= [self.storyboard instantiateViewControllerWithIdentifier:@"calculatorView"];
        
        controller.temppageorder = 0;
        
        if(index == 0 || index == 1){
            
            controller.congruentcolorflag = true;
            controller.incongruentcolorflag = false;
            controller.blackflag = false;
            
        }
        
        if(index == 2 || index == 3){
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = true;
            controller.blackflag = false;
            
        }
        
        if(index == 4 || index == 5) {
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = false;
            controller.blackflag = true;
        }
    
    [self presentViewController:controller animated:YES completion:nil];
    

}

@end
