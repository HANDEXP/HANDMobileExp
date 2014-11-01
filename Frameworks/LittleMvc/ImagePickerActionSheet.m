//
//  ImagePickerActionSheet.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-10-30.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "ImagePickerActionSheet.h"
#import "IPickerActionSheetDelegate.h"

static NSUInteger MAX_SIZE_JPG = 307200;

@implementation ImagePickerActionSheet


{
    id<IPickerActionSheetDelegate>  _delegate;
    
    UIViewController * _viewcontroller;
    
    
    
}

-(id)initWithView:(UIViewController *)viewcontroller
         delegate:(id<IPickerActionSheetDelegate>)delegate
{
    
    self = [self init];
    if(self){
        
        _viewcontroller = viewcontroller;
        _delegate = delegate;
        
    }
    return self;
    
}

/**
显示相册，拍照
 
*/
-(void)showActionSheet
{
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:_viewcontroller.view];
    
    
}
////////////private//////
#pragma mark - 保存图片至沙盒
- (NSData *) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1.0f);
    
    if(imageData.length  > MAX_SIZE_JPG){
        CGFloat rate = (imageData.length - MAX_SIZE_JPG)/imageData.length ;
        imageData = UIImageJPEGRepresentation(  currentImage,rate);
    }
    
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
    
    return imageData;
}





///////////////uiactionsheetdelegate//////////
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = NO;
        
        imagePickerController.sourceType = sourceType;
        
        [_viewcontroller presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


//////////////////UINavigationControllerDelegate, UIImagePickerControllerDelegate///////

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
   
   NSData * imageData =  [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    

    if(_delegate){
        
        [_delegate image: savedImage data:imageData didFinishPickingMediaWithInfo:info];
        
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if(_delegate){
        if( [_delegate respondsToSelector:@selector(DidCancel)]){
            
            [_delegate DidCancel  ];
            
        }
        
    }
    
	[_viewcontroller dismissViewControllerAnimated:YES completion:^{}];
}


@end
