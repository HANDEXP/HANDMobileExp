//
//  ;
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-11.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "AFNetRequestModel.h"

@interface EXPLineDetailHtppModel : AFNetRequestModel


- (void)load:(NSDictionary *)param;
-(void)postLine:(NSDictionary *)parm;
- (void)upload:(NSDictionary *)param
      fileName:(NSString *)fileName
          data:(NSData *)data;
@end
