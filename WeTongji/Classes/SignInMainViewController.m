//
//  SignInMainViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "SignInMainViewController.h"
#import "WTClient.h"
#import "UIApplication+Addition.h"
#import "NSString+Addition.h"

@interface SignInMainViewController ()

@end

@implementation SignInMainViewController

@synthesize mainBgView = _mainBgView;
@synthesize nameTextField = _nameTextField;
@synthesize scrollView = _scrollView;
@synthesize studentNumberTextField = _studentNumberTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize confirmTextField = _confirmTextField;
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
#pragma mark Logic methods 

- (BOOL)isParameterValid {
    BOOL result = YES;
    if([self.nameTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入姓名。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if([self.studentNumberTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入学号。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if([self.passwordTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if(![self.passwordTextField.text isSuitableForPassword]) {
        [UIApplication presentAlertToast:@"密码只支持数字、字母及下划线。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if(self.passwordTextField.text.length < 6) {
        [UIApplication presentAlertToast:@"请输入至少6位密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if (![self.confirmTextField.text isEqualToString:self.passwordTextField.text]) {
        [UIApplication presentAlertToast:@"请确认两次密码一致。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    }
    return result;
}

- (void)activateUser {
    if(self.isParameterValid == NO)
        return;
    if(self.isSendingRequest)
        return;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getActivityIndicatorButtonItem];
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            [UIApplication showAlertMessage:@"请登录您的同济大学邮箱查收验证邮件。" withTitle:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            if(client.responseStatusCode == 8)
                [UIApplication presentAlertToast:@"该账户已经注册过。" withVerticalPos:self.toastVerticalPos];
            
            else if(client.responseStatusCode == 9) 
                [UIApplication presentAlertToast:@"姓名与学号不匹配。" withVerticalPos:self.toastVerticalPos];
            else {
                NSLog(@"client responseStatusCode %d", client.responseStatusCode);
                [UIApplication presentAlertToast:@"注册失败。" withVerticalPos:self.toastVerticalPos];
            }
        }
        [self configureNavBar];
        self.sendingRequest = NO;
    }];
    [client activateUser:self.nameTextField.text stutentNum:self.studentNumberTextField.text password:self.passwordTextField.text];
    self.sendingRequest = YES;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"注册"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    
    UIBarButtonItem *activateButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"注册" target:self action:@selector(didClickActivateButton)];
    self.navigationItem.rightBarButtonItem = activateButton;
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

- (void)didClickActivateButton {
    [self activateUser];
}

#pragma mark -
#pragma mark UITextFiled delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.nameTextField) {
        [self.studentNumberTextField becomeFirstResponder];
    } else if(textField == self.passwordTextField) {
        [self activateUser];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y / 2) animated:YES];
}

@end
