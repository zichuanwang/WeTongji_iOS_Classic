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

#define TOAST_VIEW_WIDTH    205.0f
#define TOAST_VIEW_HEIGHT   32.0f

#define SCREEN_WIDTH    320.0f
#define SCREEN_HEIGHT   480.0f

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

- (void)presentModalViewController:(UIViewController *)vc
{
    if (_modalViewController)
        return;
    
	//_modalViewController = [vc retain];
	
    _modalViewController = vc;
	_backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	_backView.backgroundColor = [UIColor clearColor];
    
    CGRect frame = vc.view.frame;
    frame.origin.x = 0;
    frame.origin.y = 460;
    vc.view.frame = frame;
    
	[[self rootView] addSubview:_backView];
	[[self rootView] addSubview:vc.view];
	
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect frame = vc.view.frame;
        frame.origin.y = 0;
        vc.view.frame = frame;
    } completion:^(BOOL finished) {}];
}

- (void)dismissModalViewController
{
    [UIView animateWithDuration:kAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
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

- (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y andTime:(float)time isError:(BOOL)isError
{
    if(_isShowingToast)
        return;
    _isShowingToast = YES;
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - TOAST_VIEW_WIDTH) / 2, y, TOAST_VIEW_WIDTH, TOAST_VIEW_HEIGHT)];
    if(isError)
        bgImageView.image = [UIImage imageNamed:@"toast_bg_red@2x.png"];
    else
        bgImageView.image = [UIImage imageNamed:@"toast_bg_green.png"];
    
    UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TOAST_VIEW_WIDTH - 8.0f, TOAST_VIEW_HEIGHT)];
    labelView.center = CGPointMake(TOAST_VIEW_WIDTH / 2 + 2.0f, TOAST_VIEW_HEIGHT / 2 - 3.0f);
    labelView.font = [UIFont boldSystemFontOfSize:14.0f];
    labelView.minimumFontSize = 10.0f;
    labelView.adjustsFontSizeToFitWidth = YES;
    labelView.text = text;
    labelView.backgroundColor = [UIColor clearColor];
    labelView.textColor = [UIColor whiteColor];
    labelView.shadowColor = [UIColor darkGrayColor];
    labelView.shadowOffset = CGSizeMake(0, 1.0f);
    labelView.textAlignment = UITextAlignmentCenter;
    
    [bgImageView addSubview:labelView];
    [self.keyWindow addSubview:bgImageView];
    
    labelView.alpha = 0;
    bgImageView.alpha = 0;
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        labelView.alpha = 1;
        bgImageView.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:time options:UIViewAnimationOptionCurveEaseInOut animations:^{
            labelView.alpha = 0;
            bgImageView.alpha = 0;
        } completion:^(BOOL finished) {
            [bgImageView removeFromSuperview];
            _isShowingToast = NO;
        }];
    }];
}

- (void)presentErrorToast:(NSString *)text withVerticalPos:(CGFloat)y {
    [self presentToast:text withVerticalPos:y andTime:1.2f isError:YES];
}

- (void)presentToast:(NSString *)text withVerticalPos:(CGFloat)y {
    [self presentToast:text withVerticalPos:y andTime:1.2f isError:NO];
}

- (void)presentToastwithShortInterval:(NSString *)text withVerticalPos:(CGFloat)y {
       [self presentToast:text withVerticalPos:y andTime:0.5f isError:NO];
}


@end
