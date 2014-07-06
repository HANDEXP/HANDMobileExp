//
//  NSString+HDAddtions.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HDAddtions)

//根据dictionary中的key,替换字符串中 ${key} 形式的占位符
-(NSString *) stringByReplacingSpaceHodlerWithDictionary:(NSDictionary *) dictionary;

@end