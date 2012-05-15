//
//  ScheduleDayTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Event.h"

@protocol ScheduleDayTableViewControllerDelegate;

@interface ScheduleDayTableViewController : CoreDataTableViewController

@property (nonatomic, weak) id<ScheduleDayTableViewControllerDelegate> delegate;

@end

@protocol ScheduleDayTableViewControllerDelegate <NSObject>

- (void)scheduleDayTableViewDidSelectEvent:(Event *)event;

@end
