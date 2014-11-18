//
//  EXPChartViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-16.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPChartViewController.h"
#import "PieChartView.h"
#import "EXPChartModel.h"
#import "EXPLineModelDetailViewController.h"
#import "EXPdetailAmount.h"
#import "EXPDateManager.h"
#import "EXPdateSwitchView.h"

#define PIE_HEIGHT 280
@interface EXPChartViewController ()<EXPdateSwitchViewDelegate>



@property (nonatomic) BOOL sumIsNull;
@property (nonatomic, strong) EXPdateSwitchView *dateSwitchView;
@property (nonatomic, strong) EXPdetailAmount *detailAmount;
@property (nonatomic, strong) NSMutableArray *detailAmountArray;
@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSString *year;
@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIImageView *noDataImageView;
@property (nonatomic, strong) UIImageView *selView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic,strong) NSMutableArray *classArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) NSMutableArray *sumArray;
@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSString *amountCount;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) UILabel *selLabel;
@property (nonatomic,strong) UIView *pieContainer;


@end


@implementation EXPChartViewController

@synthesize selView = selView;



- (NSString *)year
{
    if (!_year) {
        NSString *nowDate = [[[EXPDateManager alloc]init] getToday];
        NSArray *nowDateInfo = [nowDate componentsSeparatedByString:@"-"];
        
        _year = [nowDateInfo objectAtIndex:0];
    }
    
    return _year;
}

- (NSString *)month
{
    if (!_month) {
        NSString *nowDate = [[[EXPDateManager alloc] init] getToday];
        NSArray *nowDateInfo = [nowDate componentsSeparatedByString:@"-"];
        
        _month = [nowDateInfo objectAtIndex:1];
    }
    
    return _month;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.model = [[EXPChartModel alloc]init];

    }
    return self;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [self.alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Ok"]){
        NSLog(@"User pressed the Yes button.");
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if ([buttonTitle isEqualToString:@"Cancel"]){
        NSLog(@"User pressed the No button.");
        
        
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }


	// Do any additional setup after loading the view.
    CGRect pieFrame = CGRectMake((self.view.frame.size.width - PIE_HEIGHT) / 2, self.view.frame.size.height*0.1, PIE_HEIGHT, PIE_HEIGHT);
    
    self.pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    if (self.sumIsNull) {

        self.noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(73.0, (self.view.bounds.size.height-64)/2-85, 174.0, 170.0)];
        [self.noDataImageView setImage:[UIImage imageNamed: @"noDate"]];
        
        [self.view addSubview:self.noDataImageView];
        
    }else{
        self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
        self.pieChartView.delegate = self;
        [self.pieContainer addSubview:self.pieChartView];
        
        
        
        [self.view addSubview:self.pieContainer];
        selView = [[UIImageView alloc]init];
        selView.image = [UIImage imageNamed:@"select.png"];
        selView.frame = CGRectMake((self.view.frame.size.width - selView.image.size.width/2)/2, self.pieContainer.frame.origin.y + self.pieContainer.frame.size.height, selView.image.size.width/2, selView.image.size.height/2);
        [self.view addSubview:selView];
        
        self.selLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, selView.image.size.width/2, 21)];
        self.selLabel.backgroundColor = [UIColor clearColor];
        self.selLabel.textAlignment = NSTextAlignmentCenter;
        self.selLabel.font = [UIFont systemFontOfSize:17];
        self.selLabel.textColor = [UIColor whiteColor];
        [selView addSubview:self.selLabel];
        [self.pieChartView setTitleText:@"总计"];
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%@ 年 %@ 月", self.year ,self.month];
    self.dateSwitchView = [[EXPdateSwitchView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 40.0) Date:dateString Color: [self randomColor]];
    self.dateSwitchView.delegate = self;
    [self.view addSubview:self.dateSwitchView];

    self.title = @"报销图表";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor colorWithRed:0.800 green:0.812 blue:0.680 alpha:1.000];
    
}

- (void)preDateButtonClicked:(EXPdateSwitchView *)dateSwitchView
{
    if ([_month isEqualToString:@"01"]) {
        _month = @"12";
        _year = [NSString stringWithFormat:@"%d",([_year intValue] - 1)];
    }else{
        _month = [NSString stringWithFormat:@"%.2d", ([_month intValue] - 1) ];
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%@ 年 %@ 月",_year,_month];
    [self.dateSwitchView  setDateLabelText:dateString];;
    
    [self reload];
    [self.pieChartView removeFromSuperview];
    
    if (self.sumIsNull) {
        [self.noDataImageView removeFromSuperview];

        self.selLabel.text = @"";
        selView.hidden = YES;
        
        self.noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(73.0, self.view.bounds.size.height/2-85, 174.0, 170.0)];
        [self.noDataImageView setImage:[UIImage imageNamed: @"noDate"]];
        
        [self.view addSubview:self.noDataImageView];
        
    }else{
        [self.noDataImageView removeFromSuperview];
        selView.hidden = NO;
        self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
        self.pieChartView.delegate = self;
        [self.pieChartView setTitleText:@"总计"];
        [self.pieContainer addSubview:self.pieChartView];
        [self.view addSubview:self.pieContainer];
    }
    [self viewDidAppear:YES];
}

