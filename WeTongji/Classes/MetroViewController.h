//
//  MetroViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON_WIDTH        70
#define BUTTON_HEIGHT       70

#define BUTTON_HORIZONTAL_INTERVAL  8
#define BUTTON_VERTICAL_INTERVAL    6
#define BUTTON_HORIZONTAL_OFFSET    8
#define BUTTON_VERTICAL_OFFSET      5

#define BUTTON_COUNT    24

#define SCROLL_VIEW_SHRINK_POS_Y    100
#define SCROLL_VIEW_SPREAD_POS_Y    100
#define SCROLL_HEADER_VIEW_HEIGHT   (460 - BUTTON_HEIGHT - BUTTON_VERTICAL_OFFSET - BUTTON_VERTICAL_INTERVAL)

#define DOCK_VIEW_HEIGHT   (BUTTON_HEIGHT + BUTTON_VERTICAL_OFFSET + BUTTON_VERTICAL_INTERVAL)

@interface MetroViewController : UIViewController <UIScrollViewDelegate> {
    CGFloat _lastScrollContentOffsetY;
    BOOL _isScrollingDownward;
    BOOL _willScrollViewDecelerate;
    BOOL _scrollViewStartTouch;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBackgroundView;


@end
