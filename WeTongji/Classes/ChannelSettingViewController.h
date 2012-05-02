//
//  ChannelSettingViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"

@protocol ChannelSettingViewControllerDelegate;

@interface ChannelSettingViewController : WTNavigationViewController

@property (nonatomic, weak) id<ChannelSettingViewControllerDelegate> delegate;

@end

@protocol ChannelSettingViewControllerDelegate <NSObject>

- (void)channelSettingViewControllerWillDismiss:(ChannelSettingViewController *)vc;

@end