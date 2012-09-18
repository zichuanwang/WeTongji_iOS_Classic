//  Created by Ziqi on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum _RECurtainTransitionStyle {
	RECurtainTransitionHorizontal = 0,
    RECurtainTransitionVertical = 1
} RECurtainTransitionStyle;

@interface UIViewController (RECurtainViewController)

- (void)curtainRevealViewController:(UIViewController *)viewControllerToReveal fromViewController:(UIViewController *)sender transitionStyle:(RECurtainTransitionStyle)transitionStyle;

@end
