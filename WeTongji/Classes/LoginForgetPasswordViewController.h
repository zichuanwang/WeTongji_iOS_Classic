//
//  LoginForgetPasswordViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface LoginForgetPasswordViewController : WTPostViewController

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITextField *nameTextField;
@property (nonatomic, strong) IBOutlet UITextField *studentNumberTextField;
@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIView *bgView;

@end
