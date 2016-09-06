//
//  CCInstructionPopUp.m
//  ColourCalculator
//
//  Created by Adrian on 8/19/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCInstructionPopUp.h"

@implementation CCInstructionPopUp

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        self.layer.borderColor = [[UIColor blackColor]CGColor];
        self.layer.borderWidth = 1.0;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

@end
