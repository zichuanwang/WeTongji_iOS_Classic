//
//  WTDockButton.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WTDockButton.h"

#define BUTTON_COVER_REAL_WIDTH   100
#define BUTTON_COVER_REAL_HEIGHT  100

@implementation WTDockButton

@synthesize titleLabel = _titleLabel;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, BUTTON_REAL_HEIGHT)];
    if(self) {
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:highlightedImage forState:UIControlStateHighlighted];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, 20)];
        self.titleLabel.center = CGPointMake(BUTTON_REAL_WIDTH / 2, BUTTON_REAL_HEIGHT * 4 / 5);
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.shadowOffset = CGSizeMake(0, 1);
        
        UIImageView *buttonCover = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_COVER_REAL_WIDTH, BUTTON_COVER_REAL_HEIGHT)];

        buttonCover.image = [UIImage imageNamed:@"dock_btn_cover@2x.png"];
        buttonCover.center = CGPointMake(BUTTON_REAL_WIDTH / 2, BUTTON_REAL_HEIGHT / 2);
        
        [self addSubview:buttonCover];
        [self addSubview:self.titleLabel];
    }
    return self;
}

@end
