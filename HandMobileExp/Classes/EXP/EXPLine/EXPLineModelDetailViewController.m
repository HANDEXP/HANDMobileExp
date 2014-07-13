//
//  EXPLineModelViewController.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-7-8.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPLineModelDetailViewController.h"
#import "EXPLineDetailModel.h"
#import "EXPLineDetailHtppModel.h"


@interface EXPLineModelDetailViewController (){
    
    NSArray *provinces;
    NSArray	*cities;
    
    NSArray *expenseFClass;
    NSArray *expenseSClass;
    
    EXPLineDetailModel * model;
    EXPLineDetailHtppModel * httpmdel;
    
    LMTableDateInputCell *dateCell;
    LMTableAmountInputCell *amountCell;
    LMTablePickerInputCell *expenseTypeCell;
    LMTablePickerInputCell *placeCell;
    
    
    NSString * expense_item1;
    NSString * expense_item2;
    NSString * expense_tyep_desc;
    
    
    
    
    
}

@end

@implementation EXPLineModelDetailViewController
@synthesize insertFlag;
@synthesize updateFlag;

static NSString *simpleTableIdentifier = @"LMTableDateInputCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //给造一些假数据
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
        
        cities = [[provinces objectAtIndex:0] objectForKey:@"Cities"];
        
        
        expenseFClass = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"expense.plist" ofType:nil]];
        
        expenseSClass = [[expenseFClass objectAtIndex:0] objectForKey:@"second_class"];
        
        // Custom initialization
        
        updateFlag = NO;
        insertFlag = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    
    //初始化tableview
    [super viewDidLoad];
    self.tv = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    
    self.tv.tableFooterView = [[UIView alloc]init];
    
    self.tv.separatorStyle = nil;
    [self.view addSubview:self.tv];
    
    
    
    model = [[EXPLineDetailModel alloc] init];
    [model.delegates addObject:self];
    httpmdel = [[EXPLineDetailHtppModel alloc] init];
    
    //对线进行处理
    UIView *div1 = [UIView new];
    div1.frame = CGRectMake(10.0f, 80.0f ,
                            self.view.frame.size.width - 2 * 10.0f, 1.0f);
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    
    UIView *div2 = [UIView new];
    div2.frame = CGRectMake(10.0f, 130.0f ,
                            self.view.frame.size.width - 2 * 10.0f, 1.0f);
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    
    
    
    UIView *div3 = [UIView new];
    div3.frame = CGRectMake(10.0f, 180.0f ,
                            self.view.frame.size.width - 2 * 10.0f, 1.0f);
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    
    UIView *div4 = [UIView new];
    div4.frame = CGRectMake(10.0f, 230.0f ,
                            self.view.frame.size.width - 2 * 10.0f, 1.0f);
    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    
    UIView  * div5_1 = [UIView new];
    div5_1.frame =CGRectMake(10.0f, 230.0f ,
                             self.view.frame.size.width/2 - 2 * 10.0f, 1.0f);
    div5_1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div5_1];
    
    UIView * div5_2 =[UIView new];
    div5_2.frame = CGRectMake(self.view.frame.size.width/2+10 , 230.0f ,
                              self.view.frame.size.width/2 - 2 * 10.0f, 1.0f);
    div5_2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div5_2];
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-10, 220.0f, 20, 20)];
    lb3.text = @"备注";
    lb3.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:lb3];
    
    self.descTx = [[UITextView alloc] initWithFrame:CGRectMake(0, 240, self.view.bounds.size.width, 100)];
    
    self.descTx.delegate = self;
    [self.view addSubview:self.descTx];
    
    self.descTx.tag = 1;
    
    
    //添加按键
    self.save = [[UIButton alloc] initWithFrame:CGRectMake(0, 340, self.view.bounds.size.width/2, 30)];
    [self.save setTitle:@"保存" forState: UIControlStateNormal];
    [self.save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchDown];
    [self.save setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.save];
    
    
    self.saveAdd = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, 340, self.view.bounds.size.width/2, 30)];
    [self.saveAdd setTitle:@"保存再记" forState:UIControlStateNormal];
    [self.saveAdd setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.saveAdd];
    
    
    //键盘相关处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma btn delegate
