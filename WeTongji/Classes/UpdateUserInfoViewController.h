//
//  UpdateUserInfoViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-5.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface UpdateUserInfoViewController : WTPostViewController<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *phoneNumberTextField;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *qqTextField;
@property (nonatomic, strong) IBOutlet UITextField *weiboTextField;
@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIView *bgView;
@property (nonatomic, strong) IBOutlet UILabel *paperTitleLabel;

@end
