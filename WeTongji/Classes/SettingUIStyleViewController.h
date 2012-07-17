//
//  SettingUIStyleViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-10.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"

@interface SettingUIStyleViewController : WTNavigationViewController <UITableViewDataSource, UITableViewDelegate> {
    NSInteger _selectRow;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
