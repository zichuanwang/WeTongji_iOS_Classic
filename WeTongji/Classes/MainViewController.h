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

@property (nonatomic, strong) IBOutlet WTButton *userInfoButton;
@property (nonatomic, strong) IBOutlet WTButton *checkButton;
@property (nonatomic, strong) IBOutlet WTButton *settingButton;

@property (nonatomic, strong) IBOutlet UIView *tabBarView;
@property (nonatomic, strong) IBOutlet UIView *tabBarContentView;
@property (nonatomic, strong) IBOutlet UIImageView *headerCoverImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarBgImageView;

- (IBAction)didClickTabBarButton:(UIButton *)sender;

@end