- (void)nextDateButtonClicked:(EXPdateSwitchView *)dateSwitchView
{
    
    if ([_month isEqualToString:@"12"]) {
        _month = @"01";
        _year = [NSString stringWithFormat:@"%d",([_year intValue] + 1)];
    }else{
        _month = [NSString stringWithFormat:@"%.2d", ([_month intValue] + 1) ];
    }
    
    NSString *dateString = [NSString stringWithFormat:@"%@ 年 %@ 月",_year,_month];
    [self.dateSwitchView setDateLabelText:dateString];
    [self reload];
    [self.pieChartView removeFromSuperview];
    
    if (self.sumIsNull) {
        [self.noDataImageView removeFromSuperview];
        
        self.selLabel.text = @"";
        selView.hidden = YES;
        
        self.noDataImageView = [[UIImageView alloc]initWithFrame:CGRectMake(73.0, self.view.bounds.size.height/2-85, 174.0, 170.0)];
        [self.noDataImageView setImage:[UIImage imageNamed: @"noDate"]];
        
        [self.view addSubview:self.noDataImageView];
    }else{
        [self.noDataImageView removeFromSuperview];

        selView.hidden = NO;
    self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
    self.pieChartView.delegate = self;
    [self.pieChartView setTitleText:@"总计"];
    [self.pieContainer addSubview:self.pieChartView];
    [self.view addSubview:self.pieContainer];
    }
    
    [self viewDidAppear:YES];
}

- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    
    NSLog(@"%@",[self.valueArray objectAtIndex:index]);
    
    NSString *classString = [NSString stringWithString:[self.classArray objectAtIndex:index]];
    NSString *sumString = [NSString stringWithFormat:@"%@",[self.sumArray objectAtIndex:index]];
    self.selLabel.text = [NSString stringWithFormat:@"%@(¥%@) %2.2f%@",classString,sumString,per*100,@"%"];
   [self.pieChartView setAmountText:self.amountCount];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self.pieChartView reloadChart];
}

-(void)modelDidFinishLoad:(FMDataBaseModel *)model{
    
    float sumAmount = 0;
    float monthAmountSum = 0;
    FMDataBaseModel *myModel = model;
    self.valueArray = [[NSMutableArray alloc]init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.classArray = [[NSMutableArray alloc] init];
    self.sumArray = [[NSMutableArray alloc]init]; 
    self.amountCount = nil;
    NSMutableSet *descSet = [[NSMutableSet alloc]init];
        self.detailAmountArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *record in myModel.result) {
        NSArray *amountInfo = [[record valueForKey:@"expense_date"] componentsSeparatedByString:@"-"];
        self.detailAmount = nil;
        float amount = [[record valueForKey:@"expense_amount"] floatValue]
        * [[record valueForKey:@"expense_number"] floatValue];
        ;
        self.detailAmount = [[EXPdetailAmount alloc]initWithYear:amountInfo[0] Month:amountInfo[1] SumAmount:amount Type:[record valueForKey:@"expense_class_desc"]];
        [self.detailAmountArray addObject:self.detailAmount];
        
        [descSet addObject:[record valueForKey:@"expense_class_desc"]];
    }
    
    for (EXPdetailAmount *temp in self.detailAmountArray) {
        sumAmount = sumAmount + [temp getSumAmountWithYear:self.year Month:self.month];
    }
    
    self.sumIsNull = NO;
    
        if (sumAmount == 0) {
            self.sumIsNull = YES;
        }
    self.amountCount = [NSString stringWithFormat:@"%2.2f",sumAmount];
    
    for (NSString *desc in descSet) {
        monthAmountSum = 0;
        for (EXPdetailAmount *temp in self.detailAmountArray) {
            monthAmountSum =  monthAmountSum + [temp getSumAmountWithYear:self.year Month:self.month Type:desc];
        }
        
        NSNumber *sumMoney =[NSNumber numberWithFloat:monthAmountSum];
        [self.valueArray addObject:sumMoney];
        [self.colorArray addObject:[self randomColor]];
        [self.classArray addObject:desc];
        [self.sumArray addObject:sumMoney];
    }
     
     [super modelDidFinishLoad:model];
}


- (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.8];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
