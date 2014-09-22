//
//  EXPQueryViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-9-20.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPQueryViewController.h"
#import "LMTableDateFromToCell.h"
#import "LMTablePickerInputCell.h"
#import "EXPExpenseTypePicker.h"
#import "EXPLocationPicker.h"
#import "EXPLocationAPI.H"
#import "LMNumberFromToCell.h"
#import "LMTextFieldCell.h"


@interface EXPQueryViewController (){
    
    //cell
    LMTableDateFromToCell *dateCell;
    LMTablePickerInputCell *expenseTypeCell;
    LMTablePickerInputCell *placeCell;
    
    
    LMNumberFromToCell * totalamountFromTo;
    LMTextFieldCell    * comment;
    //tv
    UITableView  * tv;
    
    
    //picker delegate
    EXPExpenseTypePicker * ExpenseTypePicker;
    EXPLocationPicker  *  LocationPicker;
    
}

@end

@implementation EXPQueryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initi
        [self buildCell];
    }
    return self;
}

-(void) buildCell
{
    
    self.title = @"查询条件";
    

    
    
    //init picker
    
    LocationPicker = [[EXPLocationPicker alloc] init];
    LocationPicker.provinces =[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    LocationPicker.citys =[[LocationPicker.provinces objectAtIndex:0] objectForKey:@"Cities"];
    
    NSArray * expense_classes =  [[NSUserDefaults standardUserDefaults] valueForKey:@"expense_classes"];
    ExpenseTypePicker = [[EXPExpenseTypePicker alloc] init];
    ExpenseTypePicker.expense_classes =expense_classes;
    
    //初始化cell
    
    
    dateCell = [[LMTableDateFromToCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTableDateFromToCell"];
    dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    dateCell.parent = self;
 
    //初始化总金额从到 的cell
    totalamountFromTo = [[LMNumberFromToCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"LMNumberFromToCell"];
//    totalamountFromTo.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //费用类型cell
    expenseTypeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
    
    expenseTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    ExpenseTypePicker.cell =expenseTypeCell;
    
    expenseTypeCell.picker.delegate = ExpenseTypePicker;
    expenseTypeCell.picker.dataSource = ExpenseTypePicker;
    
    [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:0 inComponent:0];
    [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:0 inComponent:1];
    
    
    //地点类型
    placeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
    placeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    LocationPicker.cell =placeCell;
    placeCell.picker.delegate =LocationPicker;
    placeCell.picker.dataSource = LocationPicker;

    
    NSString *province = [EXPLocationAPI shareInstance].province;
    NSString *city = [EXPLocationAPI shareInstance].city;
    
    if(![province  isEqualToString:@""] && ![city isEqualToString:@""] && city !=nil  && province !=nil){
        
        
        LocationPicker.province_desc = province;
        LocationPicker.city_desc = city;
        
        NSString *location = [NSString stringWithFormat:@"%@>%@",province,city];
        placeCell.detailTextLabel.text = location;
        placeCell.textLabel.text = @"地点";
        
    }else{
        
        [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:0];
        [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:1];
        
    }
    
    
    //textfield
    comment =  [[LMTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTextFieldCell"];
    

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [tv registerClass:[UITableViewCell class]
forCellReuseIdentifier:@"defaultCell"];
    
    [self.view addSubview:tv];
    tv.dataSource = self;
    tv.delegate = self;
    tv.tableFooterView = [[UIView alloc] init];
    tv.scrollEnabled = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        

        
       UITableViewCell *  cell  =  [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier:@"defaultCell"];
        
        cell.textLabel.text = @"时间";
        cell.detailTextLabel.text  = @"全部";
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
        
        return cell;
    
    }
    
    if(indexPath.row ==1){
        return expenseTypeCell;
    }
    
    if(indexPath.row == 2){
        
        return placeCell;
    }
    
    if(indexPath.row == 3){
        
        return comment;
    }


    
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
