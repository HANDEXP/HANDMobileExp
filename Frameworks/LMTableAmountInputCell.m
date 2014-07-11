//
//  LMTableAmountInput.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMTableAmountInputCell.h"



@implementation LMTableAmountInputCell

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
	self.keyboardType = UIKeyboardTypeNumberPad;
	self.lowerLimit = 0;
	self.upperLimit = UINT32_MAX;
	
	if (!self.numberFormatter) {
		self.numberFormatter = [[NSNumberFormatter alloc] init];
		self.numberFormatter.numberStyle = NSNumberFormatterNoStyle;
		self.numberFormatter.maximumFractionDigits = 0;
	}
	
	self.detailTextLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMTableAmountInputCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        [self initalizeInputView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
	if (selected) {
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
	return (self.numberValue > 10);
}

- (void)insertText:(NSString *)theText {
	
	// make sure we receioved an integer (on the iPad a user chan change the keybord style)
	NSScanner *sc = [NSScanner scannerWithString:theText];
	if ([sc scanInteger:NULL]) {
		if ([sc isAtEnd]) {
			NSUInteger addedValues = [theText integerValue];
			
			self.numberValue *= (10 * theText.length);
 
			self.numberValue += addedValues;
			if (self.numberValue < self.lowerLimit) {
				self.numberValue = self.lowerLimit;
			} else if (self.numberValue > self.upperLimit) {
				self.numberValue = self.upperLimit;
			}
			self.amount.text= [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
            NSLog(@"%@dfdfdfdf",self.detailTextLabel.text);
			valueChanged = YES;
            NSLog(@"numbervalue is %d,addvalues is %d",self.numberValue,addedValues);
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
	self.detailTextLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithInteger:self.numberValue]];
    
	valueChanged = YES;
}

@end
