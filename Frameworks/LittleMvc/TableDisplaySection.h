//
//  TableDisplaySection.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-14.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDisplaySection : NSObject
@property (nonatomic,strong) NSString * item1;
@property (nonatomic,strong) NSString * item2;


+(id)initwith:(NSString *)item1
        item2:(NSString *)item2;

-(UIView *) getView;
@end
