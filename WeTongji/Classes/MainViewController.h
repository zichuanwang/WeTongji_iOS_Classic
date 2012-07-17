//
//  MainViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTButton.h"
#import "WTNavigationViewController.h"
#import "SettingTableViewController.h"

@interface MainViewController : WTNavigationViewController <SettingTableViewControllerDelegate>

@property (nonatomic, weak) IBOutlet WTButton *userInfoButton;
@property (nonatomic, weak) IBOutlet WTButton *checkButton;
@property (nonatomic, weak) IBOutlet WTButton *settingButton;

@property (nonatomic, weak) IBOutlet UIView *tabBarView;
@property (nonatomic, weak) IBOutlet UIView *tabBarContentView;
@property (nonatomic, weak) IBOutlet UIImageView *headerCoverImageView;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarBgImageView;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarSeperatorImageView;

- (IBAction)didClickTabBarButton:(UIButton *)sender;

@end
