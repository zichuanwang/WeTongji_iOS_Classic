//
//  WTNavigationViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+WTBarButtonItem.h"
#import "UILabel+Addition.h"
#import "CoreDataViewController.h"

@interface WTNavigationViewController : CoreDataViewController

@property (nonatomic, weak) IBOutlet UIImageView *navBarShadowImageView;
@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;

- (void)handleChangeCurrentUIStyleNotification:(NSNotification *)notification;

@end
