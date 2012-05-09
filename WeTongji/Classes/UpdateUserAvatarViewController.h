//
//  UpdateUserAvatarViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"
#import "EditAvatarViewController.h"

@interface UpdateUserAvatarViewController : WTPostViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditAvatarViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *paperTitleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;

- (IBAction)didClickAvatarButton:(UIButton *)sender;

@end
