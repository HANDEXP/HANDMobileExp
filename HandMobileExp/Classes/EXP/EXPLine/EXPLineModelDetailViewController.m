//
//  EXPLineModelViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineModelDetailViewController.h"
#import "EXPLineDetailModel.h"


@interface EXPLineModelDetailViewController (){
    
    NSArray *provinces;
    NSArray	*cities;
    EXPLineDetailModel * model;
    
    LMTableDateInputCell *dateCell;
    LMTableAmountInputCell *amountCell;
    LMTablePickerInputCell *pickerCell;
    
}

@end

@implementation EXPLineModelDetailViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //加载数据
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
        cities = [[provinces objectAtIndex:0] objectForKey:@"Cities"];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tv = [[UITableView alloc] initWithFrame:self.view.bounds];
     self.tv.dataSource = self;
    self.tv.delegate = self;
    
    self.tv.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:self.tv];
    
   self.tx = [[UITextView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 100)];
    [self.view addSubview:self.tx];
    
    self.btn=  [[UIButton alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 100)];
    [self.btn setBackgroundColor:[UIColor blackColor]];
    [self.btn setTitle:@"press me " forState:UIControlStateNormal];
    [self.btn addTarget:self
                 action:@selector(save:)
       forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.btn];
    
    model = [[EXPLineDetailModel alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
}
#pragma btn delegate
-(void)save:(UIButton *)paramSender{
    
    NSData *data = UIImageJPEGRepresentation(  [amountCell.img image],1.0);
    NSLog(@"data length is %d",data.length);
    
    
    NSNumber * type_id = [NSNumber numberWithInt:1];
    NSNumber * total_amount = [NSNumber numberWithInteger:amountCell.numberValue];
    NSLog(@"%d",amountCell.numberValue );
    NSLog(@"%@",dateCell.dateValue);
    
    NSDictionary * record = @{
                              @"exp_expense_type_id" : type_id,
                              @"total_amount" : total_amount,
                              @"time"    : [NSDate date] ,
                              @"place"    : @"上海",
                              @"status"    :@"new",
                              @"line_description" : @"插入图片1",
                              @"creatdate" : [NSDate date],
                              @"create_by" : @"1",
                              @"item1" : data
                              };
    NSArray * recordlist = @[record];
    
    [model save:recordlist];
    
}


- (void)tableViewCell:(LMTableDateInputCell *)cell didEndEditingWithDate:(NSDate *)value
{
	NSLog(@"%@ date changed to: %@", cell.textLabel.text, value);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LMTableDateInputCell";
    
    if(indexPath.section == 1){
    dateCell  = (LMTableDateInputCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (dateCell == nil)
    {
        dateCell = [[LMTableDateInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
         return dateCell;
    }else if(indexPath.section == 0){
        amountCell= (LMTableAmountInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTableAmountInputCell"];
        if (amountCell == nil)
        {
            amountCell = [[LMTableAmountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTableAmountInputCell"];
            amountCell.tv = self;
        }

        return amountCell;
    }else if(indexPath.section == 2){
        pickerCell= (LMTablePickerInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTablePickerInputCell"];
        if (pickerCell == nil)
        {
            pickerCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
            

        }
        pickerCell.picker.dataSource = self;
        return pickerCell;
    }
    return  nil;
   
}




#pragma tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  80;
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
            return [provinces count];
            break;
        case 1:
            return [cities count];
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
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"Cities"];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:1];

            break;
        case 1:

            break;
        default:
            break;
    }
}

@end
