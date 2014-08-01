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
#import "EXPLocationAPI.h"
#import "EXPLocationManager.h"
#import "MMProgressHUDWindow.H"


@interface EXPLineModelDetailViewController (){
    

    //model
    EXPLineDetailModel * model;
    EXPLineDetailHtppModel * httpmdel;
    
    //cell
    LMTableDateInputCell *dateCell;
    LMTableAmountInputCell *amountCell;
    LMTablePickerInputCell *expenseTypeCell;
    LMTablePickerInputCell *placeCell;
    
    
    
    //flag
    BOOL  shouldUploadImg;
    
    NSDictionary * record;
    
    
    EXPExpenseTypePicker * ExpenseTypePicker;
    EXPLocationPicker  *  LocationPicker;
    
    
    BOOL  completeFlag;
}

@end

@implementation EXPLineModelDetailViewController
@synthesize insertFlag;
@synthesize updateFlag;
@synthesize readOnlyFlag;

static NSString *simpleTableIdentifier = @"LMTableDateInputCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //初始代理
        LocationPicker = [[EXPLocationPicker alloc] init];
        LocationPicker.provinces =[[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
        LocationPicker.citys =[[LocationPicker.provinces objectAtIndex:0] objectForKey:@"Cities"];
        
        NSArray * expense_classes =  [[NSUserDefaults standardUserDefaults] valueForKey:@"expense_classes"];
        ExpenseTypePicker = [[EXPExpenseTypePicker alloc] init];
        ExpenseTypePicker.expense_classes =expense_classes;

 
        updateFlag = NO;
        insertFlag = YES;
        shouldUploadImg = YES;
        completeFlag = NO;
        readOnlyFlag = NO;
        
        
    }
    return self;
}

-(UIView *)coverView
{
    self.coverView = [[UIView alloc]initWithFrame:self.view.bounds];
    return _coverView;
}

- (void)viewDidLoad
{
    
    
    
    //初始化tableview
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
 //   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"报销单创建" style:UIBarButtonSystemItemDone target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
    
    self.navigationItem.title = @"记一单";
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(8.0, 8.0, self.view.bounds.size.width-16, self.view.bounds.size.height)];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    
    self.tv.tableFooterView = [[UIView alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:1.000];
    self.tv.scrollEnabled = NO;
    self.tv.separatorStyle = nil;
    
    

    self.tv.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:0.310];
    self.tv.backgroundView.backgroundColor = nil;
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    [self.view addSubview:self.tv];
    
    
    
    model = [[EXPLineDetailModel alloc] init];
    [model.delegates addObject:self];
    httpmdel = [[EXPLineDetailHtppModel alloc] init];
    [httpmdel.delegates addObject:self];
    
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
    
    UILabel * lb3 = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2)-10, 222.0f, 20, 20)];
    lb3.text = @"备注";
    lb3.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:lb3];
    
    self.descTx = [[UITextView alloc] initWithFrame:CGRectMake(8.0, 240, self.view.bounds.size.width-16.0, (self.view.bounds.size.height-240)*0.3)];
    self.descTx.delegate = self;
    
    self.descTx.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.843 alpha:1.000];
    [self.view addSubview:self.descTx];
    
    self.descTx.tag = 1;
    
    
    //添加按键
    self.save = [[UIButton alloc] initWithFrame:CGRectMake(8, (self.view.bounds.size.height-240)*0.3+250, 320-16, (self.view.bounds.size.height-240)*0.15)];
    NSLog(@"%f", self.view.bounds.size.height);
    NSLog(@"%f", self.navigationController.navigationBar.bounds.size.height);
    [self.save setTitle:@"保存" forState: UIControlStateNormal];
    [self.save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchDown];
    [self.save setBackgroundColor:[UIColor colorWithRed:0.731 green:0.751 blue:0.525 alpha:0.830]];
    [self.save.layer setCornerRadius:6.0f];
    self.save.showsTouchWhenHighlighted = YES;

    [self.view addSubview:self.save];

    NSLog(@"%f...",self.view.bounds.size.height);
    
        self.upload = [[UIButton alloc] initWithFrame:CGRectMake(8, (self.view.bounds.size.height-240)*0.45+260, self.view.bounds.size.width - 16, (self.view.bounds.size.height-240)*0.15)];
    
