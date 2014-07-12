//
//  EXPHomeViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-7.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPHomeViewController.h"
#import "EXPHomeTable.h"
#import "EXPScrollview.h"
#import "EXPHeaderViewController.h"
#import "EXPDetailViewController.h"
#import  "EXPLineModelDetailViewController.h"


@interface EXPHomeViewController ()
{
    NSMutableArray *imageArray;
    EXPScrollview *_scrollview;
    int TimeNum;
}
@end

@implementation EXPHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageArray=[NSMutableArray arrayWithCapacity:1];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"首页";
    
    float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *backgroundImage = [UIImage imageNamed:@"navigationBg"];  //获取图片
    
    if(systemVersion>=5.0)
    {
        CGSize titleSize = self.navigationController.navigationBar.bounds.size;  //获取Navigation Bar的位置和大小
        backgroundImage = [self scaleToSize:backgroundImage size:titleSize];//设置图片的大小与Navigation Bar相同
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];  //设置背景
    }

    
    self.view.backgroundColor = [UIColor colorWithRed:0.875 green:0.871 blue:0.757 alpha:1.000];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIImage *checkList = [UIImage imageNamed:@"menu"];
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithImage:checkList style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Right"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self
//                                                                             action:@selector(presentRightMenuViewController:)];
    

    //Scroll views automatic
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    CGRect bound=CGRectMake(0, 0, 320, self.view.frame.size.height*0.3);
    NSArray *ImageArr=@[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"],[UIImage imageNamed:@"6"]];
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
    
    
    //TableView with 3 cells
    EXPHomeTable *expHomeTable = [[EXPHomeTable alloc]initWithFrame:CGRectMake(0.0, self.view.bounds.size.height*0.3, self.view.bounds.size.width, self.view.bounds.size.height*0.45)];
    
    expHomeTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:expHomeTable];
    
    
    //3 Buttons
    UIButton *expCreateButton = [[UIButton alloc]initWithFrame:CGRectMake(0.0, self.view.bounds.size.height*0.75, 100.0, self.view.bounds.size.height*0.25-55)];
    UIButton *expToDoButton = [[UIButton alloc]initWithFrame:CGRectMake(100.0, self.view.bounds.size.height*0.75, 120.0, self.view.bounds.size.height*0.25-55)];
    UIButton *expDoneButton = [[UIButton alloc]initWithFrame:CGRectMake(220.0, self.view.bounds.size.height*0.75, 100.0, self.view.bounds.size.height*0.25-55)];
    NSArray *imgButtonArray = @[[UIImage imageNamed:@"newEXP"],[UIImage imageNamed:@"toDoEXP"],[UIImage imageNamed:@"doneEXP"]];
    NSArray *titleButtonArray = @[@"报销创建",@"审批待办",@"审批完成"];
    
    [@[expCreateButton, expToDoButton, expDoneButton] enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        
        UIImage *expButtonImg = [imgButtonArray objectAtIndex:idx];
        [obj setImage:[imgButtonArray objectAtIndex:idx] forState:UIControlStateNormal];
        if (idx == 1) {
            obj.imageEdgeInsets = UIEdgeInsetsMake(-20.0, 45.0, 0.0, -obj.titleLabel.bounds.size.width);
        }else{
        obj.imageEdgeInsets = UIEdgeInsetsMake(-20.0, 37.0, 0.0, -obj.titleLabel.bounds.size.width);
        }
        [obj setTitle:[titleButtonArray objectAtIndex:idx] forState:UIControlStateNormal];
        obj.titleLabel.font = [UIFont systemFontOfSize:11];
        obj.titleLabel.textAlignment = NSTextAlignmentCenter;
        [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [obj setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        obj.titleEdgeInsets = UIEdgeInsetsMake(30, -expButtonImg.size.width, 0, 0.);
        
        obj.tag = idx;
        [obj addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:obj];
    }];
    

}

- (void)buttonClicked:(UIButton *)sender
{
    NSLog(@"button is clicked");
    
    UIButton *pushViewButton = sender;
    
    EXPLineModelDetailViewController *detailViewController = [[EXPLineModelDetailViewController alloc]initWithNibName:nil bundle:nil];
    
//    self.headerVIewController =   [[EXPHeaderViewController alloc] initWithNibName:Nil bundle:nil];
//UINavigationController *navigationController = [[UINavigationController alloc]init];
        switch (pushViewButton.tag) {
        case 0:
//                navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.235 green:0.627 blue:0.275 alpha:0.250];
//            
//           //     [navigationController pushViewController:self.headerVIewController animated:NO];
//                [navigationController pushViewController:detailViewController animated:NO];
//                [self presentViewController:navigationController animated:YES completion:NULL];
                
                [self.navigationController pushViewController:detailViewController animated:YES];
            break;
            
        default:
            break;
    }
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

@end
