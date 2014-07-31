//
//  CompositeXmlParser.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompositeXmlParser : NSObject <NSXMLParserDelegate>

-(id)initWithXmlPath:(NSString *)xmlpath;
-(BOOL)parse;
@end
