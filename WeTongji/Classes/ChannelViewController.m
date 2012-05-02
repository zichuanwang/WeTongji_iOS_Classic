//
//  ChannelViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ChannelViewController.h"
#import "ChannelOutlineTableViewController.h"
#import "ChannelDetailViewController.h"

@interface ChannelViewController ()

@property (nonatomic, strong) ChannelOutlineTableViewController *outlineTableViewController;

@end

@implementation ChannelViewController

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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"频道"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *settingButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"设置" target:self action:@selector(didClickSettingButton)];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)configureOutlineTableView {
    ChannelOutlineTableViewController *vc = [[ChannelOutlineTableViewController alloc] init];
    [self.view insertSubview:vc.view belowSubview:self.navBarShadowImageView];
    self.outlineTableViewController = vc;
    vc.delegate = self;
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickFinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSettingButton {
    ChannelSettingViewController *vc = [[ChannelSettingViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
#pragma mark ChannelOutlineTableViewController delegate

- (void)channelOutlineTableViewDidSelectActivity:(Activity *)activity {
    ChannelDetailViewController *vc = [[ChannelDetailViewController alloc] initWithActivity:activity];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
#pragma mark ChannelSettingViewController delegate

- (void)channelSettingViewControllerWillDismiss:(ChannelSettingViewController *)vc {
    [self.outlineTableViewController.view removeFromSuperview];
    self.outlineTableViewController = nil;
    [self configureOutlineTableView];
}

@end
