//
//  EGOTableViewController.m
//  PushBox
//
//  Created by Xie Hasky on 11-7-30.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "EGOTableViewController.h"

#define kUserDefaultKeyFirstTimeUsingEGOView @"kUserDefaultKeyFirstTimeUsingEGOView"

@interface EGOTableViewController()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation EGOTableViewController

@synthesize egoHeaderView = _egoHeaderView;
@synthesize loadMoreDataButton = _loadMoreDataButton;
@synthesize activityView = _activityView;

- (UIButton *)loadMoreDataButton
{
    if (!_loadMoreDataButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, self.tableView.frame.size.width, 60);
        NSString *text = NSLocalizedString(@"点击加载更多。", nil);
        [button setTitle:text forState:UIControlStateNormal];
        [button setTitle:text forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        
        UIImageView *devideLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dividing_line@2x.png"]];
        devideLineView.frame = CGRectMake(0, 0, 290.0f, 1.0f);
        devideLineView.center = CGPointMake(self.tableView.frame.size.width / 2, 0);
        [button addSubview:devideLineView];
        
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted=YES;
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
    [self.tableView setTableFooterView:self.loadMoreDataButton];
}

- (void)hideLoadMoreDataButton {
    [self.tableView setTableFooterView:nil];
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

- (void)loadMoreData
{
    
}

- (void)refresh
{
    
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

- (void)configureTableViewFooterWithType:(EGORefreshTableViewFooterType)type {
    if(type == EGOTableViewFooterEmptyWithHint) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
        footerImageView.center = CGPointMake(160, 60);
        UIImageView *mainImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_main.png"]];
        mainImageView.center = CGPointMake(160, 20);
        UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
        lineImageView.center = CGPointMake(160, 20);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:14.0f];
        label.textColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1];
        label.shadowColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeMake(0, 1);
        label.text = @"无内容。";
        label.textAlignment = UITextAlignmentCenter;
        [mainImageView addSubview:label];
        
        [footerView addSubview:footerImageView];
        [footerView addSubview:mainImageView];
        [footerView addSubview:lineImageView];
        self.tableView.tableFooterView = footerView;
    }
    else if(type == EGOTableViewFooterEmpty) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        UIImageView *footerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_footer.png"]];
        footerImageView.center = CGPointMake(160, 20);
        [footerView addSubview:footerImageView];
        self.tableView.tableFooterView = footerView;
    }
}

- (void)configureTableViewHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_header.png"]];
    headerImageView.center = CGPointMake(160, 10);
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paper_wide_single_line.png"]];
    lineImageView.center = CGPointMake(160, 10);
    lineImageView.center = headerImageView.center;
    [headerView addSubview:headerImageView];
    [headerView addSubview:lineImageView];
    self.tableView.tableHeaderView = headerView;
}

@end
