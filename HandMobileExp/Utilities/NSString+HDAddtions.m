//
//  NSString+HDAddtions.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-5.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "NSString+HDAddtions.h"

@implementation NSString (HDAddtions)

-(NSString *)stringByReplacingSpaceHodlerWithDictionary:(NSDictionary *)dictionary{
    NSString * templete = self;
    
    NSEnumerator * e = [dictionary keyEnumerator];
    for (NSString * key; (key = [e nextObject]);) {
        NSString * replaceString = [NSString stringWithFormat:@"${%@}",key];
        NSString * valueString = [NSString stringWithFormat:@"%@",[dictionary valueForKey:key]];
        
        templete = [templete stringByReplacingOccurrencesOfString:replaceString withString:valueString];
    }
    return templete;
    
}
@end
