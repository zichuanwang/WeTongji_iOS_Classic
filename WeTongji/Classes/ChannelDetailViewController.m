//
//  ChannelDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelDetailViewController.h"
#import "ActivityViewController.h"

@interface ChannelDetailViewController ()

@property (nonatomic, strong) ActivityViewController *activityViewController;

@end

@implementation ChannelDetailViewController

@synthesize activityViewController = _activityViewController;

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
    [self configureActivityView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (id)initWithActivity:(Activity *)activity {
    self = [super init];
    if(self) {
        self.activityViewController = [[ActivityViewController alloc] initWithActivity:activity];
    }
    return self;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"活动"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"频道" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureActivityView {
    [self.view addSubview:self.activityViewController.view];
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
