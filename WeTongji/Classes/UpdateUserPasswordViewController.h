//
//  UpdateUserPasswordViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface UpdateUserPasswordViewController : WTPostViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UILabel *paperTitleLabel;
@property (nonatomic, strong) IBOutlet UITextField *oldPasswordTextField;
@property (nonatomic, strong) IBOutlet UITextField *updatedPasswordTextField;
@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
