//
//  LoginListViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginListViewController.h"
#import "LoginListTableViewController.h"
#import "UILabel+Addition.h"
#import "UIBarButtonItem+WTBarButtonItem.h"

@interface LoginListViewController ()

@property (nonatomic, strong) LoginListTableViewController *loginListTableViewController;

@end

@implementation LoginListViewController

@synthesize loginListTableViewController = _loginListTableViewController;

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
    [self configureLoginList];
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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"切换账户"];
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickBackButton)];

    self.navigationItem.titleView = titleLabel;
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureLoginList {
    LoginListTableViewController *vc = [[LoginListTableViewController alloc] init];
    CGRect frame =  vc.view.frame;
    frame.origin = CGPointMake(0, 0);
    vc.view.frame = frame;
    self.loginListTableViewController = vc;
    [self.view insertSubview:vc.view belowSubview:self.navBarShadowImageView];
}

#pragma mark - 
#pragma mark IBAction

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
