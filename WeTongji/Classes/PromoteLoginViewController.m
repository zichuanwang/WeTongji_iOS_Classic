//
//  PromoteLoginViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PromoteLoginViewController.h"
#import "UIApplication+Addition.h"
#import "LoginViewController.h"

@interface PromoteLoginViewController ()

@end

@implementation PromoteLoginViewController

@synthesize scrollView = _scrollView;
@synthesize mainBgView = _mainBgView;

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
    [self configureScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.mainBgView = nil;
    self.scrollView = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height += 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
}

#pragma mark -
#pragma mark IBActions

- (IBAction)didClickLoginButton:(UIButton *)sender {
    LoginViewController *vc = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].rootViewController presentModalViewController:nav animated:YES];
}

@end
