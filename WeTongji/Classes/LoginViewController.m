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
#import "WTClient.h"
#import "User+Addition.h"
#import "NSUserDefaults+Addition.h"

#import "SignInMainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize bgImageView = _bgImageView;
@synthesize mainBgView = _mainBgView;
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
#pragma mark Logic methods

- (BOOL)isParameterValid {
    BOOL result = YES;
    if([self.accountTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入账号。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if([self.passwordTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if(self.passwordTextField.text.length < 6) {
        [UIApplication presentAlertToast:@"请输入至少6位密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    }
    return result;
}

- (void)login {
    if(!self.isParameterValid)
        return;
    if(self.isSendingRequest)
        return;
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            NSDictionary *userInfo = [client.responseData objectForKey:@"User"];
            User *user = [User insertUser:userInfo inManagedObjectContext:self.managedObjectContext];
            NSString *session = [NSString stringWithFormat:@"%@", [client.responseData objectForKey:@"Session"]];
            [NSUserDefaults setCurrentUserID:user.user_id session:session];
            NSLog(@"user id:%@, session:%@", user.user_id, session);
            
            [self.parentViewController dismissModalViewControllerAnimated:YES];
            [UIApplication presentToast:@"登录成功。" withVerticalPos:DefaultToastVerticalPosition];
            
        } else {
            [UIApplication presentAlertToast:@"登录失败。" withVerticalPos:self.toastVerticalPos];
        }
        self.sendingRequest = NO;
    }];
    [client login:self.accountTextField.text password:self.passwordTextField.text];
    self.sendingRequest = YES;
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

#pragma mark -
#pragma mark IBActions

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSignInButton {
    //SignInProtocolViewController *vc = [[SignInProtocolViewController alloc] init];
    SignInMainViewController *vc = [[SignInMainViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.passwordTextField) {
        [self login];
    }
    return NO;
}

@end
