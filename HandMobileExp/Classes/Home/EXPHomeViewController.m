//
//  EXPHomeViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-7.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPHomeViewController.h"
//#import "EXPHomeTable.h"
#import "EXPScrollview.h"
#import "EXPDetailViewController.h"
#import  "EXPLineModelDetailViewController.h"
#import  "EXPSubmitDetailViewController.h"
#import "EXPChartViewController.h"
#import "EXPDateManager.h"

#import "EXPHomeModel.h"
#import  "EXPBuildWebView.h"
#import  "UINavigationController+SafePushing.h"

@interface EXPHomeViewController ()
{
    NSMutableArray *imageArray;
    EXPScrollview *_scrollview;
    int TimeNum;
    
    BOOL animating;
}
@property (nonatomic ,strong) NSString *weekSum;

@property (nonatomic ,strong) NSString *monthSum;

@property (nonatomic ,strong) NSString *todaySum;
@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *tableViewCellIdentifier = @"MyCells";

@implementation EXPHomeViewController

@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArray=[NSMutableArray arrayWithCapacity:1];
        
        
        
    //    self.model = [[EXPHomeModel alloc]init];
        
    }
    return self;
}

- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 5 == 0 && TimeNum != 0) {
        int page = _scrollview.pagecontrol.currentPage; // 获取当前的page
        page++;
        page = page > 5 ? 0 : page ;
        _scrollview.pagecontrol.currentPage = page;
        [self turnPage];
    }
    TimeNum ++;
}

