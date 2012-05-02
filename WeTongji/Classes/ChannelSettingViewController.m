//
//  ChannelSettingViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ChannelSettingViewController.h"
#import "ChannelSettingTableViewController.h"

@interface ChannelSettingViewController ()

@property (nonatomic, strong) ChannelSettingTableViewController *settingTableViewController;

@end

@implementation ChannelSettingViewController

@synthesize settingTableViewController = _settingTableViewController;
@synthesize delegate = _delegate;

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
    [self configureSettingTabelView];
    [self configureNavBar];
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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"频道设置"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"频道" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureSettingTabelView {
    ChannelSettingTableViewController *vc = [[ChannelSettingTableViewController alloc] init];
    self.settingTableViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.navBarShadowImageView];

}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.delegate channelSettingViewControllerWillDismiss:self];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
