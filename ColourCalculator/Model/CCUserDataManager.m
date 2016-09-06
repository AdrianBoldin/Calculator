//
//  CCUserDataManager.m
//  ColourCalculator
//
//  Created by Aci Cartagena on 9/4/14.
//  Copyright (c) 2014 Aci Cartagena. All rights reserved.
//

#import "CCUserDataManager.h"
#import "CCCalculatorButtonData.h"
#import "CCCalculatorNumberData.h"

static CCUserDataManager *_instance = nil;
static NSString *const kDataMigratedFromPlistToUserDefaults = @"DataMigratedFromPlistToUserDefaults";
static NSString *const kStandardButtonData = @"StandardButtonData";
static NSString *const kNumberDisplayData = @"NumberDisplayData";
static NSString *const kSecondFunction = @"SecondFunction";
static NSString *const kM = @"M";

@interface CCUserDataManager ()

@property (strong, nonatomic) NSUserDefaults *userDefaults;
@property (strong, nonatomic) NSMutableArray *tempButtonDataArray;
@property (strong, nonatomic) NSMutableArray *tempNumberArray;

@property (assign, nonatomic) BOOL shouldResetData;

@end

@implementation CCUserDataManager

@synthesize standardButtonData = _standardButtonData;
@synthesize numberDisplayData = _numberDisplayData;
@synthesize secondFunction = _secondFunction;
@synthesize m = _m;

+ (CCUserDataManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CCUserDataManager alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        _userDefaults = [NSUserDefaults standardUserDefaults];
        
        if (![_userDefaults objectForKey:kDataMigratedFromPlistToUserDefaults]){
            [_userDefaults setObject:@(YES) forKey:kDataMigratedFromPlistToUserDefaults];
            [_userDefaults synchronize];
            [self initializeData];
        }
    }
    return self;
}

#pragma mark - property
- (NSArray *)standardButtonData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self.userDefaults objectForKey:kStandardButtonData]];
}

- (NSArray *)numberDisplayData
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[self.userDefaults objectForKey:kNumberDisplayData]];
}

-(void)removeDisplayData{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kNumberDisplayData];
}
- (BOOL)secondFunction
{
    return [[self.userDefaults objectForKey:kSecondFunction] boolValue];
}

- (NSNumber *)m
{
    return [self.userDefaults objectForKey:kM];
}

- (void)setStandardButtonData:(NSArray *)standardButtonData
{
    _standardButtonData = standardButtonData;
    [self.userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:_standardButtonData] forKey:kStandardButtonData];
    [self.userDefaults synchronize];
}

- (void)setNumberDisplayData:(NSArray *)numberDisplayData
{
    _numberDisplayData = numberDisplayData;
    [self.userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:_numberDisplayData] forKey:kNumberDisplayData];
    [self.userDefaults synchronize];
    
}

- (void)setSecondFunction:(BOOL)secondFunction
{
    _secondFunction = secondFunction;
    [self.userDefaults setObject:@(secondFunction) forKey:kSecondFunction];
    [self.userDefaults synchronize];
}

- (void)setM:(NSNumber *)m
{
    _m = m;
    [self.userDefaults setObject:m forKey:kM];
    [self.userDefaults synchronize];
}

- (NSMutableArray *)tempButtonDataArray
{
    if (!_tempButtonDataArray || self.shouldResetData){
        _tempButtonDataArray = [self.standardButtonData mutableCopy];
    }
    return _tempButtonDataArray;
}

- (NSMutableArray *)tempNumberArray
{
    if (!_tempNumberArray || self.shouldResetData){
        _tempNumberArray = [self.numberDisplayData mutableCopy];
    }
    return _tempNumberArray;
}


#pragma mark - public buttons
- (CCCalculatorButtonData *)getButtonDataForTag:(NSInteger)tag
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" buttonTag == %i",tag];
    CCCalculatorButtonData *buttonData = [[self.tempButtonDataArray filteredArrayUsingPredicate:predicate] firstObject];
    
    return buttonData;
}

- (CCCalculatorNumberData *)getNumberDataForInteger:(NSInteger)integer
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@" number == %i",integer];
    CCCalculatorNumberData *numberData = [[self.tempNumberArray filteredArrayUsingPredicate:predicate] firstObject];
    
    if (!numberData){
        numberData = [[CCCalculatorNumberData alloc] init];
        numberData.number = @(integer);
        numberData.numberText = [NSString stringWithFormat:@"%li",(long)integer];
        numberData.color = [UIColor blackColor];
        
        [self.tempNumberArray addObject:numberData];
        self.numberDisplayData = self.tempNumberArray;
    }
    
    return numberData;
}

- (void)updateButtonColor:(UIColor *)color forButtonData:(CCCalculatorButtonData *)buttonData
{
    CCCalculatorButtonData *temp = [self getButtonDataForTag:buttonData.buttonTag];
    temp.displayNumberColor = color;
    temp.originaldisplayNumberColor = color;
    temp.symbolColor = color;
    self.standardButtonData = self.tempButtonDataArray;
    
}


- (void)updateDisplayNumberColor:(UIColor *)color forButtonData:(CCCalculatorButtonData *)buttonData
{
    CCCalculatorButtonData *temp = [self getButtonDataForTag:buttonData.buttonTag];
    temp.displayNumberColor = buttonData.displayNumberColor;
    self.standardButtonData = self.tempButtonDataArray;
    
}

- (void)updateNumberColor:(UIColor *)color forNumberData:(CCCalculatorNumberData *)numberData
{
    CCCalculatorNumberData *temp = [self getNumberDataForInteger:numberData.number.intValue];
    temp.color = color;
    self.numberDisplayData = self.tempNumberArray;
}

- (NSDictionary *)getNumberColorDictionary
{
    NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
    for (int i=0;i<10;i++){
        CCCalculatorButtonData *button = [self getButtonDataForTag:i];
        [temp setObject:[NSKeyedArchiver archivedDataWithRootObject:button.displayNumberColor] forKey:@(button.buttonTag)];
    }
    
    for (CCCalculatorNumberData *number in self.tempNumberArray){
        [temp setObject:[NSKeyedArchiver archivedDataWithRootObject:number.color] forKey:number.number];
    }
    
    return temp;
    
}

#pragma mark - initialization data

- (void)resetData
{
    self.standardButtonData = @[];
    
    self.shouldResetData = YES;
    [self initializeData];
    [self tempButtonDataArray];
    [self tempNumberArray];
    self.shouldResetData = NO;
}

- (void)initializeData
{
    NSArray *buttonArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CalculatorButtonInitialData" ofType:@"plist"]];
    NSMutableArray *tempButtons = [[NSMutableArray alloc] initWithCapacity:buttonArray.count];
    for (NSDictionary *buttonDictionary in buttonArray){
        CCCalculatorButtonData *data = [[CCCalculatorButtonData alloc] initWithDictionary:buttonDictionary];
        [tempButtons addObject:data];
    }
    self.standardButtonData = [tempButtons copy];
    
    self.numberDisplayData = [[NSArray alloc] init];
    
}



@end
