//  Created by Ziqi on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+RECurtainViewController.h"
#import "AppDelegate.h"

@implementation UIViewController (RECurtainViewController)

- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)curtainRevealViewController:(UIViewController *)viewControllerToReveal fromViewController:(UIViewController *)sender transitionStyle:(RECurtainTransitionStyle)transitionStyle;
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    UIImage *selfPortrait = [self imageWithView:appDelegate.window];
    UIImage *controllerScreenshot = [self imageWithView:viewControllerToReveal.view];
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfPortrait.size.width, selfPortrait.size.height)];
    coverView.backgroundColor = [UIColor blackColor];
    [appDelegate.window addSubview:coverView];
    
    int offset = 20;
    if (controllerScreenshot.size.height == [UIScreen mainScreen].bounds.size.height) {
        offset = 0;
    }
    
    float padding = [UIScreen mainScreen].bounds.size.width * 0.1;
    
    UIImageView *fadedView = [[UIImageView alloc] initWithFrame:CGRectMake(padding, padding + offset, controllerScreenshot.size.width - padding * 2, controllerScreenshot.size.height - padding * 2 - 20)];
    fadedView.image = controllerScreenshot;
    fadedView.alpha = 0.4;
    [coverView addSubview:fadedView];
    
    UIImageView *leftCurtain = [[UIImageView alloc] initWithFrame:CGRectNull];
    leftCurtain.image = selfPortrait;
    leftCurtain.clipsToBounds = YES;
    
    UIImageView *rightCurtain = [[UIImageView alloc] initWithFrame:CGRectNull];
    rightCurtain.image = selfPortrait;
    rightCurtain.clipsToBounds = YES;
    
    if (transitionStyle == RECurtainTransitionHorizontal) {
        leftCurtain.contentMode = UIViewContentModeLeft;
        leftCurtain.frame = CGRectMake(0, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
        rightCurtain.contentMode = UIViewContentModeRight;
        rightCurtain.frame = CGRectMake(selfPortrait.size.width / 2, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
    } else {
        leftCurtain.contentMode = UIViewContentModeTop;
        leftCurtain.frame = CGRectMake(0, 0, selfPortrait.size.width, selfPortrait.size.height / 2);
        rightCurtain.contentMode = UIViewContentModeBottom;
        rightCurtain.frame = CGRectMake(0, selfPortrait.size.height / 2, selfPortrait.size.width, selfPortrait.size.height / 2);
    }
    
    [coverView addSubview:leftCurtain];
    [coverView addSubview:rightCurtain];
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseIn animations:^{
        if (transitionStyle == RECurtainTransitionHorizontal) {
            leftCurtain.frame = CGRectMake(- selfPortrait.size.width / 2, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
            rightCurtain.frame = CGRectMake(selfPortrait.size.width, 0, selfPortrait.size.width / 2, selfPortrait.size.height);
        } else {
            leftCurtain.frame = CGRectMake(0, - selfPortrait.size.height / 2, selfPortrait.size.width, selfPortrait.size.height / 2);
            rightCurtain.frame = CGRectMake(0, selfPortrait.size.height, selfPortrait.size.width, selfPortrait.size.height / 2);
        }
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationCurveEaseIn animations:^{
        fadedView.frame = CGRectMake(0, offset, controllerScreenshot.size.width, controllerScreenshot.size.height);
        fadedView.alpha = 1;
    } completion:^(BOOL finished){
//        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//        appDelegate.window.rootViewController = viewControllerToReveal;
        [sender.navigationController pushViewController:viewControllerToReveal animated:NO];
        [leftCurtain removeFromSuperview];
        [rightCurtain removeFromSuperview];
        [fadedView removeFromSuperview];
        [coverView removeFromSuperview];
    }];
}

@end
