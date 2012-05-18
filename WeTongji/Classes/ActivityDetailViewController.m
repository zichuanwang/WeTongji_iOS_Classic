//
//  ActivityDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityViewController.h"
#import "DetailImageViewController.h"

@interface ActivityDetailViewController ()

@property (nonatomic, strong) ActivityViewController *activityViewController;

@end

@implementation ActivityDetailViewController

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
}

- (void)configureActivityView {
    [self.view addSubview:self.activityViewController.view];
}

@end
