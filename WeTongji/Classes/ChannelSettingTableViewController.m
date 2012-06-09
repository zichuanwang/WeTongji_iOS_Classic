//
//  ChannelSettingTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
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
    if(indexPath.section == 0 || indexPath.section == 2)
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
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"过滤条件"]];
    
    NSArray *channel = [NSUserDefaults getChannelNameArray];
    NSArray *sort = [NSArray arrayWithObjects:@"按活动开始时间正序", @"按活动开始时间逆序", @"按好评数逆序", nil];
    NSArray *expire = [NSArray arrayWithObjects:@"过滤过期活动", nil];
    
    [self.dataSourceDictionary setValue:channel forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:sort forKey:[self.dataSourceIndexArray objectAtIndex:1]];
    [self.dataSourceDictionary setValue:expire forKey:[self.dataSourceIndexArray objectAtIndex:2]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ChannelSettingTableViewCell *settingCell = (ChannelSettingTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSString *data = [value objectAtIndex:indexPath.row];
    settingCell.categoryLabel.text = data;
    
    if(indexPath.section == 0) {
        settingCell.delegate = self;
        settingCell.itemSwitch.hidden = NO;
        BOOL follow = ((NSNumber *)[self.followChannelNumArray objectAtIndex:indexPath.row]).boolValue;
        settingCell.itemSwitch.on = follow;
    } else if(indexPath.section == 1) {
        settingCell.itemSwitch.hidden = YES;
        BOOL choose = ((NSNumber *)[self.sortChannelMethodArray objectAtIndex:indexPath.row]).boolValue;
        if(choose)
            settingCell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            settingCell.accessoryType = UITableViewCellAccessoryNone;
    } else if(indexPath.section == 2) {
        settingCell.itemSwitch.hidden = NO;
        settingCell.delegate = self;
        BOOL showExpire = [NSUserDefaults getShowExpireActivitiesParam];
        settingCell.itemSwitch.on = !showExpire;
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
    } else if(indexPath.section == 2) {
        BOOL showExpire = ![NSUserDefaults getShowExpireActivitiesParam];
        [NSUserDefaults setShowExpireActivitiesParam:showExpire];
    }
    [self.tableView reloadData];
}

@end