//    self.saveAdd = [[UIButton alloc] initWithFrame:CGRectMake(170, self.view.bounds.size.height*0.63, 100, 50)];
//    [self.saveAdd setTitle:@"保存再记" forState:UIControlStateNormal];
//    [self.saveAdd setBackgroundColor:[UIColor colorWithRed:0.780 green:0.805 blue:0.555 alpha:0.670]];
//    [self.saveAdd.layer setCornerRadius:6.0f];
//    [self.view addSubview:self.saveAdd];

    
    //如果是老数据则显示
    if(!insertFlag && updateFlag){
        [self  showUpload];
        [self reload];
    }
    
    if (readOnlyFlag) {
        
        self.upload.hidden = YES;
        self.save.hidden = YES;
        
        [self.view addSubview:self.coverView];
    }
    
}

#pragma private
-(void)reload{
    NSDictionary * param = @{@"id" : self.keyId};
    [model load:0 param:param];
}


-(void)back{
    if(self.detailList != nil){
        [self.detailList reload];
    }
    
    if (self.tableView != nil) {
        [self.tableView reloadData];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void) showUpload{

    [self.save setTitle:@"保存修改" forState: UIControlStateNormal];
    [self.upload.layer setCornerRadius:6.0f];
    NSLog(@"%f",self.view.superview.bounds.size.height);
    [self.upload setTitle:@"提交数据" forState:UIControlStateNormal];
    [self.upload setBackgroundColor:[UIColor orangeColor]];
    [self.upload addTarget:self action:@selector(upload:) forControlEvents:UIControlEventTouchDown];
    self.upload.showsTouchWhenHighlighted = YES;
    [self.view addSubview:self.upload];
    
}

//对数据进行校验
-(BOOL)checkDataVaild{
    //检查金额

    if(amountCell.numberValue == 0 ){
        [LMAlertViewTool showAlertView:@"提示" message:@"请输入正确金额" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        return NO;
    }
    
    return YES;
    
}


#pragma btn delegate
-(void)save:(UIButton *)paramSender{


    
    if(![self checkDataVaild]){
        return;
    }
    
    //获取数据
    NSNumber * expense_class_id = ExpenseTypePicker.expense_class_id;
    NSString * expense_class_desc = ExpenseTypePicker.expense_class_desc;
    
    NSNumber * expense_type_id =  ExpenseTypePicker.expense_type_id;
    NSString * expense_type_desc = ExpenseTypePicker.expense_type_desc;
    
    NSNumber * expense_amount = [NSNumber numberWithInteger:amountCell.numberValue];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *expense_date = [NSString stringWithFormat:@"%@", [formatter stringFromDate:dateCell.dateValue]];
    
    NSString * expense_place = [[LocationPicker.province_desc stringByAppendingString:@">"] stringByAppendingString:LocationPicker.city_desc];
    
    NSString * description = self.descTx.text;

    NSString * local_status = @"new";
    NSString * CREATION_DATE =[formatter stringFromDate:[NSDate date]];
    
    NSString * CREATED_BY = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    
    NSData *data;
    //判断是否有照片，没有照片则插入nil
    if([amountCell.img image] !=nil){
        data = UIImageJPEGRepresentation(  [amountCell.img image],0.1);
        NSLog(@"%d",data.length);
    
    }else{
        
        data = nil;
    }
    NSMutableDictionary * formdata = [[NSMutableDictionary alloc] init];


    
    
    [formdata setValue:expense_class_id forKey:@"expense_class_id"];
    [formdata setValue:expense_class_desc forKey:@"expense_class_desc"];
    [formdata setValue:expense_type_id forKey:@"expense_type_id"];
    [formdata setValue:expense_type_desc forKey:@"expense_type_desc"];
    [formdata setValue:expense_amount forKey:@"expense_amount"];
    [formdata setValue:expense_date forKey:@"expense_date"];
    [formdata setValue:expense_place forKey:@"expense_place"];
    [formdata setValue:description forKey:@"description"];
    [formdata setValue:local_status forKey:@"local_status"];
    [formdata setValue:CREATION_DATE forKey:@"CREATION_DATE"];
    [formdata setValue:CREATED_BY forKey:@"CREATED_BY"];
    

    
    if(data != nil){
        [formdata setValue: data forKey:@"item1"];
    }else{
        //不能直接存放nil，那样会报错
        [formdata setValue: @"" forKey:@"item1"];
    }
    NSArray * recordlist =@[formdata];

    if(insertFlag && !updateFlag){
        [model save:recordlist];
    }else if(!insertFlag && updateFlag && !completeFlag){
        [formdata setValue:self.keyId forKey:@"id"];
        [model update:recordlist];
    }else if(completeFlag){
        [formdata setValue:self.keyId forKey:@"id"];
        [formdata setValue:@"upload" forKey:@"local_status"];
        [model update:recordlist];
    }
    
    
}


-(void)upload:(UIButton *)paramSender{
    




    if(![self checkDataVaild]){
        return;
    }
    //提交之前先保存
    [self save:nil];
    
    if([amountCell.img image] !=nil){
        shouldUploadImg = YES;
    }else{
        
        shouldUploadImg = NO;
    }
    
    NSNumber * expense_amount = [NSNumber numberWithInteger:amountCell.numberValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *expense_date = [formatter stringFromDate:dateCell.dateValue];
    NSString * expense_place = [[LocationPicker.province_desc stringByAppendingString:@">"] stringByAppendingString:LocationPicker.city_desc];
    
    NSString * description = self.descTx.text;
    
    NSNumber * expense_class_id = ExpenseTypePicker.expense_class_id;
    
    NSNumber * expense_type_id =  ExpenseTypePicker.expense_type_id;
    
    
    
//    UIDevice *device = [UIDevice currentDevice];
//   NSUUID *uniqueIdentifier = device.identifierForVendor;
//    NSLog(@"%@",[uniqueIdentifier  UUIDString]);
    
 
    NSDictionary * record = @{
                              @"expense_amount" : expense_amount,
                              @"expense_place" :expense_place,
                              @"expense_class_id" : expense_class_id,
                              @"expense_type_id"    : expense_type_id ,
                              @"expense_date"    : expense_date,
                              @"description" : description,
                              @"local_id" : self.keyId
                              };
    
    [httpmdel postLine:record];
    
    
}


-(int)getArrayIndex:(int )keyId
           class_index:(int) index
                   type:(NSString *)type
{
    if([type isEqualToString:@"expense_class_id"]){
        NSArray * classes =      ExpenseTypePicker.expense_classes;
        
        for(int i =0;i<classes.count;i++){
            NSDictionary * temp = [classes objectAtIndex:i];
            NSNumber * class_id  = [temp valueForKey:@"expense_class_id"];

            if(keyId == [class_id integerValue]){
                return  i;
            }
            
        }
    }else if ([type isEqualToString:@"expense_type_id"]){
        
        NSArray * classes =      ExpenseTypePicker.expense_classes;
        NSDictionary * temp = [classes objectAtIndex:index];
        NSArray * types = [temp valueForKey:@"expense_types"];
        for(int i =0;i<types.count;i++){
            NSDictionary * temp = [types objectAtIndex:i];
            NSNumber * type_id  = [temp valueForKey:@"expense_type_id"];
            
            if(keyId == [type_id integerValue]){
                return  i;
            }
            
        }
        
    }
    return 0;
}



#pragma  viewcontroller life
//对数据进行初始化
-(void)viewWillAppear:(BOOL)animated{
    //赋值
    if(record != nil && !insertFlag && updateFlag){
        //金额
        amountCell.amount.text = [NSString  stringWithFormat:@"%@",[record valueForKey:@"expense_amount"]];
        NSNumber * amount = [record valueForKey:@"expense_amount"];
        amountCell.numberValue =[amount integerValue];
        
        
        //初始化费用类型
        NSNumber * class_id = [record valueForKey:@"expense_class_id"];
        NSNumber * type_id  =  [record valueForKey:@"expense_type_id"];
        
        int classArrId= [self getArrayIndex:[class_id integerValue] class_index:nil type:@"expense_class_id"];
        int typeArrId = [self getArrayIndex:[type_id integerValue]  class_index:classArrId type:@"expense_type_id"];
        
        [expenseTypeCell.picker selectRow:classArrId inComponent:0 animated:YES];
        [expenseTypeCell.picker selectRow:typeArrId inComponent:1 animated:YES];
        
        [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:classArrId inComponent:0];
        [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:typeArrId inComponent:1];

        
        [ expenseTypeCell.picker reloadComponent:0];
        [ expenseTypeCell.picker reloadComponent:1];
        //初始化地址
        NSArray *locationInfo = [[record valueForKey:@"expense_place"] componentsSeparatedByString:@">"];
        LocationPicker.province_desc = [locationInfo objectAtIndex:0];
        LocationPicker.city_desc = [locationInfo objectAtIndex:1];
        placeCell.detailTextLabel.text = [record valueForKey:@"expense_place"];
        
        //初始化日期
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *expense_date =[formatter dateFromString:[record valueForKey:@"expense_date"]];
        dateCell.dateValue  =expense_date;
        
       formatter = [[NSDateFormatter alloc] init];
        formatter.timeStyle = NSDateFormatterNoStyle;
        formatter.dateStyle = NSDateFormatterMediumStyle;
        
        dateCell.detailTextLabel.text = [formatter stringFromDate:dateCell.dateValue];

        
        //初始化描述
        
        self.descTx.text =[record valueForKey:@"description"];
        
        
        //初始化相片
        if([record valueForKey:@"item1"] !=nil){
  
            [amountCell.img setImage:[UIImage imageWithData:[record valueForKey:@"item1"]]];
             }
        
        
    
    }else {
  
        [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:0 inComponent:0];
        [ExpenseTypePicker pickerView:expenseTypeCell.picker didSelectRow:0 inComponent:1];
        

        
    
 
        NSString *province = [EXPLocationAPI shareInstance].province;
        NSString *city = [EXPLocationAPI shareInstance].city;
        
        if(![province  isEqualToString:@""] && ![city isEqualToString:@""]){
            
            
            if (province == NULL || city == NULL) {
                [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:0];
                [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:1];
            }else{
            LocationPicker.province_desc = province;
            LocationPicker.city_desc = city;
            
            NSString *location = [NSString stringWithFormat:@"%@>%@",province,city];
            placeCell.detailTextLabel.text = location;
            placeCell.textLabel.text = @"地点";
            }
        }else{
            
            [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:0];
            [LocationPicker pickerView:placeCell.picker didSelectRow:0 inComponent:1];
            
        }
        
}
    
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
            amountCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return amountCell;
    }else if(indexPath.section == 1){
        expenseTypeCell= (LMTablePickerInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTablePickerInputCell"];
        if (expenseTypeCell == nil)
        {
            expenseTypeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
            
            expenseTypeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        ExpenseTypePicker.cell =expenseTypeCell;
        
        expenseTypeCell.picker.delegate = ExpenseTypePicker;
        expenseTypeCell.picker.dataSource = ExpenseTypePicker;
    
        
        expenseTypeCell.textLabel.text = @"费用";

        return expenseTypeCell;
        
    }else if(indexPath.section == 3){
        dateCell  = (LMTableDateInputCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (dateCell == nil)
        {
            dateCell = [[LMTableDateInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            dateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return dateCell;
        
    }else if(indexPath.section == 2){
        placeCell= (LMTablePickerInputCell *)[tableView dequeueReusableCellWithIdentifier:@"LMTablePickerInputCell"];
        if (placeCell == nil)
        {
            placeCell = [[LMTablePickerInputCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LMTablePickerInputCell"];
            placeCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        LocationPicker.cell =placeCell;
        placeCell.picker.delegate =LocationPicker;
        placeCell.picker.dataSource = LocationPicker;
        
        
    
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
            return 72;
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



#pragma  modeldelegate
-(void)modelDidStartLoad:(id<TTModel>)model{
        NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];
    
        if ([className isEqualToString:@"EXPLineDetailHtppModel"]){
            MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleDrop;
            [MMProgressHUD showWithTitle:nil status:@"upload"];
        }
}

-(void)modelDidFinishLoad:(id)model{
    NSString * className = [NSString stringWithUTF8String:object_getClassName(model)];

    if([className isEqualToString:@"EXPLineDetailModel"]){
        EXPLineDetailModel *_model = model;
        
        if([_model.method isEqualToString:@"insert"]){
            
            [self showUpload];
            

            insertFlag = NO;
            updateFlag = YES;
            self.keyId =  [_model getPrimaryKey:@"MOBILE_EXP_REPORT_LINE"];
            
            
        }else if([_model.method isEqualToString:@"update"]){
            
            
            
        }else if ([_model.method isEqualToString:@"query"]){
            
            record = [_model.result objectAtIndex:0];

            
        }
        
    }else if ([className isEqualToString:@"EXPLineDetailHtppModel"]){
        EXPLineDetailHtppModel *_model = model;
        
        NSDictionary * head = [_model.Json valueForKey:@"head"];
        NSDictionary * body = [_model.Json valueForKey:@"body"];
        NSString * result = [head valueForKey:@"code"];
        

   
        if([result isEqualToString:@"success"]){
            //如何需要上传照片
            if(shouldUploadImg){
                shouldUploadImg = NO;
                NSNumber * pkvalue = [body valueForKey:@"expense_detail_id"];
                NSString * source_type = @"hmb_expense_detail";
                NSDictionary * param = @{@"pkvalue" : pkvalue,
                                         @"source_type" : source_type
                                         
                                         };
                
                NSData *data = UIImageJPEGRepresentation(  [amountCell.img image],0.1);
                NSLog(@"datalength is %d",data.length);
                
                [_model upload:param fileName:@"upload.jpg" data:data];            

            }else if (!shouldUploadImg){
                //当不需要上传页面的时候，这个为最后的情况
                if(!completeFlag){
                    completeFlag = YES;
                }
                [self  save:nil];
                 MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleNone;
                [MMProgressHUD dismiss];
                [self back];
                
            }
            
        }else if([result isEqualToString:@"faild"]){
            
        
        }

        
    }
}
-(void)model:(id<TTModel>)model didFailLoadWithError:(NSError *)error{
    //处理超时异常
    NSLog(@"%d",error.code);
    if(error.code == 3840 || error.code == -1016){
    //todo 3804为接口返回数据不为json格式错误，现在默认情况认为返回这个错误就是成功
        if(!completeFlag) {
            completeFlag = YES;
        }
        [self  save:nil];
        MMProgressHUD.presentationStyle =MMProgressHUDPresentationStyleNone;
        [MMProgressHUD dismiss];
        [self back];
    } else{
        [MMProgressHUD dismiss];
        [LMAlertViewTool showAlertView:@"提示" message:@"网络出现问题，请检查网络后重新提交" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        
    }
}

#pragma keyboradDelegate

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

    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
	[self resignFirstResponder];
}

- (BOOL)resignFirstResponder {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

	return [super resignFirstResponder];
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 150.0)+100;//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    
    if(offset > 0 )
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);

    [UIView commitAnimations];
    
    
}



//输入框编辑完成以后，将视图恢复到原始状态
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

@end
