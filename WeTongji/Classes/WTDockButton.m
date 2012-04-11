//
//  WTDockButton.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WTDockButton.h"
#import "UIImageView+Addition.h"

#define BUTTON_COVER_REAL_WIDTH   100
#define BUTTON_COVER_REAL_HEIGHT  100

@interface WTDockButton()

@property (strong, nonatomic) UIImageView *highlightedImageView;

@end

@implementation WTDockButton

@synthesize titleLabel = _titleLabel;
@synthesize highlightedImageView = _highlightedImageView;

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage title:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, BUTTON_REAL_HEIGHT)];
    if(self) {
        [self setImage:image forState:UIControlStateNormal];
        
        self.highlightedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, BUTTON_REAL_HEIGHT)];
        self.highlightedImageView.image = highlightedImage;
        self.highlightedImageView.alpha = 0;
        
        UIImageView *buttonCoverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, BUTTON_COVER_REAL_WIDTH, BUTTON_COVER_REAL_HEIGHT)];
        
        buttonCoverImageView.image = [UIImage imageNamed:@"dock_btn_cover@2x.png"];
        buttonCoverImageView.center = CGPointMake(BUTTON_REAL_WIDTH / 2, BUTTON_REAL_HEIGHT / 2);
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, 20)];
        self.titleLabel.center = CGPointMake(BUTTON_REAL_WIDTH / 2, BUTTON_REAL_HEIGHT * 4 / 5);
        self.titleLabel.text = title;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = UITextAlignmentCenter;
        self.titleLabel.shadowColor = [UIColor blackColor];
        self.titleLabel.shadowOffset = CGSizeMake(0, 1);
        
        [self addSubview:self.highlightedImageView];
        [self addSubview:buttonCoverImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    if(self.highlighted && !highlighted) {
        [self.highlightedImageView fadeOut];
    }
    else if(!self.highlighted && highlighted) {
        self.highlightedImageView.alpha = 1;
    }
    [super setHighlighted:highlighted];
}

@end
