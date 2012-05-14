//
//  ChannelOutlineTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableViewController.h"
#import "Activity.h"

@protocol ChannelOutlineTableViewControllerDelegate;

@interface ChannelOutlineTableViewController : EGOTableViewController

@property (nonatomic, weak) id<ChannelOutlineTableViewControllerDelegate> delegate;

@end

@protocol ChannelOutlineTableViewControllerDelegate <NSObject>

- (void)channelOutlineTableViewDidSelectActivity:(Activity *)activity;

@end