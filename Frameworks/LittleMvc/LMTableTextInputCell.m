//
//  LMTableTextInputCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-8-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableTextInputCell.h"

@implementation LMTableTextInputCell{
    BOOL valueChanged;
    BOOL firstInput;//是否第一次输入
}


- (void)initalizeInputView {
	// Initialization code
    
	self.keyboardType = UIKeyboardTypeNumberPad;
	self.lowerLimit = 0;//最小为0
	self.upperLimit = 1000000000; //最大允许9位
    self.numberValue = 1;
	
	if (!self.numberFormatter) {
		self.numberFormatter = [[NSNumberFormatter alloc] init];
		self.numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
		self.numberFormatter.maximumFractionDigits = 2;
	}
	
	self.numberLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.numberValue]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMTableTextInputCell" owner:self options:nil ];

        self = [nibArray objectAtIndex:0];
        [self initalizeInputView];
        
    }
    return self;
}

- (void)awakeFromNib
{

    // Initialization code
    self.keyboardType = UIKeyboardTypeNumberPad;
    firstInput = YES;

    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if(selected){
        [self becomeFirstResponder];
    }
    
    NSLog(@"fsfsdf");

    // Configure the view for the selected state
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)hasText {
	return (self.numberValue > 0);
}

- (void)insertText:(NSString *)theText {
	
	// make sure we receioved an integer (on the iPad a user chan change the keybord style)
	NSScanner *sc = [NSScanner scannerWithString:theText];
	if ([sc scanInteger:NULL]) {
		if ([sc isAtEnd]) {
            
            //第一次修改关闭缺省值
            if(firstInput){
                
                firstInput = NO;
                self.numberValue = 0;
            }
            
			NSUInteger addedValues = [theText integerValue];
            if(  self.upperLimit <=  self.numberValue *(10*theText.length)){
                
                return;
            }
			self.numberValue *= (10 * theText.length);
			self.numberValue += addedValues;
			if (self.numberValue < self.lowerLimit) {
				self.numberValue = self.lowerLimit;
			} else if (self.numberValue > self.upperLimit) {
				self.numberValue = self.upperLimit;
			}
			self.numberLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
            //            NSLog(@"text is %@,value is %d text length is %d",self.amount.text,self.numberValue,self.amount.text.length);
			valueChanged = YES;
		}
	}
    
}

- (void)deleteBackward {
	self.numberValue = self.numberValue / 10;
	if (self.numberValue < self.lowerLimit) {
		self.numberValue = self.lowerLimit;
	} else if (self.numberValue > self.upperLimit) {
		self.numberValue = self.upperLimit;
	}
	self.numberLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
    
	valueChanged = YES;
}

@end
