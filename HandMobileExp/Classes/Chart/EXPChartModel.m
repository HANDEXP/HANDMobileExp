//
//  EXPChartModel.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPChartModel.h"

@implementation EXPChartModel


-(id)init{
    self = [super init];
    if(self){
        
        
        
    }
    
    return self;
}

- (void)load:(int)cachePolicy more:(BOOL)more{
    NSLog(@"hello");
    [self loadMethod:@"query" param:nil excute:@selector(QUERY_MOBILE_EXP_SUM:)];
    
    
    
}
@end
