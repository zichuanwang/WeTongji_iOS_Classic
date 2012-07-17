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

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UITextField *nameTextField;
@property (nonatomic, weak) IBOutlet UITextField *studentNumberTextField;
@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UIView *bgView;

@end
