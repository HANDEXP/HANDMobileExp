//
//  EXPApplicationContext.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPApplicationContext.h"

@implementation EXPApplicationContext

NSString* TTPathForDocumentsResource(NSString* relativePath) {
    static NSString* documentsPath = nil;
    if (nil == documentsPath) {
        NSArray* dirs = NSSearchPathForDirectoriesInDomains(
                                                            NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
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
        self.UrlPatterns = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void) setPattern:(NSString *) pattern forIdentifier:(NSString *)identifier
{
    if (nil == self.UrlPatterns) {
        self.UrlPatterns = [[NSMutableDictionary alloc]init];
    }
    [self.UrlPatterns setObject:pattern forKey:identifier];
}

-(BOOL)configWithXmlPath:(NSString *) xmlPath{

    HDXMLParser *configParser = [[HDXMLParser alloc]initWithXmlPath:xmlPath];
    [configParser parse];
    if(configParser.patternes !=nil){
        for(NSString * name in configParser.patternes.keyEnumerator){
            [self setPattern:[configParser.patternes objectForKey:name] forIdentifier:name];
        }
        return true;
    }else{
        
        return false;
    }

    
}



@end
