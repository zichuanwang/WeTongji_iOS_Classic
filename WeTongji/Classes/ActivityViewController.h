//
//  ActivityViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataViewController.h"
#import "Activity.h"
#import "WTButton.h"

@interface ActivityViewController : CoreDataViewController

@property (nonatomic, weak) IBOutlet UIView *organizerView;
@property (nonatomic, weak) IBOutlet UILabel *organizerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *activityCategoryLabel;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UILabel *likeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *middleView;
@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet WTButton *favoriteButton;
@property (nonatomic, weak) IBOutlet WTButton *likeButton;
@property (nonatomic, weak) IBOutlet WTButton *scheduleButton;
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UIImageView *activityImageView;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarBgImageView;
@property (nonatomic, weak) IBOutlet UIImageView *tabBarSeperatorImageView;

- (id)initWithActivity:(Activity *)activity;
- (IBAction)didClickFavoriteButton:(UIButton *)sender;
- (IBAction)didClickLikeButton:(UIButton *)sender;
- (IBAction)didClickScheduleButton:(UIButton *)sender;

@end
