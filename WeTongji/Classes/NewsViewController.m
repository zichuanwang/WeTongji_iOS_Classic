//
//  NewsViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-29.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "NewsViewController.h"
#import "WTClient.h"
#import "NewsOutlineTableViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) NewsOutlineTableViewController *outlineTableViewController;

@end

@implementation NewsViewController

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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"新闻"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
}

- (void)configureOutlineTableView {
    NewsOutlineTableViewController *vc = [[NewsOutlineTableViewController alloc] init];
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
#pragma mark NewsOutlineTableViewController delegate

- (void)newsOutlineTableViewDidSelectNews:(News *)news {
    
}

@end
