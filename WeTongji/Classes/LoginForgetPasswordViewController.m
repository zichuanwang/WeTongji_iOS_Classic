//
//  LoginForgetPasswordViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginForgetPasswordViewController.h"
#import "UIApplication+Addition.h"
#import "WTClient.h"

@interface LoginForgetPasswordViewController ()

@end

@implementation LoginForgetPasswordViewController

@synthesize mainBgView = _mainBgView;
@synthesize nameTextField = _nameTextField;
@synthesize scrollView = _scrollView;
@synthesize studentNumberTextField = _studentNumberTextField;
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
    self.bgView = nil;
}

#pragma mark - 
#pragma mark Logic methods 

- (BOOL)isParameterValid {
    BOOL result = YES;
    if([self.nameTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入姓名。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if([self.studentNumberTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入学号。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    }
    return result;
}

- (void)resetPassword {
    if(self.isParameterValid == NO)
        return;
    if(self.isSendingRequest)
        return;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getActivityIndicatorButtonItem];
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            [UIApplication showAlertMessage:@"请登录您的同济大学邮箱查收重置密码邮件。" withTitle:@"重置密码成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            [UIApplication presentAlertToast:@"重置密码失败。" withVerticalPos:self.toastVerticalPos];
        }
        [self configureNavBar];
        self.sendingRequest = NO;
    }];
    [client resetPasswordWithUserName:self.nameTextField.text studentNumber:self.studentNumberTextField.text];
    self.sendingRequest = YES;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"重置密码"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *activateButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"重置" target:self action:@selector(didClickResetPasswordButton)];
    self.navigationItem.rightBarButtonItem = activateButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height = self.bgView.frame.size.height > frame.size.height ? self.bgView.frame.size.height : frame.size.height + 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickResetPasswordButton {
    [self resetPassword];
}

#pragma mark -
#pragma mark UITextFiled delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.nameTextField) {
        [self.studentNumberTextField becomeFirstResponder];
    } else if(textField == self.studentNumberTextField)
        [self resetPassword];
    return NO;
}

@end
