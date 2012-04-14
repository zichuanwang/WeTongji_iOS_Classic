//
//  WTMainTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WTMainTableViewController.h"

@interface WTMainTableViewController ()

@end

@implementation WTMainTableViewController

@synthesize tableView = _tableView;
@synthesize dataSourceIndexArray = _dataSourceIndexArray;
@synthesize dataSourceDictionary = _dataSourceDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSourceIndexArray = [NSMutableArray arrayWithCapacity:10];
        self.dataSourceDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
        [self configureDataSource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView = nil;
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.dataSourceIndexArray objectAtIndex:section];
    NSArray *value = [self.dataSourceDictionary valueForKey:key];
    return value.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceIndexArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [self customCellClassName];
    
    NSString *CellIdentifier = name ? name : @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (name) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:[self customCellClassName] owner:self options:nil];
            cell = [nib lastObject];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
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
#pragma mark Methods to overwrite

- (NSString *)customCellClassName
{
    return nil;
}

- (void)configureDataSource {
    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
