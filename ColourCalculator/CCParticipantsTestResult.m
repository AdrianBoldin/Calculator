//
//  CCParticipantsTestResult.m
//  ColourCalculator
//
//  Created by Adrian on 4/8/16.
//  Copyright © 2016 Aci Cartagena. All rights reserved.
//

#import "CCParticipantsTestResult.h"
#import "CCAppDelegate.h"


@implementation CCParticipantsTestResult


-(void)createDictionary:(NSString *)key value:(NSString *)value{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:value forKey:key];
    [self addObjectToDictionary:dic];
}



-(void)addObjectToDictionary:(NSDictionary *)dictionary{
    
    CCAppDelegate *ccAppDelegate = (CCAppDelegate *)[[UIApplication sharedApplication]delegate];
    [ccAppDelegate.participantTestInfo addEntriesFromDictionary:dictionary];
    if(self.flag == true){

        [self writeJosnStringTofile:ccAppDelegate.participantTestInfo];
    }
    
    
}

-(void)writeJosnStringTofile:(NSMutableDictionary *)testinfoDictionary{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger i = [defaults integerForKey:@"participantNumber"];

    if(i<36){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDictionary = [paths objectAtIndex:0];
        NSString *filename = [[NSString alloc]initWithFormat:@"participant%ld",i];

        NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,filename];
        
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
            
            NSError *error;
            
            
            NSArray *array = [NSArray arrayWithObjects:testinfoDictionary, nil];
            
            NSData *jsondata = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc]initWithData:jsondata encoding:NSUTF8StringEncoding];
            
            [jsonString writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:&error];
            
        }

        
    }
   

}

-(NSDictionary*)readingStringFromFile:(NSInteger)participantNumber{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDictionary = [paths objectAtIndex:0];
    NSString *filename = [[NSString alloc]initWithFormat:@"participant%d",participantNumber];
    NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,filename];
        
    NSString *string = [[NSString alloc]initWithData:[NSData dataWithContentsOfFile:filepath] encoding:NSUTF8StringEncoding];
    NSData *objectdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:objectdata options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = [array objectAtIndex:0];
    
    return dic;
    
}

-(NSDictionary *)readingStringFromQuestionFile {
    
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"testQuestions" ofType:@"json"];
    
    
    NSString *string = [[NSString alloc]initWithData:[NSData dataWithContentsOfFile:filePath] encoding:NSUTF8StringEncoding];
    NSData *objectdata = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:objectdata options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic = [[NSDictionary alloc]init];
    
    dic = [array objectAtIndex:0];
    
    return dic;

}


-(void)removeFile {
    
    for(int i=0;i<36;i++){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDictionary = [paths objectAtIndex:0];
        NSString *filename = [[NSString alloc]initWithFormat:@"participant%d",i];
        NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,filename];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filepath error:nil];

    }

}

-(void)removeFile:(NSInteger)num{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDictionary = [paths objectAtIndex:0];
    NSString *filename = [[NSString alloc]initWithFormat:@"participant%d",num];
    NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,filename];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filepath error:nil];

}

-(void)resort{
    
    for(int i=0;i<36;i++){
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDictionary = [paths objectAtIndex:0];
        NSString *filename = [[NSString alloc]initWithFormat:@"participant%d",i];
        NSString *filepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,filename];
        if(![[NSFileManager defaultManager] fileExistsAtPath:filepath]){
            int j = i+1;
            
            NSString *refilename = [[NSString alloc]initWithFormat:@"participant%d",j];
            NSString *refilepath = [NSString stringWithFormat:@"%@/%@", documentsDictionary,refilename];
            if([[NSFileManager defaultManager] fileExistsAtPath:refilepath]){
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager moveItemAtPath:refilename toPath:filepath error:nil];
        
            
            }
        }
        
        
    }

    
}
@end
