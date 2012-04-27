//
//  ChannelOutlineTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "WTTabelViewController.h"
#import "Activity.h"

@protocol ChannelOutlineTableViewControllerDelegate;

@interface ChannelOutlineTableViewController : CoreDataTableViewController

@property (nonatomic, weak) id<ChannelOutlineTableViewControllerDelegate> delegate;

@end

@protocol ChannelOutlineTableViewControllerDelegate <NSObject>

- (void)channelOutlineTableViewDidSelectActivity:(Activity *)activity;

@end