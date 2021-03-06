//
//  WTGroupTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTGroupTableViewController.h"
#import "NSUserDefaults+Addition.h"
#import "NSNotificationCenter+Addition.h"

@interface WTGroupTableViewController ()

@end

@implementation WTGroupTableViewController

@synthesize dataSourceIndexArray = _dataSourceIndexArray;
@synthesize dataSourceDictionary = _dataSourceDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSourceIndexArray = [NSMutableArray arrayWithCapacity:10];
        self.dataSourceDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self configureDataSource];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter registerChangeCurrentUIStyleNotificationWithSelector:@selector(handleChangeCurrentUIStyleNotification:) target:self];
    
    [self handleChangeCurrentUIStyleNotification:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_header.png"]];
    headerImageView.frame = CGRectMake(0, 16, 320, 40);
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_single_line.png"]];
    lineImageView.frame = headerImageView.frame;
    
    NSString *title = [self.dataSourceIndexArray objectAtIndex:section];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 40)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    titleLabel.text = title;
    
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        titleLabel.textColor = [UIColor colorWithRed:0.98f green:0.98f blue:0.98f alpha:1];
        titleLabel.shadowColor = [UIColor blackColor];
    } else if(style == UIStyleWhiteChocolate) {
        titleLabel.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1];
        titleLabel.shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8f];
    }
    
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_footer.png"]];
    footerImageView.frame = CGRectMake(0, 0, 320, 40);
    
    [footerView addSubview:footerImageView];
    return footerView;
}

#pragma mark -
#pragma mark Methods to overwrite

- (void)configureDataSource {
    
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUIStyleNotification:(NSNotification *)notification {
    [self.tableView reloadData];
}

@end
