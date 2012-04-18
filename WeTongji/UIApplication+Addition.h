//
//  UIApplication+Addition.h
//  SocialFusion
//
//  Created by 王紫川 on 12-1-30.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimationDuration 0.25
#define kToastBottomVerticalPosition 400.0f

@interface UIApplication (Addition)

@property (nonatomic, readonly) UIViewController *rootViewController;

- (void)presentModalViewController:(UIViewController *)vc;
- (void)dismissModalViewController;
- (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y;
- (void)presentToastwithShortInterval:(NSString *)text withVerticalPos:(CGFloat)y;
- (void)presentErrorToast:(NSString *)text withVerticalPos:(CGFloat)y;
@end
