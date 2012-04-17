//
//  LoginTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSInteger _selectRow;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
