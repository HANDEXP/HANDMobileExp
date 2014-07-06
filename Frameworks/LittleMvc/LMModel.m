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
    if (nil == _delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didStartLoad {
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
}

- (void)didFinishLoad{
    [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
}

- (void)didFailLoadWithError:(NSError*)error {
    [_delegates perform:@selector(model:didFailLoadWithError:) withObject:self
             withObject:error];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(int)cachePolicy more:(BOOL)more {
    
}

-(BOOL)autoLoaded{
    return YES;
    
}

@end
