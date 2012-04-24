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
#pragma mark WTMainTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"SettingTableViewCell";
}

- (void)configureDataSource {
    //[self.dataSourceIndexArray addObject:[NSString stringWithString:@"账号设置"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"应用设置"]];
    
    NSArray *account = [NSArray arrayWithObjects:
                    [NSArray arrayWithObjects:[NSString stringWithString:@"8:00"], [NSString stringWithString:@"高等数学"], [NSString stringWithString:@"南楼 101"], nil], nil];
    
    NSArray *application = [NSArray arrayWithObjects:@"自动同步课表"
                      ,nil];
    
    //[self.dataSourceDictionary setValue:account forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:application forKey:[self.dataSourceIndexArray objectAtIndex:0]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    SettingTableViewCell *toDoListCell = (SettingTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSString *data = [value objectAtIndex:indexPath.row];
    toDoListCell.itemTitleLabel.text = data;
}

@end
