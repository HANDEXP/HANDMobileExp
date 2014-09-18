    //
//  LMTableAmountInput.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableAmountInputCell.h"



@implementation LMTableAmountInputCell{
    
    
}

@synthesize numberValue;
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
	self.lowerLimit = 0;//最小为0
	self.upperLimit = 1000000000; //最大允许9位
	
    dotBeginFlag = NO;
    firstInput = YES;
    endFlag = NO;
    dotnumber = 2;
    
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
                    [self.img setImage:nil];//当按取消的时候移除上次选择的图片
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
                [self.img setImage:nil];//当按取消的时候移除上次选择的图片
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
        firstInput = YES;
        dotBeginFlag = NO;
        endFlag= NO;
        dotnumber=2;
        [self becomeFirstResponder];
         
	}
}

- (UIView *)inputAccessoryView {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return nil;
	} else {
		if (!inputAccessoryView) {
			inputAccessoryView = [[UIToolbar alloc] init];
			inputAccessoryView.barStyle = UIBarStyleDefault;
			inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			[inputAccessoryView sizeToFit];
			CGRect frame = inputAccessoryView.frame;
			frame.size.height = 44.0f;
			inputAccessoryView.frame = frame;
			
			UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
			UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
			
			NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil];
			[inputAccessoryView setItems:array];
		}
		return inputAccessoryView;
	}
}

- (void)done:(id)sender {
	[self resignFirstResponder];
}


#pragma mark -
#pragma mark Respond to touch and become first responder.

- (BOOL)canBecomeFirstResponder {
	return YES;
}

#pragma mark -
#pragma mark UIKeyInput Protocol Methods

- (BOOL)hasText {
	return (self.numberValue > 10);
}

- (void)insertText:(NSString *)theText {
	
	// make sure we receioved an integer (on the iPad a user chan change the keybord style)
	NSScanner *sc = [NSScanner scannerWithString:theText];
	if ([sc scanDecimal:NULL]) {
		if ([sc isAtEnd]) {
            NSLog(@"%@",theText);
            
            if(firstInput){
                firstInput = NO;
                self.numberValue = 0.0f;
            }
            
            if([theText isEqualToString:@"."] ){
                
                
                dotBeginFlag = YES;
                return;
            }
            //如果开始输入小数，且没有结束
            if(dotBeginFlag && !endFlag && dotnumber !=0){
                NSUInteger addedValues = [theText integerValue];
               dotnumber--;
                self.numberValue += addedValues * powf(0.1,  (2-dotnumber));
                
                self.amount.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.numberValue]];
                if(dotnumber ==0){
                    endFlag = YES;
                }
                return;
            }
            
            if(endFlag ){
                return;
            }

            
			NSUInteger addedValues = [theText integerValue];
            if(  upperLimit <=  self.numberValue *(10*theText.length)){
                
                return;
            }
			self.numberValue *= (10 * theText.length);
			self.numberValue += addedValues;
			if (self.numberValue < self.lowerLimit) {
				self.numberValue = self.lowerLimit;
			} else if (self.numberValue > self.upperLimit) {
				self.numberValue = self.upperLimit;
			}
			self.amount.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
//            NSLog(@"text is %@,value is %d text length is %d",self.amount.text,self.numberValue,self.amount.text.length);
			valueChanged = YES;
		}
	}
    
}

- (void)deleteBackward {
    if(endFlag || dotBeginFlag){
        return;
    }
    
    if(firstInput){
        firstInput = NO;
        self.numberValue = 0.0f;
    }
    
	self.numberValue = self.numberValue / 10;
	if (self.numberValue < self.lowerLimit) {
		self.numberValue = self.lowerLimit;
	} else if (self.numberValue > self.upperLimit) {
		self.numberValue = self.upperLimit;
	}
	self.amount.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];

	valueChanged = YES;
}
@end
