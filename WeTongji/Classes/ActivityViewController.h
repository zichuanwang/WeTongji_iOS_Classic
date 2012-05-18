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

@property (nonatomic, strong) IBOutlet UILabel *organizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *subOrganizerNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *placeLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *activityCategoryLabel;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *likeLabel;
@property (nonatomic, strong) IBOutlet UIView *middleView;
@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet WTButton *favoriteButton;
@property (nonatomic, strong) IBOutlet WTButton *likeButton;
@property (nonatomic, strong) IBOutlet WTButton *scheduleButton;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarBgImageView;
@property (nonatomic, strong) IBOutlet UIImageView *tabBarSeperatorImageView;

- (id)initWithActivity:(Activity *)activity;
- (IBAction)didClickFavoriteButton:(UIButton *)sender;
- (IBAction)didClickLikeButton:(UIButton *)sender;
- (IBAction)didClickScheduleButton:(UIButton *)sender;

@end
