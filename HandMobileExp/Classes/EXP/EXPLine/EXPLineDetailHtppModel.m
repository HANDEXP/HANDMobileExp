//
//  EXPLineDetailHtppModel.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-11.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineDetailHtppModel.h"
#import "EXPApplicationContext.h"
#import "AFHTTPRequestOperationManager.h"

@implementation EXPLineDetailHtppModel

-(BOOL)autoLoaded{
    return false;
    
}
-(void)postLine:(NSDictionary *)parm{

    [self request:@"GET" param:parm url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert" ]];
    
}

- (void)upload:(NSDictionary *)param
      fileName:(NSString *)fileName
          data:(NSData *)data{

    
    [self uploadparam:param filedata:data filename:fileName mimeType:@"image/jpeg"
     url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert"  ]];
    
}


-(void)upload:(NSDictionary *)param
{
    [self param:param url:[[EXPApplicationContext shareObject] keyforUrl:@"hmb_expense_detail_insert"  ]];
    
}

@end
