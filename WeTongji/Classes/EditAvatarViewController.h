//
//  EditAvatarViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CropImageView.h"

@protocol EditAvatarViewControllerDelegate;

@interface EditAvatarViewController : UIViewController

@property (nonatomic, weak) id<EditAvatarViewControllerDelegate> delegate;
@property (nonatomic, weak) IBOutlet CropImageView *cropImageView;
@property (nonatomic, weak) IBOutlet UIImageView *cropImageBgView;

- (id)initWithImage:(UIImage *)image;

- (IBAction)didClickFinishCropButton:(UIButton *)sender;
- (IBAction)didClickCancelButton:(UIButton *)sender;

@end

@protocol EditAvatarViewControllerDelegate <NSObject>

- (void)editAvatarViewDidFinishEdit:(UIImage *)image;
- (void)editAvatarViewDidCancelEdit;

@end

