//
//  CCParticipantsTestResult.h
//  ColourCalculator
//
//  Created by Adrian on 4/8/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CCParticipantsTestResult : NSObject


@property( nonatomic)Boolean flag;

-(void)createDictionary:(NSString *)key value:(NSString *)value;
-(void)addObjectToDictionary:(NSDictionary *)dictionary;
-(void)writeJosnStringTofile:(NSMutableDictionary *)testinfoDictionary;
-(NSDictionary*)readingStringFromFile:(NSInteger)participantNumber;
-(NSDictionary *)readingStringFromQuestionFile;
-(void)removeFile;
-(void)removeFile:(NSInteger)num;
-(void)resort;

@end
