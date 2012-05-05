//
//  MonthEventTableViewController.h
//  WeTongji
//
//  Created by M.K.Rain on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthEventTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *courses;

- (void)setViewPositionY:(float)y viewHeight:(float)height;

@end
