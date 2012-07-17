//
//  UpdateUserPasswordViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface UpdateUserPasswordViewController : WTPostViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *paperTitleLabel;
@property (nonatomic, weak) IBOutlet UITextField *oldPasswordTextField;
@property (nonatomic, weak) IBOutlet UITextField *updatedPasswordTextField;
@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end