- (void)turnPage
{
    int page = _scrollview.pagecontrol.currentPage; // 获取当前的page
    [_scrollview scrollRectToVisible:CGRectMake(320*(page+1),0,320,460) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
    
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void) abstractButtonClicked:(id)sender
{
    NSLog(@"记一笔");
        EXPLineModelDetailViewController *detailViewController = [[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil];
    detailViewController.detailList = self;
    detailViewController.tableView = tableView;
 
     [self.navigationController pushViewController:detailViewController animated:YES];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    self.title = @"首页";
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;


    self.model = [[EXPHomeModel alloc]init];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {        // Load
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:29.0f/255.0f green:92.0f/255.0f blue:145.0f/255 alpha:1];
    }
    else {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:29.0f/255.0f green:92.0f/255.0f blue:145.0f/255 alpha:1];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
//    self.view.backgroundColor = [UIColor colorWithRed:0.875 green:0.871 blue:0.757 alpha:1.000];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *checkList = [UIImage imageNamed:@"menu"];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:checkList style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    

    //Scroll views automatic
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    CGRect bound=CGRectMake(0, 0, self.view.bounds.size.width, self.view.frame.size.height*0.25);
    NSArray *ImageArr=@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"]];
    for (int i=0; i<ImageArr.count; i++) {
        UIImageView *imageview=[[UIImageView alloc]init];
        imageview.image=[ImageArr objectAtIndex:i];
        imageview.contentMode=UIViewContentModeScaleToFill;

        [imageArray addObject:imageview];
    }
    
    _scrollview=[[EXPScrollview alloc]initLoopScrollWithFrame:bound withImageView:imageArray];
    _scrollview.delegate=self;
    [self.view addSubview:_scrollview];
    _scrollview.pagecontrol.frame=CGRectMake(0, _scrollview.pagecontrol.frame.origin.y+_scrollview.frame.size.height-10, 320, 10);
    _scrollview.pagecontrol.currentcolor=[UIColor whiteColor];
    _scrollview.pagecontrol.othercolor=[UIColor colorWithWhite:0.000 alpha:0.200];
    _scrollview.pagecontrol.currentPage=0;
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    
    [self.view addSubview:_scrollview.pagecontrol];
    
    UIButton *writeButton = [[UIButton alloc]initWithFrame:CGRectMake(16.0, self.view.bounds.size.height * 0.29, self.view.bounds.size.width-32.0, self.view.bounds.size.height * 0.09)];
    

    writeButton.backgroundColor = [UIColor colorWithRed:241.0f/255.0f green:147.0f/255.0f blue:31.0f/255.0f alpha:0.780];

    [writeButton setTitle:@"记一单" forState:UIControlStateNormal];
    writeButton.titleLabel.textColor = [UIColor whiteColor];
    writeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
    writeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
   [writeButton.layer setCornerRadius:8.0f];
    writeButton.showsTouchWhenHighlighted = YES;
    [writeButton addTarget:self action:@selector(abstractButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:writeButton];
    
    
    //TableView with 3 cells
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(8.0, self.view.bounds.size.height*0.4, self.view.bounds.size.width-16.0, self.view.bounds.size.height*0.3) style:UITableViewStylePlain];
    
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.backgroundView = nil;
    tableView.contentSize = CGSizeMake(tableView.frame.size.width, tableView.frame.size.height);
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellIdentifier];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.scrollEnabled = NO;
//    tableView.allowsSelection = NO;
    
    [self.view addSubview:tableView];
    
    UIView * backview = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.view.bounds.size.height*0.75, self.view.bounds.size.width, self.view.bounds.size.height*0.25)];
    [backview setBackgroundColor:[UIColor colorWithRed:29.0f/255.0f green:92.0f/255.0f blue:145.0f/255 alpha:1]];
    [self.view addSubview: backview];
    
    //3 Buttons
    UIButton *expCreateButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.75, self.view.bounds.size.width/4 *1, self.view.bounds.size.height*0.25-55)];
    UIButton *expToDoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/4 *1, self.view.bounds.size.height*0.75, self.view.bounds.size.width/4 *1, self.view.bounds.size.height*0.25-55)];
    UIButton *expDoneButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/4 *2, self.view.bounds.size.height*0.75, self.view.bounds.size.width/4 *1, self.view.bounds.size.height*0.25-55)];
    
    UIButton *buildExpButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/4 *3, self.view.bounds.size.height*0.75, self.view.bounds.size.width/4 *1, self.view.bounds.size.height*0.25-55)];
    
    NSArray *imgButtonArray = @[[UIImage imageNamed:@"newEXP"],[UIImage imageNamed:@"chart"],[UIImage imageNamed:@"doneEXP"],[UIImage imageNamed:@"buildExp"]];
    NSArray *titleButtonArray = @[@"报销明细",@"报销图表",@"批量上传",@"生成单据"];
    
    
    
    [@[expCreateButton, expToDoButton, expDoneButton,buildExpButton] enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        
        UIImage *expButtonImg = [imgButtonArray objectAtIndex:idx];
        [obj setImage:[imgButtonArray objectAtIndex:idx] forState:UIControlStateNormal];
 
        if (idx == 1) {
            obj.imageEdgeInsets = UIEdgeInsetsMake(-20.0, 23.0, 0.0, -obj.titleLabel.bounds.size.width);
        }else{
        obj.imageEdgeInsets = UIEdgeInsetsMake(-20.0, 23.0, 0.0, -obj.titleLabel.bounds.size.width);
        }
        [obj setTitle:[titleButtonArray objectAtIndex:idx] forState:UIControlStateNormal];
        obj.titleLabel.font = [UIFont systemFontOfSize:11];
        obj.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [obj setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        obj.titleEdgeInsets = UIEdgeInsetsMake(30, -expButtonImg.size.width, 0, 0.);
        
        obj.tag = idx;
        [obj addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obj];
    }];
    

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    animating = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)buttonClicked:(UIButton *)sender
{
    NSLog(@"button is clicked");
    
    UIButton *pushViewButton = sender;
    
    
    if (pushViewButton.tag == 0) {
        EXPDetailViewController *detailViewController = [[EXPDetailViewController alloc]initWithNibName:nil bundle:nil];
        detailViewController.homeList = self;
        detailViewController.tv = self.tableView;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    
    if (pushViewButton.tag == 1) {
        EXPChartViewController *chartViewController = [[EXPChartViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:chartViewController animated:YES];
    }
    if (pushViewButton.tag == 2) {
        EXPSubmitDetailViewController * submitController =
        [[EXPSubmitDetailViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:submitController animated:YES];
    }
    if (pushViewButton.tag == 3){
        NSString *address = [[NSUserDefaults standardUserDefaults] objectForKey:@"base_url_preference"];
       NSString * url=  [[EXPApplicationContext shareObject] keyforUrl:@"build_exp_url" ];
        
        
      EXPBuildWebView * web=  [[EXPBuildWebView alloc] initWithUrl:[address stringByAppendingString:url] title:pushViewButton.titleLabel.text];
        [self.navigationController pushViewController:web animated:YES];
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewCellIdentifier];
    
//    cell = [tableView
//            dequeueReusableCellWithIdentifier:tableViewCellIdentifier
//            forIndexPath:indexPath];
    
    
    cell.backgroundView.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor colorWithRed:0.876 green:0.874 blue:0.760 alpha:0.310];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section ==0 && indexPath.row == 0) {
        cell.textLabel.text = @"今天：";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0f];
        cell.detailTextLabel.text = self.todaySum;
        [cell.imageView setImage:[UIImage imageNamed:@"today"]];
    }
    if (indexPath.section ==0 && indexPath.row == 1) {
        
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"本周：";
        
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0f];
        cell.detailTextLabel.text = self.weekSum;
        [cell.imageView setImage:[UIImage imageNamed:@"week"]];
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"本月：";
        
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0f];
        cell.detailTextLabel.text = self.monthSum;
        [cell.imageView setImage:[UIImage imageNamed:@"month"]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (self.view.bounds.size.height+64)*0.1;
}

