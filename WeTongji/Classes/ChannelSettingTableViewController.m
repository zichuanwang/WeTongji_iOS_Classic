//
//  ChannelSettingTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelSettingTableViewController.h"
#import "NSUserDefaults+Addition.h"

@interface ChannelSettingTableViewController ()

@property (nonatomic, strong) NSMutableArray *followChannelNumArray;
@property (nonatomic, strong) NSMutableArray *sortChannelMethodArray;

@end

@implementation ChannelSettingTableViewController

@synthesize followChannelNumArray = _followChannelNumArray;
@synthesize sortChannelMethodArray = _sortChannelMethodArray;

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
    self.followChannelNumArray = [NSMutableArray arrayWithArray:[NSUserDefaults getChannelFollowStatusArray]];
    self.sortChannelMethodArray = [NSMutableArray arrayWithArray:[NSUserDefaults getChannelSortMethodArray]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//#pragma mark -
//#pragma mark UI methods
//
//- (void)updateUI {
//    
//}

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)
        return;
    if(indexPath.section == 1) {
        for(int i = 0; i < self.sortChannelMethodArray.count; i++) {
            [self.sortChannelMethodArray replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }
        [self.sortChannelMethodArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
        [NSUserDefaults setChannelSortMethodArray:self.sortChannelMethodArray];
    }
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassNameAtIndexPath:(NSIndexPath *)indexPath {
    return @"ChannelSettingTableViewCell";
}


- (void)configureDataSource {    
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"频道筛选"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"阅读顺序"]];
    
    NSArray *channel = [NSUserDefaults getChannelNameArray];
    
    NSArray *sort = [NSArray arrayWithObjects:@"按活动开始时间排序", @"按好评数排序", nil];
    
    [self.dataSourceDictionary setValue:channel forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:sort forKey:[self.dataSourceIndexArray objectAtIndex:1]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ChannelSettingTableViewCell *settingCell = (ChannelSettingTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSString *data = [value objectAtIndex:indexPath.row];
    settingCell.categoryLabel.text = data;
    
    if(indexPath.section == 0) {
        settingCell.delegate = self;
        BOOL follow = ((NSNumber *)[self.followChannelNumArray objectAtIndex:indexPath.row]).boolValue;
        if(follow)
            settingCell.itemSwitch.on = YES;
        else
            settingCell.itemSwitch.on = NO;
            }
    else if(indexPath.section == 1) {
        settingCell.itemSwitch.hidden = YES;
        BOOL choose = ((NSNumber *)[self.sortChannelMethodArray objectAtIndex:indexPath.row]).boolValue;
        if(choose)
            settingCell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            settingCell.accessoryType = UITableViewCellAccessoryNone;

    }
}

#pragma mark -
#pragma mark ChannelSettingTableViewCell delegate

- (void)channelSettingCellDidClickSwitch:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath.section == 0) {
        BOOL follow = ((NSNumber *)[self.followChannelNumArray objectAtIndex:indexPath.row]).boolValue;
        [self.followChannelNumArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:!follow]];
        [NSUserDefaults setChannelFollowStatus:self.followChannelNumArray];
    }
    [self.tableView reloadData];
}

@end
