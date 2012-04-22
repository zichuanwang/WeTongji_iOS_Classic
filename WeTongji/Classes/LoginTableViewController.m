//
//  LoginTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginTableViewController.h"
#import "LoginTableViewCell.h"
#import "LoginViewController.h"
#import "UIApplication+Addition.h"

#define TABLE_HEADER_FOOTER_CELL_NUM    5

@interface LoginTableViewController ()

@property (nonatomic, strong) NSMutableArray *userListArray;
@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UIView *tableViewFooterView;

@end

@implementation LoginTableViewController

@synthesize tableView = _tableView;
@synthesize userListArray = _userListArray;
@synthesize tableViewFooterView = _tableViewFooterView;
@synthesize tableViewHeaderView = _tableViewHeaderView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userListArray = [[NSMutableArray alloc] initWithCapacity:10];
        //[self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        //[self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        //[self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
        [self.userListArray addObject:[NSString stringWithFormat:@"王紫川"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib. 
    self.tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, -40 * TABLE_HEADER_FOOTER_CELL_NUM, 320, 40 * TABLE_HEADER_FOOTER_CELL_NUM)];
    self.tableViewFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, [self numberOfRowsInTableView] * 40, 320, 40 * TABLE_HEADER_FOOTER_CELL_NUM)];
    for(int i = 0; i < TABLE_HEADER_FOOTER_CELL_NUM; i++) {
        UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_info_line.png"]];
        UIImageView *footerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_info_line.png"]];
        headerView.frame = CGRectMake(-10, 40 * i, 320, 40);
        footerView.frame = headerView.frame;
        [self.tableViewHeaderView addSubview:headerView];
        [self.tableViewFooterView addSubview:footerView];
    }
    [self.tableView addSubview:self.tableViewHeaderView];
    [self.tableView addSubview:self.tableViewFooterView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (NSInteger)numberOfRowsInTableView {
    NSInteger count = self.userListArray.count + 1;
    return count >= 3 ? count : 3;
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self numberOfRowsInTableView];
}

#pragma mark -
#pragma mark WTTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"LoginTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == _selectRow) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    LoginTableViewCell *loginCell = (LoginTableViewCell *)cell;
    if(indexPath.row < self.userListArray.count) {
        loginCell.userNameLabel.text = [self.userListArray objectAtIndex:indexPath.row];
        loginCell.avatarImageView.hidden = NO;
        loginCell.avatarImageView.image = [UIImage imageNamed:@"user_info_default_image.jpg"];
    }
    else if(indexPath.row == self.userListArray.count) {
        loginCell.avatarImageView.hidden = NO;
        loginCell.avatarImageView.image = nil;
        loginCell.userNameLabel.text = @"添加一个新的账户";
    }
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < self.userListArray.count) {
        _selectRow = indexPath.row;
        [self.tableView reloadData];
    }
    else if(indexPath.row == self.userListArray.count) {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [[UIApplication sharedApplication] presentModalViewController:vc];
    }
}

@end
