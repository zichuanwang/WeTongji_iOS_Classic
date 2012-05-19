//
//  NewsOutlineTableViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-3.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOTableViewController.h"
#import "News+Addition.h"

@protocol NewsOutlineTableViewControllerDelegate;

@interface NewsOutlineTableViewController : EGOTableViewController

@property (nonatomic, weak) id<NewsOutlineTableViewControllerDelegate> delegate;

@end

@protocol NewsOutlineTableViewControllerDelegate <NSObject>

- (void)newsOutlineTableViewDidSelectNews:(News *)news;

@end