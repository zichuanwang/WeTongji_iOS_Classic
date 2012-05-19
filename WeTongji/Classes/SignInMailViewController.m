//
//  SignInMailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "SignInMailViewController.h"
#import "SignInMainViewController.h"

@interface SignInMailViewController ()

@end

@implementation SignInMailViewController

@synthesize mainBgView = _mainBgView;
@synthesize scrollView = _scrollView;
@synthesize descriptionLabel = _descriptionLabel;

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
    [self configureScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.scrollView = nil;
    self.mainBgView = nil;
    self.descriptionLabel = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"注册"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *nextButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"继续" target:self action:@selector(didClickNextButton)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

- (void)configureScrollView {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.frame.size.height + 1);
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    [self.descriptionLabel sizeToFit];
}

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickNextButton {
    SignInMainViewController *vc = [[SignInMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)didClickMailButton:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mail.tongji.edu.cn"]];
}

@end
