//
//  ChannelSettingTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelSettingTableViewController.h"
#import "ChannelSettingTableViewCell.h"

@interface ChannelSettingTableViewController ()

@end

@implementation ChannelSettingTableViewController

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
}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark -
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassNameAtIndexPath:(NSIndexPath *)indexPath {
    return @"ChannelSettingTableViewCell";
}


- (void)configureDataSource {    
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"频道筛选"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"阅读顺序"]];
    
    NSArray *channel = [NSArray arrayWithObjects:@"学术讲座", @"文娱活动", @"赛事信息", @"企业招聘", nil];
    
    NSArray *sort = [NSArray arrayWithObjects:@"按活动时间排序", @"按好评数排序", nil];
    
    [self.dataSourceDictionary setValue:channel forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:sort forKey:[self.dataSourceIndexArray objectAtIndex:1]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ChannelSettingTableViewCell *settingCell = (ChannelSettingTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSString *data = [value objectAtIndex:indexPath.row];
    settingCell.categoryLabel.text = data;
}


@end
