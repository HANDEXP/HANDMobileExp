//
//  CompositeDictionary.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-29.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompositeDictionary : NSMutableDictionary

@property (nonatomic,strong)NSString * name;
@property (nonatomic,strong)CompositeDictionary *parent;
@property (nonatomic,strong)NSMutableArray * childs;
@property (nonatomic,strong)NSMutableDictionary * attr;


-(id)init:(NSString *) name;
@end
