//
//  CCColorValueTableViewCell.h
//  ColourCalculator
//
//  Created by Adrian on 4/9/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCColorValueTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *buttonString;
@property (weak, nonatomic) IBOutlet UILabel *colorValue;
@property (weak, nonatomic) IBOutlet UILabel *complementary_colour;

@end