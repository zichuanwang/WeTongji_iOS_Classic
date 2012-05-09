//
//  UIApplication+Addition.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-30.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultToastVerticalPosition 420.0f
#define HighToastVerticalPosition 200.0f

@interface UIApplication (Addition)

@property (nonatomic, readonly) UIViewController *rootViewController;

- (void)presentModalViewController:(UIViewController *)vc;
- (void)dismissModalViewController;
+ (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y;
+ (void)presentAlertToast:(NSString *)text withVerticalPos:(CGFloat)y;
+ (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title;

@end
