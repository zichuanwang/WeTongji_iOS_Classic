//
//  ChannelOutlineTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelOutlineTableViewController.h"
#import "ChannelOutlineTableViewCell.h"

@interface ChannelOutlineTableViewController ()

@end

@implementation ChannelOutlineTableViewController

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
    [self configureTableViewHeaderFooter];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)configureTableViewHeaderFooter {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, 320, 40)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_header.png"]];
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
    lineImageView.center = headerImageView.center;
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    [self.tableView addSubview:headerView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
    footerImageView.center = CGPointMake(160, 20);
    [footerView addSubview:footerImageView];
    self.tableView.tableFooterView = footerView;
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

#pragma mark -
#pragma mark WTTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ChannelOutlineTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
