//
//  LoginViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-18.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *bgImageView;

- (IBAction)didClickCancelButton:(UIButton *)sender;

@end
