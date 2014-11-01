//
//  ImagePickerActionSheet.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPickerActionSheetDelegate1.h"

@interface ImagePickerActionSheet1 : NSObject <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>



-(id)initWithView:(UIViewController *)viewcontroller
         delegate:(id<IPickerActionSheetDelegate1>)delegate;

-(void)showActionSheet;
@end
