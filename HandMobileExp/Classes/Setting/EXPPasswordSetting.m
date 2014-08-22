//
//  EXPPasswordSetting.m
//  HandMobileExp
//
//  Created by jiangtiteng on 14-8-20.
//  Copyright (c) 2014年 hand. All rights reserved.
//

#import "EXPPasswordSetting.h"
#import "EXPUnlockSettingViewController.h"

@interface EXPPasswordSetting ()

@end

@implementation EXPPasswordSetting

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString * flag =  [[NSUserDefaults standardUserDefaults] valueForKey:@"gestureFlag"];
    
    if(flag == nil || [flag isEqualToString:@"NO"]){
            [self.gestureFlag setOn:NO];
    }else if([flag isEqualToString:@"YES"]){
            [self.gestureFlag setOn:YES];
    }

    [self.gestureFlag addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [[UIView alloc]init];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma uiswitch delegate
-(void)switchIsChanged:(UISwitch *)paramsender{
    if([paramsender isOn]){
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"gestureFlag"];
        NSLog(@"is on");
    }else{
        
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"gestureFlag"];

        
        NSLog(@"is off");
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if(section == 0){
    
        return 2;
        
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 1){
                [self.navigationController pushViewController:[[EXPUnlockSettingViewController alloc] initWithNibName:nil bundle:nil] animated:YES];
        }
        
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
