//
//  CCUserDataManager.h
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/4/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCCalculatorButtonData;
@class CCCalculatorNumberData;

@interface CCUserDataManager : NSObject

@property (strong, nonatomic) NSArray *standardButtonData;
@property (strong, nonatomic) NSArray *numberDisplayData;
@property (assign, nonatomic) BOOL secondFunction;
@property (strong, nonatomic) NSNumber *m;
@property (nonatomic) Boolean colorFlag;

+ (CCUserDataManager *)sharedManager;

- (CCCalculatorButtonData *)getButtonDataForTag:(NSInteger)tag;
- (CCCalculatorNumberData *)getNumberDataForInteger:(NSInteger)integer;

- (void)updateNumberColor:(UIColor *)color forNumberData:(CCCalculatorNumberData *)numberData;

- (void)updateButtonColor:(UIColor *)color forButtonData:(CCCalculatorButtonData *)buttonData;
- (void)updateDisplayNumberColor:(UIColor *)color forButtonData:(CCCalculatorButtonData *)buttonData;

- (NSDictionary *)getNumberColorDictionary;

- (void)resetData;
- (void)removeDisplayData;


@end
