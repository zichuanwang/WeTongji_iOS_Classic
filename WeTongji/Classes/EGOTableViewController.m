//
//  EGOTableViewController.m
//  PushBox
//
//  Created by Xie Hasky on 11-7-30.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "EGOTableViewController.h"
#import "WTTableViewHeaderFooterFactory.h"

#define kUserDefaultKeyFirstTimeUsingEGOView @"kUserDefaultKeyFirstTimeUsingEGOView"

@interface EGOTableViewController()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation EGOTableViewController

@synthesize egoHeaderView = _egoHeaderView;
@synthesize loadMoreDataButton = _loadMoreDataButton;
@synthesize activityView = _activityView;
@synthesize nextPage = _nextPage;

- (id)init {
    self = [super init];
    if(self) {
        self.nextPage = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"bound width:%f, bound height:%f", self.tableView.bounds.size.width,self.tableView.bounds.size.height);
    self.egoHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 
                                                                                     0.0f - self.tableView.bounds.size.height, 
                                                                                     self.tableView.frame.size.width, 
                                                                                     self.tableView.bounds.size.height)];
    self.egoHeaderView.delegate = self;
    [self.tableView addSubview:self.egoHeaderView];
    
    _reloadingFlag = NO;
    _loadingFlag = NO;
}

#pragma mark - 
#pragma mark EGO methods

- (UIButton *)loadMoreDataButton
{
    if (!_loadMoreDataButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 40);
        NSString *text = NSLocalizedString(@"点击加载更多。", nil);
        [button setTitle:text forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        button.titleLabel.shadowOffset = CGSizeMake(0, 1);
        [button setTitleColor:[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1] forState:UIControlStateNormal];     
        [button setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(loadMoreData) forControlEvents:UIControlEventTouchUpInside];
        self.loadMoreDataButton = button;
    }
    return _loadMoreDataButton;
}

- (void)startLoading {
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame = CGRectMake(15, 15, 30, 30);
    [self.loadMoreDataButton addSubview:self.activityView];
    [self.activityView startAnimating];
}

- (void)stopLoading {
    if (self.activityView != nil) {
        [self.activityView stopAnimating];
        [self.activityView removeFromSuperview];
        self.activityView = nil;
    }
}

- (void)showLoadMoreDataButton {
    [self configureTableViewFooterWithType:EGOTableViewFooterLoadMore];
}

- (void)hideLoadMoreDataButton {
    [self configureTableViewFooterWithType:EGOTableViewFooterEmpty];
}

- (void)loadMoreData {
    
}

- (void)refresh {
    
}

- (void)reloadTableViewDataSource {
    
	_reloadingFlag = YES;
	[self refresh];
}

- (void)doneLoadingTableViewData {
    [UIView animateWithDuration:0.2f animations:^(void) {
        [self.tableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        
    } completion:^(BOOL finished) {
        _reloadingFlag = NO;
        
    }];
	[self.egoHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return _reloadingFlag; // should return if data source model is reloading
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[self.egoHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {	
	[self.egoHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark UI methods

- (void)configureTableViewFooterWithType:(EGORefreshTableViewFooterType)type {
    if(type == EGOTableViewFooterEmptyWithHint) {
        UIView *footerView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithNoDataHint];
        self.tableView.tableFooterView = footerView;
    }
    else if(type == EGOTableViewFooterEmpty) {
        UIView *footerView = [WTTableViewHeaderFooterFactory getWideWTTableViewEmptyFooter];
        self.tableView.tableFooterView = footerView;
    } else if(type == EGOTableViewFooterLoadMore) {
        UIView *footerView = [WTTableViewHeaderFooterFactory getWideWTTableViewFooterWithBlank];
        [footerView addSubview:self.loadMoreDataButton];
        self.tableView.tableFooterView = footerView;
    }
}

- (void)configureTableViewHeader {
    UIView *headerView = [WTTableViewHeaderFooterFactory getWideWTTableViewHeader];
    self.tableView.tableHeaderView = headerView;
}

- (void)configureTableViewFooter {
    if(self.numberOfRowsInFirstSection == 0) {
        [self configureTableViewFooterWithType:EGOTableViewFooterEmptyWithHint];
    }
    else if(self.nextPage == 0) {
        [self configureTableViewFooterWithType:EGOTableViewFooterEmpty];
    } else {
        [self configureTableViewFooterWithType:EGOTableViewFooterLoadMore];
    }
}

- (void)configureTableViewHeaderFooter {
    [self configureTableViewHeader];
    [self configureTableViewFooter];
}

@end
