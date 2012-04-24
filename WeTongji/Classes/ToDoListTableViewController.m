//
//  ToDoListTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoListTableViewCell.h"

@interface ToDoListTableViewController ()

@end

@implementation ToDoListTableViewController

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
}

#pragma mark -
#pragma mark WTMainTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ToDoListTableViewCell";
}

- (void)configureDataSource {
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"当前"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"稍后"]];
    
    NSArray *now = [NSArray arrayWithObjects:
                      [NSArray arrayWithObjects:[NSString stringWithString:@"8:00"], [NSString stringWithString:@"高等数学"], [NSString stringWithString:@"南楼 101"], nil], nil];
    
    NSArray *later = [NSArray arrayWithObjects:
                    [NSArray arrayWithObjects:[NSString stringWithString:@"10:00"], [NSString stringWithString:@"C语言程序设计"], [NSString stringWithString:@"机房"], nil],
                     [NSArray arrayWithObjects:[NSString stringWithString:@"15:20"], [NSString stringWithString:@"社会学"], [NSString stringWithString:@"北楼 310"], nil], nil];
    
    [self.dataSourceDictionary setValue:now forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:later forKey:[self.dataSourceIndexArray objectAtIndex:1]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ToDoListTableViewCell *toDoListCell = (ToDoListTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSArray *data = [value objectAtIndex:indexPath.row];
    
    if(indexPath.section == 1 && indexPath.row == 1)
        toDoListCell.pointImageView.image = [UIImage imageNamed:@"to_do_list_point_green.png"];
    
    toDoListCell.whenLabel.text = [data objectAtIndex:0];
    toDoListCell.whatLabel.text = [data objectAtIndex:1];
    toDoListCell.whereLabel.text = [data objectAtIndex:2];
}

@end
