//
//  UpdateUserAvatarViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTPostViewController.h"
#import "EditAvatarViewController.h"

@interface UpdateUserAvatarViewController : WTPostViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditAvatarViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UILabel *paperTitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;

- (IBAction)didClickAvatarButton:(UIButton *)sender;

@end
