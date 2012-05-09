//
//  UserInfoTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-13.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserInfoReader.h"
#import "CoreDataViewController.h"
#import "NSNotificationCenter+Addition.h"
#import "NSString+Addition.h"
#import "UIImageView+Addition.h"

@interface UserInfoTableViewController ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@end

@implementation UserInfoTableViewController

@synthesize avatarImageView = _avatarImageView;

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
    [self configureTableView];
    
    [NSNotificationCenter registerChangeCurrentUserNotificationWithSelector:@selector(handleChangeCurrentUserNotification:) target:self]; 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Logic methods

- (UserInfo *)getUserInfoAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    UserInfo *info = [value objectAtIndex:indexPath.row];
    return info;
}

#pragma mark -
#pragma mark UI methods

- (void)configureTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    
    UIImageView *avatarFrameImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_frame.png"]];
    avatarFrameImageView.frame = CGRectMake(210, 46, 100, 100);
    
    UIImageView *defaultAvatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_info_default_avatar.png"]];
    defaultAvatarImageView.frame = CGRectMake(17, 17, 66, 66);
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:defaultAvatarImageView.frame];
    [self.avatarImageView loadImageFromURL:self.currentUser.avatar_link cacheInContext:self.managedObjectContext];
    
    [avatarFrameImageView addSubview:defaultAvatarImageView];
    [avatarFrameImageView addSubview:self.avatarImageView];
    [self.tableView addSubview:avatarFrameImageView];
}

#pragma mark -
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"UserInfoTableViewCell";
}

- (void)configureDataSource {
    UserInfoReader *reader = [[UserInfoReader alloc] init];
    NSArray *sectionArray = [reader getUserInfoSectionArray];
    for(UserInfoSection *section in sectionArray) {
        [self.dataSourceIndexArray addObject:section.sectionTitle];
        NSMutableArray *itemTitleArray = [NSMutableArray array];
        for(UserInfo *info in section.itemArray) {
            [itemTitleArray addObject:info];
        }
        [self.dataSourceDictionary setValue:itemTitleArray forKey:section.sectionTitle];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *userInfoCell = (UserInfoTableViewCell *)cell;
    UserInfo *info = [self getUserInfoAtIndexPath:indexPath];
    userInfoCell.categoryLabel.text = info.itemTitle;
    NSString *content = [self.currentUser valueForKey:info.contentName];
    if([content isKindOfClass:[NSNumber class]]) {
        content = ((NSNumber *)content).stringValue;
    } else if([content isKindOfClass:[NSDate class]]) {
        content = [NSString yearMonthDayConvertFromDate:(NSDate *)content];
    }
    userInfoCell.contentLabel.text = content;
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUserNotification:(NSNotification *)notification {
    [self.avatarImageView loadImageFromURL:self.currentUser.avatar_link cacheInContext:self.managedObjectContext];
    [self.tableView reloadData];
}

@end
