//
//  LMDataBaseModel.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMModel.h"

@interface LMDataBaseModel : LMModel{
    NSString * _method;
    
}
@property (nonatomic,strong)NSString * method;

-(void)dataBaseDidFinishLoad;
-(void)dataBaseDidStartLoad;
-(void)dataBaseDidFailLoadWithError;
@end
