//
//  CCRestViewController.m
//  ColourCalculator
//
//  Created by Adrian on 7/12/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCRestViewController.h"
#import "CCCalculatorViewController.h"
#import "CCAppDelegate.h"
@interface CCRestViewController ()

@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation CCRestViewController

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
    self.calculatorviewIndex = ccAppDelegate.testordernumber;
    CCCalculatorViewController * controller= [self.storyboard instantiateViewControllerWithIdentifier:@"calculatorView"];
    
    if(self.pageorder == 1){
        
        controller.temppageorder = 1;
        
        if(self.calculatorviewIndex == 0 || self.calculatorviewIndex == 5){
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = true;
            controller.blackflag = false;
        
        }
        
        if(self.calculatorviewIndex == 2 || self.calculatorviewIndex == 4){
            
            controller.congruentcolorflag = true;
            controller.incongruentcolorflag = false;
            controller.blackflag = false;
            
        }
        
        if(self.calculatorviewIndex == 1 || self.calculatorviewIndex == 3) {
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = false;
            controller.blackflag = true;
        }
        
    }
    
    if(self.pageorder == 2){
        
        controller.temppageorder = 2;
        controller.finishtestflag = false;
        
        if(self.calculatorviewIndex == 0 || self.calculatorviewIndex == 2){
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = false;
            controller.blackflag = true;
            
        }
        
        if(self.calculatorviewIndex == 1 || self.calculatorviewIndex == 4){
            
            controller.congruentcolorflag = false;
            controller.incongruentcolorflag = true;
            controller.blackflag = false;
          
        }
        
        if(self.calculatorviewIndex == 3 || self.calculatorviewIndex == 5) {
            
            controller.congruentcolorflag = true;
            controller.incongruentcolorflag = false;
            controller.blackflag = false;
         
        }
        
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
