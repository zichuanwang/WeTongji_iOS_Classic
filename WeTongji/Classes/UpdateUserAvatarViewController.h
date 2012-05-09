//
//  UpdateUserAvatarViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"

@interface UpdateUserAvatarViewController : WTPostViewController

@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *paperTitleLabel;

@end
