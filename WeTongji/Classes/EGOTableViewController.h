//
//  EGOTableViewController.h
//  PushBox
//
//  Created by Xie Hasky on 11-7-30.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "EGORefreshTableHeaderView.h"

#define TABLE_VIEW_VISIBLE_ROW_COUNT    7

typedef enum {
    EGOTableViewFooterEmpty,
    EGOTableViewFooterEmptyWithHint,
    EGOTableViewFooterLoadMore,
} EGORefreshTableViewFooterType;

@interface EGOTableViewController : CoreDataTableViewController<EGORefreshTableHeaderDelegate> {
    BOOL _reloadingFlag;
    BOOL _loadingFlag;
}

@property (nonatomic, strong) EGORefreshTableHeaderView *egoHeaderView;
@property (nonatomic, strong) UIButton *loadMoreDataButton;
@property (nonatomic, assign) NSInteger nextPage;

- (void)doneLoadingTableViewData;
- (void)showLoadMoreDataButton;
- (void)hideLoadMoreDataButton;
- (void)startLoading;
- (void)stopLoading;

- (void)configureTableViewFooter;
- (void)configureTableViewHeader;
- (void)configureTableViewHeaderFooter;

//to override
- (void)loadMoreData;
- (void)refresh;

@end
