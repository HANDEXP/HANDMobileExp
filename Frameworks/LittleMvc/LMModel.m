//
//  LMModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-3.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModel.h"


@implementation LMModel

-(id)init{
    self=[super init];
    if(self){
        
        _delegates = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSMutableArray*)delegates{
    
    return _delegates;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didStartLoad {
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
}

- (void)didFinishLoad{
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}



@end
