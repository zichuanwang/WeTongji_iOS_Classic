//
//  UserInfoTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewController ()

@end

@implementation UserInfoTableViewController

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.tableView = nil;
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    NSString *cellIdentifier = @"UserInfoTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UserInfoTableViewCell *userInfoCell = (UserInfoTableViewCell *)cell;
    if(indexPath.row == 0) {
        userInfoCell.bgImageView.image = [UIImage imageNamed:@"paper_header.png"];
    }
    else if(indexPath.row == 4) {
        userInfoCell.bgImageView.image = [UIImage imageNamed:@"paper_footer.png"];
    }
    else {
        userInfoCell.bgImageView.image = [UIImage imageNamed:@"paper_main.png"];
    }
    
    if(indexPath.row == 1) {
        userInfoCell.categoryLabel.text = @"姓名";
        userInfoCell.contentLabel.text = @"王紫川";
    }
    else if(indexPath.row == 2) {
        userInfoCell.categoryLabel.text = @"性别";
        userInfoCell.contentLabel.text = @"男";
    }
    else if(indexPath.row == 3) {
        userInfoCell.categoryLabel.text = @"生日";
        userInfoCell.contentLabel.text = @"1990年 6月 24日";
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableView delegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}

@end
