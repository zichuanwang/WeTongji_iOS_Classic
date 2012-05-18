//
//  UIApplication+Addition.m
//  SocialFusion
//
//  Created by 王紫川 on 12-1-30.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "UIApplication+Addition.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

static UIViewController *_modalViewController;
static UIView *_backView;
static BOOL _isShowingToast;

#define TOAST_VIEW_WIDTH    180.0f
#define TOAST_VIEW_HEIGHT   50.0f
#define LONG_TOAST_VIEW_WIDTH    210.0f

#define SCREEN_WIDTH    320.0f
#define SCREEN_HEIGHT   480.0f

#define DefaultModelViewControllerAnimationDuration 0.25f

@implementation UIApplication (Addition)

- (UIView *)rootView
{
    return self.rootViewController.view;
}

- (UIViewController *)rootViewController
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return (UIViewController *)appDelegate.window.rootViewController;
}

+ (void)presentModalViewController:(UIViewController *)vc animated:(BOOL)animated {
    [[UIApplication sharedApplication] presentModalViewController:vc animated:animated];
}

+ (void)dismissModalViewController {
    [[UIApplication sharedApplication] dismissModalViewController];
}

- (void)presentModalViewController:(UIViewController *)vc animated:(BOOL)animated
{
    if (_modalViewController)
        return;
    
	//_modalViewController = [vc retain];
	
    _modalViewController = vc;
	_backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	_backView.backgroundColor = [UIColor clearColor];
    
	[self.keyWindow addSubview:_backView];
	[self.keyWindow addSubview:vc.view];
    
    if(animated) {
        CGRect frame = vc.view.frame;
        frame.origin.x = 0;
        frame.origin.y = 480;
        vc.view.frame = frame;
        
        [UIView animateWithDuration:DefaultModelViewControllerAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect frame = vc.view.frame;
            frame.origin.y = 0;
            vc.view.frame = frame;
        } completion:nil];
    }
    else {
        CGRect frame = vc.view.frame;
        frame.origin.y = 0;
        vc.view.frame = frame;
    }
        
}

- (void)dismissModalViewController
{
    [UIView animateWithDuration:DefaultModelViewControllerAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _backView.alpha = 0.0;
        CGRect frame = _modalViewController.view.frame;
        frame.origin.y = SCREEN_HEIGHT;
        _modalViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
			[_backView removeFromSuperview];
            //[_backView release];
            _backView = nil;
			//[_modalViewController release];
            _modalViewController = nil;
		}
    }];
}

- (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y andTime:(float)time isAlert:(BOOL)isAlert {
    UIImage *bgImage = nil;
    BOOL isLong = text.length > 12;
    if(isLong) {
        if(isAlert)
            bgImage = [UIImage imageNamed:@"toast_long_alert_bg.png"];
        else
            bgImage = [UIImage imageNamed:@"toast_long_normal_bg.png"];
    }
    else {
        if(isAlert)
            bgImage = [UIImage imageNamed:@"toast_alert_bg.png"];
        else
            bgImage = [UIImage imageNamed:@"toast_normal_bg.png"];
    }
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
    bgImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, y);
    
    CGFloat labelWidth = isLong ? LONG_TOAST_VIEW_WIDTH : TOAST_VIEW_WIDTH;
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, TOAST_VIEW_HEIGHT)];
    labelView.center = CGPointMake(bgImageView.frame.size.width / 2, bgImageView.frame.size.height / 2);
    
    labelView.font = [UIFont boldSystemFontOfSize:14.0f];
    labelView.minimumFontSize = 14.0f;
    labelView.text = text;
    labelView.backgroundColor = [UIColor clearColor];
    labelView.textColor = [UIColor whiteColor];
    labelView.shadowColor = [UIColor darkGrayColor];
    labelView.shadowOffset = CGSizeMake(0, 1.0f);
    labelView.textAlignment = UITextAlignmentCenter;
    
    [bgImageView addSubview:labelView];
    [self.keyWindow addSubview:bgImageView];
    
    void (^ completion)(BOOL finished) = ^ (BOOL finished){
        [UIView animateWithDuration:0.3f delay:time options:UIViewAnimationOptionCurveEaseInOut animations:^{
            labelView.alpha = 0;
            bgImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgImageView removeFromSuperview];
            _isShowingToast = NO;
        }];
    };
    
    if(!_isShowingToast) {
        
        labelView.alpha = 0;
        bgImageView.alpha = 0;
        
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            labelView.alpha = 1;
            bgImageView.alpha = 1;
        } completion:completion];
    }
    else
        completion(YES);
    
    _isShowingToast = YES;
}

+ (void)presentAlertToast:(NSString *)text withVerticalPos:(CGFloat)y {
    [[UIApplication sharedApplication] presentToast:text withVerticalPos:y andTime:0.7f isAlert:YES];
}

+ (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y {
    [[UIApplication sharedApplication] presentToast:text withVerticalPos:y andTime:0.7f isAlert:NO];
}

+ (void)showAlertMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil 
                                          cancelButtonTitle:@"关闭"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
