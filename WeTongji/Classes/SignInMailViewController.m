//
//  SignInMailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignInMailViewController.h"

@interface SignInMailViewController ()

@end

@implementation SignInMailViewController

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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"注册"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *nextButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"继续" target:self action:@selector(didClickNextButton)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickNextButton {

}

@end
