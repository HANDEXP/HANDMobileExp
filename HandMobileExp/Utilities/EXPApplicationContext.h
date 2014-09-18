//
//  EXPApplicationContext.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-2.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HDSingletonObject.h"
#import "HDXMLParser.h"

@interface EXPApplicationContext : HDSingletonObject{
    
    
}



+(EXPApplicationContext *)shareContext;

NSString* TTPathForDocumentsResource(NSString* relativePath);

-(BOOL)configWithXmlPath:(NSString *) xmlPath;
-(NSMutableArray *)getUrlPatterns;
-(NSString*)keyforUrl:(NSString *)key;
@end
