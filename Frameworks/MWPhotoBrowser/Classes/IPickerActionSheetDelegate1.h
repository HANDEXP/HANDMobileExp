//
//  IPickerActionSheetDelegate.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IPickerActionSheetDelegate1 <NSObject>
@optional

-(void)image:(UIImage *)image data:(NSData * )data didFinishPickingMediaWithInfo:(NSDictionary *)info;
-(void)DidCancel;


@end
