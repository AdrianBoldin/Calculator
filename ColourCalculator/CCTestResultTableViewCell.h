//
//  CCTestResultTableViewCell.h
//  ColourCalculator
//
//  Created by Adrian on 4/17/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTestResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@property (weak, nonatomic) IBOutlet UILabel *startTime;
@property (weak, nonatomic) IBOutlet UILabel *time1;
@property (weak, nonatomic) IBOutlet UILabel *time2;
@property (weak, nonatomic) IBOutlet UILabel *time4;
@property (weak, nonatomic) IBOutlet UILabel *time3;
@end
