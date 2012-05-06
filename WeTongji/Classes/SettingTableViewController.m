//
//  SettingTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-24.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingTableViewCell.h"
#import "SettingInfoReader.h"
#import "UIApplication+Addition.h"

@interface SettingTableViewController ()

@end

@implementation SettingTableViewController

@synthesize delegate = _delegate;

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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.delegate = nil;
}

#pragma mark -
#pragma mark Logic Methods

- (SettingInfo *)getSettingInfoAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    SettingInfo *info = [value objectAtIndex:indexPath.row];
    return info;
}

#pragma mark -
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"SettingTableViewCell";
}

- (void)configureDataSource {
    SettingInfoReader *reader = [[SettingInfoReader alloc] init];
    NSArray *sectionArray = [reader getSettingInfoSectionArray];
    for(SettingInfoSection *section in sectionArray) {
        [self.dataSourceIndexArray addObject:section.sectionTitle];
        NSMutableArray *itemTitleArray = [NSMutableArray array];
        for(SettingInfo *info in section.itemArray) {
            [itemTitleArray addObject:info];
        }
        [self.dataSourceDictionary setValue:itemTitleArray forKey:section.sectionTitle];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *settingCell = (SettingTableViewCell *)cell;
    SettingInfo *info = [self getSettingInfoAtIndexPath:indexPath];
    settingCell.itemTitleLabel.text = info.itemTitle;
    if([info.accessoryType isEqualToString:kAccessoryTypeSwitch]) {
        settingCell.itemSwitch.hidden = NO;
    } else if([info.accessoryType isEqualToString:kAccessoryTypeDisclosure]) {
        settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}
#pragma mark -
#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingInfo *info = [self getSettingInfoAtIndexPath:indexPath];
    if(info.nibFileName) {
        UIViewController *vc = [[NSClassFromString(info.nibFileName) alloc] initWithNibName:info.nibFileName bundle:nil];
        if(!vc)
            return;
        if([info.wayToPresentViewController isEqualToString:kModalViewController]) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [[UIApplication sharedApplication].rootViewController presentModalViewController:nav animated:YES];
        }
        else if([info.wayToPresentViewController isEqualToString:kPushNavigationController]) {
            [self.delegate settingTableViewController:self pushViewController:vc];
        }
    }
}

@end
