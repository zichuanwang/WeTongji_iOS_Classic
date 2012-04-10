//
//  WTDockButton.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON_REAL_WIDTH   70
#define BUTTON_REAL_HEIGHT  70

@interface WTDockButton : UIButton

@property (strong, nonatomic) UILabel *titleLabel;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title;

@end
