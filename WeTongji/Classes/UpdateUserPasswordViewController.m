//
//  UpdateUserPasswordViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateUserPasswordViewController.h"
#import "WTClient.h"
#import "UIApplication+Addition.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"

@interface UpdateUserPasswordViewController ()

@end

@implementation UpdateUserPasswordViewController

@synthesize paperTitleLabel = _paperTitleLabel;
@synthesize mainBgView = _mainBgView;
@synthesize oldPasswordTextField = _oldPasswordTextField;
@synthesize updatedPasswordTextField = _updatedPasswordTextField;
@synthesize scrollView = _scrollView;

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
    self.paperTitleLabel = nil;
    self.oldPasswordTextField = nil;
    self.updatedPasswordTextField = nil;
    self.mainBgView = nil;
    self.scrollView = nil;
}

#pragma mark -
#pragma mark Logic methods

- (BOOL)isParameterValid {
    BOOL result = YES;
    if([self.oldPasswordTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入旧密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if([self.updatedPasswordTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请输入新密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if(![self.updatedPasswordTextField.text isSuitableForPassword]) {
        [UIApplication presentAlertToast:@"密码只支持数字、字母及下划线。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    } else if(self.updatedPasswordTextField.text.length < 6) {
        [UIApplication presentAlertToast:@"请输入至少6位密码。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    }
    return result;
}

- (void)updateUser:(NSDictionary *)dict {
    NSDictionary *userInfo = [dict objectForKey:@"User"];
    User *user = [User insertUser:userInfo inManagedObjectContext:self.managedObjectContext];
    NSString *session = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Session"]];
    user.password = self.updatedPasswordTextField.text;
    user.session = session;
    NSLog(@"user id:%@, session:%@", user.user_id, session);
}

- (void)updatePassword {
    if(!self.isParameterValid)
        return;
    if(self.isSendingRequest)
        return;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getActivityIndicatorButtonItem];
    self.mainBgView.userInteractionEnabled = NO;
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            [self updateUser:client.responseData];
            [self.parentViewController dismissModalViewControllerAnimated:YES];
            [UIApplication presentToast:@"更改密码成功。" withVerticalPos:DefaultToastVerticalPosition];
            
        } else {
            [UIApplication presentAlertToast:@"更改密码失败。" withVerticalPos:self.toastVerticalPos];
            self.sendingRequest = NO;
            self.mainBgView.userInteractionEnabled = YES;
        }
        [self configureNavBar];
        
    }];
    [client updatePassword:self.updatedPasswordTextField.text withOldPassword:self.oldPasswordTextField.text];
    self.sendingRequest = YES;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"更改密码"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *cancelButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"取消" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *sendButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"发送" target:self action:@selector(didClickSendButton)];
    self.navigationItem.rightBarButtonItem = sendButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height += 1;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    
    [self.oldPasswordTextField becomeFirstResponder];
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSendButton {
    [self updatePassword];
}

#pragma mark - 
#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.oldPasswordTextField) {
        [self.updatedPasswordTextField becomeFirstResponder];
    } else if(textField == self.updatedPasswordTextField) {
        [self updatePassword];
    }
    return NO;
}

@end
