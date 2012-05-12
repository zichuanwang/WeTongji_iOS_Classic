//
//  RootViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "RootViewController.h"
#import "MetroViewController.h"
#import "MainViewController.h"
#import "RootView.h"

@interface RootViewController ()

@property (nonatomic, strong) MetroViewController *metroViewController;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) UINavigationController *navigationController;

@end

@implementation RootViewController

@synthesize defaultImageView = _defaultImageView;
@synthesize metroViewController = _metroViewController;
@synthesize mainViewController = _mainViewController;
@synthesize navigationController = _navigationController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureUI];
    
    self.defaultImageView.alpha = 1.0f;
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.defaultImageView.alpha = 0;
    } completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.defaultImageView = nil;
    [self clearUI];
}

#pragma mark -
#pragma mark - UI methods

- (void)configureUI {
    self.mainViewController = [[MainViewController alloc] init];
    self.metroViewController = [[MetroViewController alloc] init];
    UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    self.navigationController = aNavigationController;
    self.navigationController.view.tag = ROOT_MAIN_VIEW_TAG;
    self.navigationController.view.frame = CGRectMake(0, 0, 320, 460);
    
    [self.view insertSubview:self.navigationController.view belowSubview:self.defaultImageView];
    [self.view insertSubview:self.metroViewController.view belowSubview:self.defaultImageView];
}

- (void)clearUI {
    [self.mainViewController.view removeFromSuperview];
    self.mainViewController = nil;
    [self.navigationController.view removeFromSuperview];
    self.navigationController = nil;
    [self.metroViewController.view removeFromSuperview];
    self.metroViewController = nil;
}

@end
