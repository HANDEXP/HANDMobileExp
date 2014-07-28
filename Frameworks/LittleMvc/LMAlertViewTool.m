//
//  LMAlertViewTool.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-22.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMAlertViewTool.h"

@implementation LMAlertViewTool
/**
简单封装，调用者要自己实现代理方法
 - (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
*/
+(void)showAlertView:(NSString *) title
             message:(NSString *) message
            delegate:(id)delegate
   cancelButtonTitle:(NSString *) cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles

{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:delegate
                              cancelButtonTitle:cancelButtonTitle
                              otherButtonTitles:otherButtonTitles, nil];
    
    [alertView show];
}
@end