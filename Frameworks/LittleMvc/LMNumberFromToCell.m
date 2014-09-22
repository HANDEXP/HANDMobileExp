//
//  LMNumberFromToCell.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-9-20.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "LMNumberFromToCell.h"


@implementation LMNumberFromToCell{
    
    int position;
    	UIToolbar *inputAccessoryView;
    
}
@synthesize keyboardType;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"LMNumberFromToCell" owner:self options:nil ];
        self = [nibArray objectAtIndex:0];
        
        [self initalizeview];
    }
    return self;
}
-(void)initalizeview
{
    self.
    self.keyboardType = UIKeyboardTypeDecimalPad;
    
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftpress)];
    self.leftNumberView.userInteractionEnabled = YES;
    [self.leftNumberView addGestureRecognizer:leftTap];
    
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightpress)];
    self.rightNumberView.userInteractionEnabled = YES;
    [self.rightNumberView addGestureRecognizer:rightTap];
    
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}



-(void)rightpress
{

    position = 0;
       [self becomeFirstResponder];
}

-(void)leftpress
{
    position =1;
       [self becomeFirstResponder];
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

- (void)awakeFromNib
{
    // Initialization code
}

-(void)done:(id)sender
{
    [self resignFirstResponder];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
//  [self becomeFirstResponder];
    // Configure the view for the selected state
}

@end
