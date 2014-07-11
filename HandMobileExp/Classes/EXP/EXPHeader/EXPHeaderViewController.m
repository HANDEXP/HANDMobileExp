 //
//  EXPHeaderViewController.m
//  HandMobileExp
//
//  Created by Tracy－jun on 14-7-9.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPHeaderViewController.h"
#import "EXPLineCell.h"

@interface EXPHeaderViewController ()

@end

static NSString *CellIdentifier = @"EXPLineCell";

@implementation EXPHeaderViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
 //   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 150.0, self.view.bounds.size.width, self.view.bounds.size.height-300.0)];

    
    self.title = @"报销创建";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(returnHomePage:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDetailPage:)];
    
    
 //   [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    //[self setExtraCellLineHidden:self.tableView];
    
}

- (void)addDetailPage:(id *)sender
{
    
}

- (void)returnHomePage:(id *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  EXPLineCell *cell = [tableView registerNib:[UINib nibWithNibName:@"EXPLineCell" bundle:Nil] forCellReuseIdentifier:CellIdentifier];
  
    
    EXPLineCell *cell = (EXPLineCell *)[tableView dequeueReusableCellWithIdentifier:@"EXPLineCell"];
    
    if (cell == nil) {
        
        
        cell = [[EXPLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EXPLineCell"];
        
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.firstLabel.text = @"总金额";
        cell.secondLabel.text = @"$100,000,000";
    }
    
        return cell;
    
    

    // Configure the cell...
    
    return cell;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (YES)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"MM/dd/YY HH:mm:ss"];
        
        NSString *timestamp = [formatter stringFromDate:[NSDate date]];
        
        NSLog(@"%@",timestamp);
        return [self newLabelWithTitle:timestamp];
    }
    return nil;
}

- (UILabel *) newLabelWithTitle:(NSString *)paramTitle
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = paramTitle;
    label.textColor = [UIColor colorWithRed:1.000 green:0.984 blue:0.767 alpha:1.000];
    label.backgroundColor = [UIColor colorWithRed:0.037 green:0.039 blue:0.020 alpha:0.220];
    [label sizeToFit];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
