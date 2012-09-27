//
//  AppInfoViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "WTNavigationViewController.h"

@interface AppInfoViewController : WTNavigationViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UILabel *appVersionLabel;

- (IBAction)didClickFeedbackButton:(UIButton *)sender;
- (IBAction)didClickFollowUsButton:(UIButton *)sender;
- (IBAction)didClickEvaluateUsButton:(UIButton *)sender;

@end
