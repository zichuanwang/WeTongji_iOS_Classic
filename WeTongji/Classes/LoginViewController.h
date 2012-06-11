//
//  LoginViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface LoginViewController : WTPostViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *accountTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIView *bgView;

- (IBAction)didClickLoginButton:(UIButton *)sender;
- (IBAction)didClickForgetPasswordButton:(UIButton *)sender;

@end
