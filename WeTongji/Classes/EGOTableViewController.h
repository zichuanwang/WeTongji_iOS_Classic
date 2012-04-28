//
//  EGOTableViewController.h
//  PushBox
//
//  Created by Xie Hasky on 11-7-30.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface EGOTableViewController : CoreDataTableViewController<EGORefreshTableHeaderDelegate> {
    BOOL _reloadingFlag;
    BOOL _loadingFlag;
    
    UIActivityIndicatorView* _activityView;
}

@property(nonatomic, strong) EGORefreshTableHeaderView *egoHeaderView;
@property(nonatomic, strong) UIButton *loadMoreDataButton;

- (void)doneLoadingTableViewData;
- (void)showLoadMoreDataButton;
- (void)hideLoadMoreDataButton;
- (void)startLoading;
- (void)stopLoading;

//to override
- (void)loadMoreData;
- (void)refresh;

@end
