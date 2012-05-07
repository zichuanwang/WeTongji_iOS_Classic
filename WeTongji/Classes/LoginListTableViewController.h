//
//  LoginListTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface LoginListTableViewController : CoreDataTableViewController <UIAlertViewDelegate> {
    NSInteger _selectRow;
}

@property (nonatomic, strong) IBOutlet UIView *mainBgView;

@end
