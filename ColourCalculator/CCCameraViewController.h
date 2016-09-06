//
//  CCCameraViewController.h
//  ColourCalculator
//
//  Created by Adrian on 8/11/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Affdex/Affdex.h>

@interface CCCameraViewController : UIViewController <AFDXDetectorDelegate>

@property (strong) AFDXDetector *detector;
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;

@end
