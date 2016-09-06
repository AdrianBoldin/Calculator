//
//  CCReportViewController.h
//  ColourCalculator
//
//  Created by Adrian on 4/8/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface CCReportViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property(strong, nonatomic)NSDictionary *participantTestInfo;

@property (weak, nonatomic) IBOutlet UIView *contentview;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
