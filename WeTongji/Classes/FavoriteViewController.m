//
//  FavoriteViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-29.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "FavoriteViewController.h"
#import "FavoriteOutlineViewController.h"
#import "ChannelDetailViewController.h"

@interface FavoriteViewController ()

@property (nonatomic, strong) FavoriteOutlineViewController *outlineTableViewController;

@end

@implementation FavoriteViewController

@synthesize outlineTableViewController = _outlineTableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavBar];
    [self configureOutlineTableView];
    self.navigationController.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"收藏"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
}

- (void)configureOutlineTableView {
    FavoriteOutlineViewController *vc = [[FavoriteOutlineViewController alloc] init];
    [self.view insertSubview:vc.view belowSubview:self.navBarShadowImageView];
    self.outlineTableViewController = vc;
    vc.delegate = self;
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickFinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark ChannelOutlineTableViewController delegate

- (void)channelOutlineTableViewDidSelectActivity:(Activity *)activity {
    ChannelDetailViewController *vc = [[ChannelDetailViewController alloc] initWithActivity:activity];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark UINavigationController delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.outlineTableViewController configureTableViewFooter];
}

@end
