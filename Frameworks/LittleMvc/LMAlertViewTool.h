//
//  LMAlertViewTool.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-22.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMAlertViewTool : NSObject


+(void)showAlertView:(NSString *) title
             message:(NSString *) message
            delegate:(id)delegate
   cancelButtonTitle:(NSString *) cancelButtonTitle
   otherButtonTitles:(NSString *)otherButtonTitles;


@end
