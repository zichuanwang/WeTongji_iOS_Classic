//
//  UserInfoTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"
#import "MetroViewController.h"

@interface UserInfoTableViewController ()

@end

@implementation UserInfoTableViewController

@synthesize tableView = _tableView;
@synthesize dataSourceIndexArray = _dataSourceIndexArray;
@synthesize dataSourceDictionary = _dataSourceDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSourceIndexArray = [NSMutableArray arrayWithObjects:[NSString stringWithString:@"基本资料"], [NSString stringWithString:@"专业资料"], [NSString stringWithString:@"社交资料"], nil];
        
        NSArray *basic = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:[NSString stringWithString:@"姓名"], [NSString stringWithString:@"王紫川"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"性别"], [NSString stringWithString:@"男"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"生日"], [NSString stringWithString:@"1990年 6月 24日"], nil], nil];
        
        NSArray *major = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:[NSString stringWithString:@"年级"], [NSString stringWithString:@"三"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"班级"], [NSString stringWithString:@"7"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"学院"], [NSString stringWithString:@"软件学院"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"专业"], [NSString stringWithString:@"软件工程"], nil], nil];
        
        NSArray *social = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:[NSString stringWithString:@"手机"], [NSString stringWithString:@"15216719574"], nil],
                          [NSArray arrayWithObjects:[NSString stringWithString:@"Email"], [NSString stringWithString:@"wzc345@gmail.com"], nil], nil];
        
        self.dataSourceDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [self.dataSourceDictionary setValue:basic forKey:[self.dataSourceIndexArray objectAtIndex:0]];
        [self.dataSourceDictionary setValue:major forKey:[self.dataSourceIndexArray objectAtIndex:1]];
        [self.dataSourceDictionary setValue:social forKey:[self.dataSourceIndexArray objectAtIndex:2]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,  DOCK_VIEW_HEIGHT + 20)];
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
    NSString *key = [self.dataSourceIndexArray objectAtIndex:section];
    NSArray *value = [self.dataSourceDictionary valueForKey:key];
    return value.count;
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
    [self configureCell:userInfoCell atIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceIndexArray.count;
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_header.png"]];
    headerImageView.frame = CGRectMake(0, 21, 320, 40);
    
    NSString *title = [self.dataSourceIndexArray objectAtIndex:section];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 300, 45)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    titleLabel.text = title;
    
    [headerView addSubview:titleLabel];
    [headerView addSubview:headerImageView];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_footer.png"]];
    footerImageView.frame = CGRectMake(0, 0, 320, 40);
    
    [footerView addSubview:footerImageView];
    return footerView;
}

#pragma mark -
#pragma mark Data management

- (void)configureCell:(UserInfoTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSArray *data = [value objectAtIndex:indexPath.row];
    
    cell.categoryLabel.text = [data objectAtIndex:0];
    cell.contentLabel.text = [data objectAtIndex:1];
}


@end
