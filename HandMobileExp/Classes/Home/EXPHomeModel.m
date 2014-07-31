//
//  EXPHomeModel.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-23.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPHomeModel.h"

@implementation EXPHomeModel


-(id)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

- (void)load:(int)cachePolicy more:(BOOL)more{
    NSLog(@"hello");
    [self loadMethod:@"query" param:nil excute:@selector(QUERYALL_MOBILE_EXP_REPORT_LINE:)];
    
}

@end
