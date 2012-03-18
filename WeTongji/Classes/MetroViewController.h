//
//  MetroViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetroViewController : UIViewController <UIScrollViewDelegate> {
    CGFloat _lastScrollContentOffsetY;
    BOOL _isScrollingDownward;
    BOOL _willScrollViewDecelerate;
    BOOL _scrollViewStartTouch;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBackgroundView;


@end
