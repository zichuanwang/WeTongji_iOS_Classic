//
//  LoginViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "LoginViewController.h"
#import "UIApplication+Addition.h"
#import "SignInProtocolViewController.h"

@interface LoginViewController ()

@property (nonatomic, weak) UITextField *editingTextField;

@end

@implementation LoginViewController

@synthesize bgImageView = _bgImageView;
@synthesize mainBgView = _mainBgView;
@synthesize editingTextField = _editingTextField;
@synthesize scrollView = _scrollView;
@synthesize accountTextField = _accountTextField;
@synthesize passwordTextField = _passwordTextField;

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
//    UITapGestureRecognizer* gesture;
//    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
//    [self.bgImageView addGestureRecognizer:gesture];
    
    [self configureNavBar];
    [self configureScrollView];
    [self.accountTextField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.bgImageView = nil;
    self.mainBgView = nil;
    self.scrollView = nil;
    self.accountTextField = nil;
    self.passwordTextField = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"登录"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"取消" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *settingButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"注册" target:self action:@selector(didClickSignInButton)];
    self.navigationItem.rightBarButtonItem = settingButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height += 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
}

- (void)dismissKeyboard {
    [self.editingTextField resignFirstResponder];
}

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSignInButton {
    SignInProtocolViewController *vc = [[SignInProtocolViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
#pragma mark UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.editingTextField = textField;
}

@end
