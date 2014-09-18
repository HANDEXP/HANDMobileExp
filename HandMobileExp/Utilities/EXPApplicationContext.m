//
//  EXPApplicationContext.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPApplicationContext.h"

@implementation EXPApplicationContext
static NSMutableDictionary * UrlPatterns;


NSString* TTPathForDocumentsResource(NSString* relativePath) {
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
               NSLog(@"%@",documentsPath);
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}

+(EXPApplicationContext *)shareContext
{
    return [self shareObject];
}

- (id)init
{
    self = [super init];
    if (self) {
        UrlPatterns = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(NSMutableDictionary *)getUrlPatterns{
    
    return UrlPatterns;
}

-(void) setPattern:(NSString *) pattern forIdentifier:(NSString *)identifier
{
    if (nil == UrlPatterns) {
        UrlPatterns = [[NSMutableDictionary alloc]init];
    }
    [UrlPatterns setObject:pattern forKey:identifier];
}

-(BOOL)configWithXmlPath:(NSString *) xmlPath{

    HDXMLParser *configParser = [[HDXMLParser alloc]initWithXmlPath:xmlPath];
    [configParser parse];
    if(configParser.patternes !=nil){
        for(NSString * name in configParser.patternes.keyEnumerator){
            NSLog(@"%@hello",name);
            [self setPattern:[configParser.patternes objectForKey:name] forIdentifier:name];
        }
        return true;
    }else{
        
        return false;
    }

    
}

-(NSString*)keyforUrl:(NSString *)key{
    
    return [UrlPatterns valueForKey:key];
}

@end
