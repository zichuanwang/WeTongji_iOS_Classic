//
//  UserInfoTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"

@interface UserInfoTableViewController ()

@end

@implementation UserInfoTableViewController

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
    UIImageView *avatarFrameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_frame.png"]];
    UIImageView *avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_info_default_image.jpg"]];
    avatarImageView.frame = CGRectMake(17, 17, 66, 66);
    avatarFrameImageView.frame = CGRectMake(210, 46, 100, 100);
    [avatarFrameImageView addSubview:avatarImageView];
    [self.tableView addSubview:avatarFrameImageView];
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
    return @"UserInfoTableViewCell";
}

- (void)configureDataSource {
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"基本资料"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"专业资料"]];
    [self.dataSourceIndexArray addObject:[NSString stringWithString:@"社交资料"]];
    
    NSArray *basic = [NSArray arrayWithObjects:
                      [NSArray arrayWithObjects:[NSString stringWithString:@"姓名"], [NSString stringWithString:@"王紫川"], nil],
                      [NSArray arrayWithObjects:[NSString stringWithString:@"性别"], [NSString stringWithString:@"男"], nil],
                      [NSArray arrayWithObjects:[NSString stringWithString:@"生日"], [NSString stringWithString:@"1990年 6月 24日"], nil], nil];
    
    NSArray *major = [NSArray arrayWithObjects:
                      [NSArray arrayWithObjects:[NSString stringWithString:@"年级"], [NSString stringWithString:@"三"], nil],
                      [NSArray arrayWithObjects:[NSString stringWithString:@"班级"], [NSString stringWithString:@"7"], nil],
                      [NSArray arrayWithObjects:[NSString stringWithString:@"学院"], [NSString stringWithString:@"软件学院"], nil],
                      [NSArray arrayWithObjects:[NSString stringWithString:@"专业"], [NSString stringWithString:@"软件工程"], nil], nil];
    
    NSArray *social = [NSArray arrayWithObjects:
                       [NSArray arrayWithObjects:[NSString stringWithString:@"手机"], [NSString stringWithString:@"15216719574"], nil],
                       [NSArray arrayWithObjects:[NSString stringWithString:@"Email"], [NSString stringWithString:@"wzc345@gmail.com"], nil], nil];
    
    [self.dataSourceDictionary setValue:basic forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    [self.dataSourceDictionary setValue:major forKey:[self.dataSourceIndexArray objectAtIndex:1]];
    [self.dataSourceDictionary setValue:social forKey:[self.dataSourceIndexArray objectAtIndex:2]];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *userInfoCell = (UserInfoTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    NSArray *data = [value objectAtIndex:indexPath.row];
    
    userInfoCell.categoryLabel.text = [data objectAtIndex:0];
    userInfoCell.contentLabel.text = [data objectAtIndex:1];
}

@end
