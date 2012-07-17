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

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextField *accountTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UIView *bgView;

- (IBAction)didClickForgetPasswordButton:(UIButton *)sender;

@end
