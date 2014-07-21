//
//  EXPLocationPicker.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-21.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLocationPicker.h"

@implementation EXPLocationPicker{

    
}
@synthesize province_desc;
@synthesize city_desc;
@synthesize provinces;
@synthesize citys;

#pragma UIPickerViewDataSource


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [citys count];
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
            
            return [[provinces objectAtIndex:row] objectForKey:@"State"];
            break;
        case 1:
            
            return [[citys objectAtIndex:row] objectForKey:@"city"];
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
            province_desc = [[provinces objectAtIndex:row] objectForKey:@"State"];
            citys = [[provinces objectAtIndex:row] objectForKey:@"Cities"];
            
            if(province_desc!=nil && city_desc !=nil){
                self.cell.detailTextLabel.text= [[province_desc stringByAppendingString:@">"] stringByAppendingString:city_desc];
                
            }
            
            [self pickerView:pickerView didSelectRow:0 inComponent:1];
            [pickerView reloadComponent:1];
            break;
        case 1:
            city_desc = [[citys objectAtIndex:row] objectForKey:@"city"];
            if(province_desc!=nil && city_desc !=nil){
                self.cell.detailTextLabel.text= [[province_desc stringByAppendingString:@">"] stringByAppendingString:city_desc];
                
            }

            break;
        default:
            break;
    }
}
@end
