//
//  MainViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-3-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTButton.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet WTButton *userInfoButton;
@property (strong, nonatomic) IBOutlet WTButton *checkButton;
@property (strong, nonatomic) IBOutlet WTButton *settingButton;

@property (strong, nonatomic) IBOutlet UIImageView *topCoverImageView;

- (IBAction)didClickTabBarButton:(UIButton *)sender;

@end
