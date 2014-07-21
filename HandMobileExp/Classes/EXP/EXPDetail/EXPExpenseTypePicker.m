//
//  EXPExpenseTypePicker.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPExpenseTypePicker.h"

@implementation EXPExpenseTypePicker{
   NSArray *expense_types;
    
}
@synthesize  expense_classes;

@synthesize expense_class_id;
@synthesize expense_class_desc;

@synthesize expense_type_id;
@synthesize expense_type_desc;


@synthesize cell;


-(id)init{
    self = [super init];
    if(self){

        
    }
    return  self;
}

#pragma UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [expense_classes count];
            break;
        case 1:
            return [expense_types count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            
            return [[expense_classes objectAtIndex:row] objectForKey:@"expense_class_desc"];
            break;
        case 1:
            
            return [[expense_types objectAtIndex:row] objectForKey:@"expense_type_desc"];
            break;
        default:
            return nil;
            break;
    }
}
#pragma UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            expense_types = [[expense_classes objectAtIndex:row] objectForKey:@"expense_types"] ;
            //修改值和前台显示
            expense_class_id = [[expense_classes objectAtIndex:row] objectForKey:@"expense_class_id"] ;
            expense_class_desc  =[[expense_classes objectAtIndex:row] objectForKey:@"expense_class_desc"];
            
            
            if(expense_type_desc!=nil && expense_class_desc !=nil){
                cell.detailTextLabel.text= [[expense_class_desc stringByAppendingString:@">"] stringByAppendingString:expense_type_desc];
                
            }

            [self pickerView:pickerView didSelectRow:0 inComponent:1];
            [pickerView reloadComponent:1];
            
            break;
        case 1:
            //修改值和前台显示
            expense_type_id = [[expense_types objectAtIndex:row]objectForKey:@"expense_type_id"];
            expense_type_desc =[[expense_types objectAtIndex:row]objectForKey:@"expense_type_desc"];
            
            if(expense_type_desc!=nil && expense_class_desc !=nil){
                cell.detailTextLabel.text= [[expense_class_desc stringByAppendingString:@">"] stringByAppendingString:expense_type_desc];
                
            }


            break;
        default:
            break;
    }
}

@end
