//
//  ChannelDetailViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"
#import "Activity.h"

@interface ChannelDetailViewController : WTNavigationViewController

@property (nonatomic, strong) IBOutlet UILabel *organizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *subOrganizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *placeLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *activityCategoryLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

- (id)initWithActivity:(Activity *)activity;

@end