/////////////////////////解决动画切换死掉的bug




#pragma delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@" have clicked %d",indexPath.row);
//    if()
    
    
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    [_scrollview EXPscrollViewDidScroll];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    [_scrollview EXPscrollViewDidEndDecelerating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)modelDidFinishLoad:(FMDataBaseModel *)model{
    
    [super modelDidFinishLoad:model];
    NSString *weekDate = [NSString stringWithString:[[[EXPDateManager alloc]init] getFirstDayOfThisWeek]];
    NSString *monthDate = [NSString stringWithString:[[[EXPDateManager alloc]init] getFirstDayOfThisMonth]];
    NSString *todayDate = [NSString stringWithString:[[[EXPDateManager alloc]init] getToday]];
    
    NSString * lastDayOfMonth =[NSString stringWithString:[[[EXPDateManager alloc]init] getLastDayOfThisMonth]];
    NSString * lastDayOfWeek = [NSString stringWithString:[[[EXPDateManager alloc]init] getLastDayOfThisWeek]];
    
    float weekSumInt = 0;
    float monthSumInt = 0;
    float todaySumInt = 0;
    
    for (  NSDictionary * record in  model.result){
        
        if ([weekDate compare:[record objectForKey:@"expense_date"]] <= 0 && [lastDayOfWeek compare:[record objectForKey:@"expense_date"]] >=0) {
            
          //  NSLog(@"%d",[weekDate compare:[record objectForKey:@"expense_date"]]);
            weekSumInt = weekSumInt +[[record objectForKey:@"expense_amount"]floatValue]
            *[[record objectForKey:@"expense_number"] integerValue]
            ;
            
            
        }
        if ([monthDate compare:[record objectForKey:@"expense_date"]] <= 0 && [lastDayOfMonth compare:[record objectForKey:@"expense_date"]] >=0) {
           // NSLog(@"%d",[monthDate compare:[record objectForKey:@"expense_date"]]);
            monthSumInt = monthSumInt +[[record objectForKey:@"expense_amount"]floatValue]
            *[[record objectForKey:@"expense_number"] integerValue];
            
            
        }
        if ([todayDate isEqualToString:[record objectForKey:@"expense_date"]]) {
            todaySumInt = todaySumInt + [[record objectForKey:@"expense_amount"]floatValue]
            *[[record objectForKey:@"expense_number"] integerValue];
        }
        
    }
    self.weekSum = [NSString stringWithFormat:@"%2.2f",weekSumInt];
    self.monthSum = [NSString stringWithFormat:@"%2.2f",monthSumInt];
    self.todaySum = [NSString stringWithFormat:@"%2.2f",todaySumInt];
    
    
}

@end
