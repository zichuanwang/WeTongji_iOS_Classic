//
//  ListScheduleViewController.h
//  WeTongji
//
//  Created by M.K.Rain on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListScheduleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *datesIndexArray;
@property (nonatomic, strong) NSMutableDictionary *dateSourceDictionary;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (void)moveToToday;

@end
