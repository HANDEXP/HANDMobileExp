//
//  ImagePickerActionSheet.h
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPickerActionSheetDelegate.h"

@interface ImagePickerActionSheet : NSObject <UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>



-(id)initWithView:(UIViewController *)viewcontroller
         delegate:(id<IPickerActionSheetDelegate>)delegate;

-(void)showActionSheet;
@end
