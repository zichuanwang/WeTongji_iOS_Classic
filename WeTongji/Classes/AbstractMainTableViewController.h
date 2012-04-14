//
//  AbstractMainTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractMainTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSourceIndexArray;
@property (strong, nonatomic) NSMutableDictionary *dataSourceDictionary;

//methods to overwrite
- (void)configureDataSource;
- (NSString *)customCellClassName;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