-(void)save:(UIButton *)paramSender{
    
    NSData *data = UIImageJPEGRepresentation(  [amountCell.img image],1.0);
    NSLog(@"data length is %d",data.length);
    
    
    NSNumber * type_id = [NSNumber numberWithInt:1];
    NSNumber * total_amount = [NSNumber numberWithInteger:amountCell.numberValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time = [formatter stringFromDate:dateCell.dateValue];
    
    

    NSLog(@"%d",amountCell.numberValue );
    NSLog(@"%@",dateCell.dateValue);
    NSLog(@"%@,",placeCell.place_desc);
    NSLog(@"%@",expense_tyep_desc);
    NSLog(@"%@",self.descTx.text);
    
    
    
    if(insertFlag && !updateFlag){
        NSDictionary * record = @{
                                         @"exp_expense_type_id" : type_id,
                                         @"exp_expense_type_desc" :expense_tyep_desc,
                                         @"total_amount" : total_amount,
                                         @"time"    : time ,
                                         @"place"    : placeCell.place_desc,
                                         @"status"    :@"new",
                                         @"line_description" : self.descTx.text,
                                         @"creatdate" : [NSDate date],
                                         @"create_by" : @"1",
                                         @"item1" : data
                                         };
        NSArray * recordlist = @[record];
        [model save:recordlist];
    }else{
        NSDictionary * record = @{
                                         @"exp_expense_type_id" : type_id,
                                         @"exp_expense_type_desc" :expense_tyep_desc,
                                         @"total_amount" : total_amount,
                                         @"time"    : time ,
                                         @"place"    : placeCell.place_desc,
                                         @"status"    :@"new",
                                         @"line_description" : self.descTx.text,
                                         @"creatdate" : [NSDate date],
                                         @"create_by" : @"1",
                                         @"item1" : data,
                                         @"id" : self.keyId
                                         };
        
        NSArray * recordlist = @[record];
        [model update:recordlist];
    }
    
    
}


-(void)upload:(UIButton *)paramSender{


    NSData *data = UIImageJPEGRepresentation(  [amountCell.img image],1.0);
    NSLog(@"data length is %d",data.length);
    
    
    NSNumber * type_id = [NSNumber numberWithInt:1];
    NSNumber * total_amount = [NSNumber numberWithInteger:amountCell.numberValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *time = [formatter stringFromDate:dateCell.dateValue];
    
    
    NSDictionary * record = @{
                              @"exp_expense_type_id" : type_id,
                              @"exp_expense_type_desc" :expense_tyep_desc,
                              @"total_amount" : total_amount,
                              @"time"    : time ,
                              @"place"    : placeCell.place_desc,
                              @"status"    :@"new",
                              @"line_description" : self.descTx.text,
                              @"creatdate" : [NSDate date],
                              @"create_by" : @"1",
                              @"item1" : data,
                              @"id" : self.keyId
                              };
    
    [httpmdel load:record];
    
    
}



#pragma tableview datasource
- (void)tableViewCell:(LMTableDateInputCell *)cell didEndEditingWithDate:(NSDate *)value
{
	NSLog(@"%@ date changed to: %@", cell.textLabel.text, value);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LMTableDateInputCell";
    
    if(indexPath.section ==0){
        amountCell= (LMTableAmountInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTableAmountInputCell"];
        if (amountCell == nil)
        {
            amountCell = [[LMTableAmountInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTableAmountInputCell"];
            amountCell.tv = self;
        }
        return amountCell;
    }else if(indexPath.section == 1){
        expenseTypeCell= (LMTablePickerInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTablePickerInputCell"];
        if (expenseTypeCell == nil)
        {
            expenseTypeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
            
            
        }
        expenseTypeCell.picker.delegate = self;
        expenseTypeCell.picker.dataSource = self;
        
        expenseTypeCell.textLabel.text = @"费用";
        [self pickerView:expenseTypeCell.picker didSelectRow:0 inComponent:0];
        [self pickerView:expenseTypeCell.picker didSelectRow:1 inComponent:1];
        return expenseTypeCell;
        
    }else if(indexPath.section == 2){
        dateCell  = (LMTableDateInputCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (dateCell == nil)
        {
            dateCell = [[LMTableDateInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
        return dateCell;
        
    }else if(indexPath.section == 3){
        placeCell= (LMTablePickerInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTablePickerInputCell"];
        if (placeCell == nil)
        {
            placeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
            
            
        }
        placeCell.item1 = provinces;
        placeCell.item2 = cities;
        
        [placeCell pickerView:placeCell.picker didSelectRow:0 inComponent:0];
        [placeCell pickerView:placeCell.picker didSelectRow:1 inComponent:1];
        
        placeCell.textLabel.text = @"地点";
        return placeCell;
    }
    
    return  nil;
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:
            return 80;
            break;
        case 1:
            return 50;
        case 2:
            return 50;
        case 3:
            return 50;
        default:
            return 50;
            break;
    }
    
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
            return [expenseFClass count];
            break;
        case 1:
            return [expenseSClass count];
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
            
            return [[expenseFClass objectAtIndex:row] objectForKey:@"first_class"];
            break;
        case 1:
            
            return [expenseSClass objectAtIndex:row] ;
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
            expense_item1 = [[expenseFClass objectAtIndex:row] objectForKey:@"first_class"] ;
            if(expense_item1 != nil && expense_item2 != nil){
                expense_tyep_desc = [[expense_item1 stringByAppendingString:@">"]stringByAppendingString:expense_item2];
                
                expenseTypeCell.detailTextLabel.text =expense_tyep_desc;
            }
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:1];
            
            break;
        case 1:
            expense_item2 = [expenseSClass objectAtIndex:row] ;
            
            if(expense_item1 != nil && expense_item2 != nil){
                expense_tyep_desc = [[expense_item1 stringByAppendingString:@">"]stringByAppendingString:expense_item2];
                
                expenseTypeCell.detailTextLabel.text =expense_tyep_desc;
            }
            break;
        default:
            break;
    }
}


#pragma  modeldelegate
-(void)modelDidFinishLoad:(id)model{
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    if([className isEqualToString:@"EXPLineDetailModel"]){
        EXPLineDetailModel *_model = model;
        
        if([_model.method isEqualToString:@"insert"]){
            [self.save setTitle:@"保存修改" forState: UIControlStateNormal];
            insertFlag = NO;
            updateFlag = YES;
            self.keyId =  [_model getPrimaryKey:@"MOBILE_EXP_REPORT_LINE"];
            
            self.upload = [[UIButton alloc] initWithFrame:CGRectMake(50, 390, self.view.bounds.size.width - 100, 30)];
            [self.upload setTitle:@"提交数据" forState:UIControlStateNormal];
            [self.upload setBackgroundColor:[UIColor orangeColor]];
            [self.upload addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchDown];
            [self.view addSubview:self.upload];
            
            
        }else if([_model.method isEqualToString:@"update"]){
            
        }
        
    }
}

@end
