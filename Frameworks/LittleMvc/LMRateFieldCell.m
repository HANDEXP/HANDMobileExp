//
//  LMRateFieldCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-11-17.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMRateFieldCell.h"
#import "EXPRateViewController.h"

@implementation LMRateFieldCell{
    
    //标记开始输入小数
    BOOL dotBeginFlag;
    BOOL firstInput;
    BOOL endFlag;
    NSInteger  dotnumber;
}

@synthesize numberFormatter;
@synthesize lowerLimit;
@synthesize upperLimit;
@synthesize keyboardType;
@synthesize numberValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMRateFieldCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        
        
        [self buildViews];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected){
        
        firstInput = YES;
        dotBeginFlag = NO;
        endFlag= NO;
        dotnumber=2;
        [self becomeFirstResponder];
    }
    // Configure the view for the selected state
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}


- (void)done:(id)sender {
	[self resignFirstResponder];
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


////////////private////////////
-(void) buildViews
{
    
    ////init
    // Initialization code
	self.keyboardType = UIKeyboardTypeDecimalPad;
	self.lowerLimit = 0;//最小为0
	self.upperLimit = 1000000000; //最大允许9位
    self.numberValue = 1;
    
    
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
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setCurrency)];
    self.currencyLabel.userInteractionEnabled = YES;
    [self.currencyLabel addGestureRecognizer:tap];
    
    
}

/////////CLCIK/////
-(void)setCurrency
{
    EXPRateViewController * rate = [[EXPRateViewController alloc] init];
    rate.parent  = self.parent;
    [self.parent.navigationController pushViewController:rate animated:YES];
}


- (BOOL)hasText {
	return YES;
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
                
                self.exchangRateLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.numberValue]];
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
			self.exchangRateLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
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
        self.exchangRateLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
        return;
    }
    
	self.numberValue = self.numberValue / 10;
	if (self.numberValue < self.lowerLimit) {
		self.numberValue = self.lowerLimit;
	} else if (self.numberValue > self.upperLimit) {
		self.numberValue = self.upperLimit;
	}
	self.exchangRateLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
    
	valueChanged = YES;
}

@end
