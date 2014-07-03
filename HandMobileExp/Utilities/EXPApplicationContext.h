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

@interface EXPApplicationContext : HDSingletonObject

NSString* TTPathForDocumentsResource(NSString* relativePath);
@property(strong) NSMutableDictionary * UrlPatterns;
-(BOOL)configWithXmlPath:(NSString *) xmlPath;
@end
