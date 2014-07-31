//
//  CompositeDictionary.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "CompositeDictionary.h"

@implementation CompositeDictionary

@synthesize parent = _parent;
@synthesize name =_name;
@synthesize childs=_childs;
@synthesize attr = _attr;

-(id)init:(NSString *) name{
    self = [super init];
    if(self){
        
        _name = name;
        _childs = [[NSMutableArray alloc] init];
        _attr = [[NSMutableDictionary alloc] init];
    }
    
    return  self;
}

@end
