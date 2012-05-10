//
//  SettingUIStyleViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingUIStyleViewController.h"
#import "SettingUIStyleTableViewCell.h"
#import "NSUserDefaults+Addition.h"
#import "NSNotificationCenter+Addition.h"

@interface SettingUIStyleViewController ()

@end

@implementation SettingUIStyleViewController

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
    [self configureNavBar];
    [self configureTableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"界面风格"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureTableView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    UIView *footerView = [[UIView alloc] initWithFrame:headerView.frame];
    footerView.backgroundColor = [UIColor clearColor];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_header.png"]];
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_single_line.png"]];
    headerImageView.center = CGPointMake(150, 10);
    lineImageView.center = headerImageView.center;
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_footer.png"]];
    footerImageView.center = CGPointMake(150, 20);
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    [footerView addSubview:footerImageView];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = footerView;
    
    _selectRow = [NSUserDefaults getCurrentUIStyle];
}

- (void)configureCell:(SettingUIStyleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        cell.titleLable.text = @"黑巧克力";
    } else {
        cell.titleLable.text = @"白巧克力";
    }
    if(_selectRow == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"SettingUIStyleTableViewCell";
    
    SettingUIStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib lastObject];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectRow = indexPath.row;
    UIStyle formerStyle = [NSUserDefaults getCurrentUIStyle];
    if(_selectRow != formerStyle) {
        [NSUserDefaults setCurrentUIStyle:_selectRow];
        [NSNotificationCenter postChangeCurrentUIStyleNotification:_selectRow];
        [self.tableView reloadData];
    }
}


@end
