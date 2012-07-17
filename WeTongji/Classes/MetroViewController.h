//
//  MetroViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MetroViewController : UIViewController <UIScrollViewDelegate> {
    CGFloat _lastScrollContentOffsetY;
    BOOL _isScrollingDownward;
    BOOL _willScrollViewDecelerate;
    BOOL _scrollViewStartTouch;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *scrollBackgroundView;
@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;
@property (nonatomic, weak) IBOutlet UIImageView *shadowImageView;
@property (nonatomic, weak) IBOutlet UIView *blackBgView;

@end
