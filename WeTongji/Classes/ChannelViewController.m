//
//  ChannelViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelViewController.h"
#import "UIBarButtonItem+WTBarButtonItem.h"
#import "ChannelCategoryTableViewController.h"
#import "UILabel+Addition.h"

@interface ChannelViewController ()

@property (nonatomic, strong) ChannelCategoryTableViewController *categoryTableViewController;

@end

@implementation ChannelViewController

@synthesize categoryTableViewController = _categoryTableViewController;

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
    [self configureTableView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didClickFinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"频道"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
}

- (void)configureTableView {
    ChannelCategoryTableViewController *vc = [[ChannelCategoryTableViewController alloc] init];
    [self.view insertSubview:vc.view belowSubview:self.navBarShadowImageView];
    self.categoryTableViewController = vc;
}

@end
