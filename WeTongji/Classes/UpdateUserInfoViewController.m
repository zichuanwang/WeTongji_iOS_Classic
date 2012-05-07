//
//  UpdateUserInfoViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UpdateUserInfoViewController.h"
#import "WTClient.h"
#import "UIApplication+Addition.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"
#import "Student+Addition.h"
#import "NSNotificationCenter+Addition.h"

@interface UpdateUserInfoViewController ()

@end

@implementation UpdateUserInfoViewController

@synthesize bgImageView = _bgImageView;
@synthesize scrollView = _scrollView;
@synthesize mainBgView = _mainBgView;
@synthesize bgView = _bgView;
@synthesize phoneNumberTextField = _phoneNumberTextField;
@synthesize qqTextField = _qqTextField;
@synthesize emailTextField = _emailTextField;
@synthesize weiboTextField = _weiboTextField;

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
    [self configureTextFiledPlaceHolder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.bgImageView = nil;
    self.scrollView = nil;
    self.mainBgView = nil;
    self.phoneNumberTextField = nil;
    self.qqTextField = nil;
    self.emailTextField = nil;
    self.weiboTextField = nil;
}
#pragma mark -
#pragma mark Logic methods

- (BOOL)isParameterValid {
    BOOL result = YES;
    //There's no limits here now.
    if([self.phoneNumberTextField.text isEqualToString:@""] 
       && [self.qqTextField.text isEqualToString:@""]
       && [self.emailTextField.text isEqualToString:@""]
       && [self.weiboTextField.text isEqualToString:@""]) {
        [UIApplication presentAlertToast:@"请更改至少一项内容。" withVerticalPos:self.toastVerticalPos];
        result = NO;
    }
    return result;
}

- (void)updateUser:(NSDictionary *)dict {
    NSDictionary *userInfo = [dict objectForKey:@"User"];
    [Student insertStudent:userInfo inManagedObjectContext:self.managedObjectContext];
    [NSNotificationCenter postChangeCurrentUserNotification];
}

- (void)updateInfo {
    if(!self.isParameterValid)
        return;
    if(self.isSendingRequest)
        return;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getActivityIndicatorButtonItem];
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            [self updateUser:client.responseData];            
            [self.parentViewController dismissModalViewControllerAnimated:YES];
            [UIApplication presentToast:@"更新资料成功。" withVerticalPos:DefaultToastVerticalPosition];
            
        } else {
            [UIApplication presentAlertToast:@"更新资料失败。" withVerticalPos:self.toastVerticalPos];
            self.sendingRequest = NO;
        }
        [self configureNavBar];
    }];
    [client updateUserDisplayName:nil email:self.emailTextField.text weiboName:self.weiboTextField.text phoneNum:self.phoneNumberTextField.text qqAccount:self.qqTextField.text];
    self.sendingRequest = YES;
}


#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"更新资料"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *cancelButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"取消" target:self action:@selector(didClickCancelButton)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *sendButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"发送" target:self action:@selector(didClickSendButton)];
    self.navigationItem.rightBarButtonItem = sendButton;
}

- (void)configureScrollView {
    CGRect frame = self.scrollView.frame;
    frame.size.height = self.bgView.frame.size.height;
    self.scrollView.contentSize = frame.size;
    
    self.mainBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    [self.phoneNumberTextField becomeFirstResponder];
}

- (void)configureTextFiledPlaceHolder {
    User *user = self.currentUser;
    if(user.phone_number && ![user.phone_number isEqualToString:@""]) {
        self.phoneNumberTextField.placeholder = user.phone_number;
    }
    if(user.email_address && ![user.email_address isEqualToString:@""]) {
        self.emailTextField.placeholder = user.email_address;
    }
    if(user.qq_number && ![user.qq_number isEqualToString:@""]) {
        self.qqTextField.placeholder = user.qq_number;
    }
    if(user.sina_weibo_name && ![user.sina_weibo_name isEqualToString:@""]) {
        self.weiboTextField.placeholder = user.sina_weibo_name;
    }
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickCancelButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)didClickSendButton {
    [self updateInfo];
}

#pragma mark - 
#pragma mark UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.emailTextField) {
        [self.emailTextField becomeFirstResponder];
    } else if(textField == self.weiboTextField) {
        [self updateInfo];
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y / 3 * 2) animated:YES];
}

@end
