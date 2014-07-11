//
//  LMTableAmountInput.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableAmountInputCell.h"



@implementation LMTableAmountInputCell{
    struct {
        unsigned int start:1;
        unsigned int end:1;
        unsigned int  decimal;
        unsigned  int decimalstart:1;

    } _flags;
    
    float numberValue;
}


@synthesize numberFormatter;
@synthesize delegate;
@synthesize lowerLimit;
@synthesize upperLimit;

@synthesize autocapitalizationType;
@synthesize autocorrectionType;
@synthesize enablesReturnKeyAutomatically;
@synthesize keyboardAppearance;
@synthesize keyboardType;
@synthesize returnKeyType;
@synthesize secureTextEntry;
@synthesize spellCheckingType;


- (void)initalizeInputView {
	// Initialization code
	self.keyboardType = UIKeyboardTypeDecimalPad;
	self.lowerLimit = 0;
	self.upperLimit = UINT32_MAX;
	
	if (!self.numberFormatter) {
		self.numberFormatter = [[NSNumberFormatter alloc] init];
		self.numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
		self.numberFormatter.maximumFractionDigits = 2;
	}
	
	self.detailTextLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:numberValue]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMTableAmountInputCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        [self initalizeInputView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress)];
        self.img.userInteractionEnabled = YES;
        [self.img addGestureRecognizer:singleTap];
        
        
    }
    return self;
}

#pragma img press delegate
-(void)buttonpress{
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
    
    [sheet showInView:self.tv.view];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
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
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self.tv presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    
        [self.img setImage:savedImage];
    
        self.img.tag = 100;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self.tv dismissViewControllerAnimated:YES completion:^{}];
}

#pragma  cell select
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    
    [super setSelected:selected animated:animated];
	if (selected) {
        _flags.end = 0;
        _flags.start = 1;
         
        [self becomeFirstResponder];
         
	}
}


#pragma mark -
#pragma mark Respond to touch and become first responder.

- (BOOL)canBecomeFirstResponder {
	return YES;
}

#pragma mark -
#pragma mark UIKeyInput Protocol Methods

- (BOOL)hasText {
	return (numberValue > 10);
}

- (void)insertText:(NSString *)theText {

	// make sure we receioved an integer (on the iPad a user chan change the keybord style)
	NSScanner *sc = [NSScanner scannerWithString:theText];
    
    if(_flags.start){
        _flags.start = 0 ;
        _flags.end = 0 ;
        numberValue = 0.00f;
    }
    if([theText isEqualToString:@"."] && !(_flags.end)){
        _flags.decimalstart =YES;
        _flags.decimal = 2;
        _flags.end =1;
        NSLog(@"%d",_flags.decimal);
        NSLog(@"in ");
    }
    
	if ([sc scanInteger:NULL]) {
		if ([sc isAtEnd]) {
            if(_flags.decimalstart  && _flags.decimal){
                _flags.decimal--;
                NSLog(@"in sc is AtEnd");
                float addedValues = [theText floatValue];
                float right = pow(0.1,(2-_flags.decimal));
                addedValues = addedValues *right;

                numberValue += addedValues;
              self.amount.text= [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:numberValue]];
                return;
                
            }else if(!_flags.end){
                
                NSUInteger addedValues = [theText floatValue];
            
                numberValue *= (10 * theText.length);
 
                numberValue += addedValues;
                if (numberValue < self.lowerLimit) {
                    numberValue = self.lowerLimit;
                } else if (numberValue > self.upperLimit) {
                    numberValue = self.upperLimit;
                }
                self.amount.text= [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:numberValue]];
                valueChanged = YES;
            }
		}
	}
    
}

- (void)deleteBackward {
	numberValue = numberValue / 10;
	if (numberValue < self.lowerLimit) {
		numberValue = self.lowerLimit;
	} else if (numberValue > self.upperLimit) {
		numberValue = self.upperLimit;
	}
	self.amount.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:numberValue]];
    
	valueChanged = YES;
}

@end
