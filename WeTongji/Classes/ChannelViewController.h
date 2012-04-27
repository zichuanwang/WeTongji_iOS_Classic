//
//  ChannelViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"
#import "ChannelOutlineTableViewController.h"
#import "ChannelSettingViewController.h"

@interface ChannelViewController : WTNavigationViewController <ChannelOutlineTableViewControllerDelegate, ChannelSettingViewControllerDelegate>

@end
