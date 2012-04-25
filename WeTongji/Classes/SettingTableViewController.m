//
//  SettingTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SettingTableViewCell.h"

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
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"SettingTableViewCell";
}

- (void)configureDataSource {
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"账号设置"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"应用设置"]];
    
    NSArray *account = [NSArray arrayWithObjects:@"切换账户", nil];
    
    NSArray *application = [NSArray arrayWithObjects:@"自动同步课表"
                      ,nil];
    
    [self.dataSourceDictionary setValue:account forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:application forKey:[self.dataSourceIndexArray objectAtIndex:1]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *settingCell = (SettingTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSString *data = [value objectAtIndex:indexPath.row];
    settingCell.itemTitleLabel.text = data;
    if(indexPath.section == 0) {
        settingCell.itemSwitch.hidden = YES;
        settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

#pragma mark -
#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 && indexPath.row == 0)
        [self.delegate settingTableViewControllerDidSelectLoginListCell];
}

@end
