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

#define PIE_HEIGHT 280
@interface EXPChartViewController ()


@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) NSString *amountCount;
@property (nonatomic,strong) NSMutableArray *classArray;
@property (nonatomic,strong) UILabel *selLabel;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic,strong) NSMutableArray *sumArray;
@property (nonatomic) BOOL sumIsNull;

@property (nonatomic, strong) UIAlertView *alertView;

@end


@implementation EXPChartViewController


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
        self.alertView = [[UIAlertView alloc]
                                  initWithTitle:@""
                            
                                
                                  message:@"亲，你还没有记录任何数据哦，去记一单吧？"
                                  delegate:nil
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Ok", nil];
        self.alertView.delegate = self;
        [self.alertView show];
        
    }else{
        self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
        self.pieChartView.delegate = self;
        [self.pieContainer addSubview:self.pieChartView];
        
        
        [self.pieChartView setAmountText:self.amountCount];
        [self.view addSubview:self.pieContainer];
        UIImageView *selView = [[UIImageView alloc]init];
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
    
    

    self.title = @"报销图表";
    self.view.backgroundColor = [UIColor colorWithRed:0.800 green:0.812 blue:0.680 alpha:1.000];
    
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
   
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [self.pieChartView reloadChart];
}

#pragma LMModelDelegate
-(void)modelDidFinishLoad:(FMDataBaseModel *)model{
    NSLog(@"hello");
    float sumAmount = 0;
    FMDataBaseModel *myModel = model;
    self.valueArray = [[NSMutableArray alloc]init];
    self.colorArray = [[NSMutableArray alloc] init];
    self.classArray = [[NSMutableArray alloc] init];
    self.sumArray = [[NSMutableArray alloc]init];
    self.sumIsNull = NO;
    
    for (NSDictionary *record in myModel.result) {
        sumAmount =sumAmount + [[record valueForKey:@"sum"]floatValue];
    }
    NSLog(@"%f",sumAmount);
    if (sumAmount == 0) {
        self.sumIsNull = YES;
    }
    
    self.amountCount = [NSString stringWithFormat:@"%2.2f",sumAmount];
    
    for (NSDictionary *record in myModel.result) {
        NSNumber *sumMoney =[NSNumber numberWithFloat:[[record valueForKey:@"sum"]floatValue]];
        NSString *classDesc = [record valueForKey:@"expense_class_desc"];
        
        [self.valueArray addObject:sumMoney];
        [self.colorArray addObject:[self randomColor]];
        [self.classArray addObject:classDesc];
        [self.sumArray addObject:[record valueForKey:@"sum"]];
        
        
    };
    
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
