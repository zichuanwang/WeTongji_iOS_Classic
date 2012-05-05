//
//  SignInMainViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SignInMainViewController.h"

@interface SignInMainViewController ()

@end

@implementation SignInMainViewController

@synthesize mainBgView = _mainBgView;
@synthesize nameTextField = _nameTextField;
@synthesize scrollView = _scrollView;
@synthesize studentNumberTextField = _studentNumberTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize bgView = _bgView;

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
    self.studentNumberTextField = nil;
    self.nameTextField = nil;
    self.passwordTextField = nil;
    self.bgView = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"注册"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *settingButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"注册" target:self action:@selector(didClickNextButton)];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height = self.bgView.frame.size.height;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickNextButton {
    
}

#pragma mark -
#pragma mark UITextFiled delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.nameTextField) {
        [self.studentNumberTextField becomeFirstResponder];
    } else if(textField == self.passwordTextField) {
        
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y / 2) animated:YES];
}

@end
