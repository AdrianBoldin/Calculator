//
//  CCCameraViewController.m
//  ColourCalculator
//
//  Created by Adrian on 8/11/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCCameraViewController.h"
#define YOUR_AFFDEX_LICENSE_STRING_GOES_HERE @"{\"token\":\"a1bf4dbe03f52feea228e1e425492dfe2ed18f412b75b9959b9edd72d657b4d7\",\"licensor\":\"Affectiva Inc.\",\"expires\":\"2016-09-28\",\"developerId\":\"jber8397@uni.sydney.edu.au\",\"software\":\"Affdex SDK\"}"

@interface CCCameraViewController ()

@end

@implementation CCCameraViewController

#pragma mark - 
#pragma mark Convenience Methods

// This is a conenience method that is called by the detector:hasResults:forImage:atTime:delegate method below.
// You will want to do something with the face (or faces) found.

//-(void)viewDidLoad{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.cameraView.frame.size.width, self.cameraView.frame.size.height)];
//    view.backgroundColor = [UIColor greenColor];
//    
//    [self.cameraView addSubview:view];
//}
-(void)processedImageReady:(AFDXDetector *)detector image:(UIImage *)image faces:(NSDictionary *)faces atTime:(NSTimeInterval)time;
{
    //iterate on the valuses of the faces dictionary
    for (AFDXFace *face in [faces allValues])
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"smile" message:[NSString stringWithFormat:@"%f",face.emotions.joy] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

// This is a convenience method that is called by the detector:hasResults:forImage:atTime:delegate method below.
// It handles all Unprocessed imsges from the detector.
-(void)unprocessedImageReady:(AFDXDetector *)detector image:(UIImage *)image atTime:(NSTimeInterval)time;
{
    __block CCCameraViewController *weakSelf = self;
    
    //UI work must be on the main thread, so dispatch it there.
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.cameraView setImage:image];
    });
}

-(void)destroyDetector;
{
    [self.detector stop];
}

-(void)createDetector;
{
    //ensure the detector has stopped
    [self destroyDetector];
    
    //create a new detector, set the processing frame rate in frames per second, and set the license string
    self.detector = [[AFDXDetector alloc]initWithDelegate:self usingCamera:AFDX_CAMERA_FRONT maximumFaces:1];
    self.detector.maxProcessRate = 5;
    self.detector.licenseString = YOUR_AFFDEX_LICENSE_STRING_GOES_HERE;
    
    //turn on gender and glasses
    self.detector.gender = TRUE;
    self.detector.glasses = TRUE;
    //turning on a few emotions
    self.detector.joy = TRUE;
    self.detector.anger = TRUE;
    
    //turning on a few expressions
    self.detector.smile = YES;
    self.detector.browRaise = YES;
    self.detector.browFurrow = YES;
    
    //start the detector and check for failure
    NSError *error = [self.detector start];
    
    if(nil !=error){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Detector Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{}];
        
        return;
    }
}

#pragma mark -
#pragma mark AFDXDetectorDelegate Methods

// This is the delegate method of the AFDXDetectorDelegate protocol. This method gets called for:
// -Every frame coming in from the camera. In this case, faces is nil
// -Every PROCESSED frame that the detector
-(void)detector:(AFDXDetector *)detector hasResults:(NSMutableDictionary *)faces forImage:(UIImage *)image atTime:(NSTimeInterval)time
{
    if (nil == faces){
        [self unprocessedImageReady:detector image:image atTime:time];
    }
    else
    {
        [self processedImageReady:detector image:image faces:faces atTime:time];
    }
}

#pragma mark -
#pragma  mark View Methods

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createDetector]; // create the detector just before the view appears
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self destroyDetector]; // destroy the detector before the view disappears
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
