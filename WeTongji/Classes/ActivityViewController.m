//
//  ActivityViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ActivityViewController.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"
#import "UIApplication+Addition.h"
#import "NSNotificationCenter+Addition.h"
#import "WTClient.h"
#import "UIImageView+Addition.h"
#import "DetailImageViewController.h"
#import "UIImage+Addition.h"

#define ORGANIZER_NAME_LABEL_MAX_HEIGHT 38

@interface ActivityViewController ()

@property (nonatomic, strong) Activity *activity;
@property (nonatomic, strong) UIImage *activityOriginalImage;

@end

@implementation ActivityViewController

@synthesize organizerView = _organizerView;
@synthesize organizerNameLabel = _organizerNameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize placeLabel = _placeLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize activityCategoryLabel = _activityCategoryLabel;
@synthesize titleLabel = _titleLabel;
@synthesize scrollView = _scrollView;
@synthesize favoriteButton = _favoriteButton;
@synthesize likeButton = _likeButton;
@synthesize scheduleButton = _scheduleButton;
@synthesize likeLabel = _likeLabel;
@synthesize middleView = _middleView;
@synthesize bottomView = _bottomView;
@synthesize avatarImageView = _avatarImageView;
@synthesize activityImageView = _activityImageView;
@synthesize tabBarBgImageView = _tabBarBgImageView;
@synthesize tabBarSeperatorImageView = _tabBarSeperatorImageView;

@synthesize activity = _activity;
@synthesize activityOriginalImage = _activityOriginalImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureActivityView];
    [self configureTabBar];
    [self configureTabBarUIStyle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.organizerNameLabel = nil;
    self.timeLabel = nil;
    self.placeLabel = nil;
    self.descriptionLabel = nil;
    self.activityCategoryLabel = nil;
    self.titleLabel = nil;
    self.scrollView = nil;
    self.favoriteButton = nil;
    self.likeButton = nil;
    self.scheduleButton = nil;
    self.likeLabel = nil;
    self.middleView = nil;
    self.bottomView = nil;
    self.tabBarBgImageView = nil;
    self.tabBarSeperatorImageView = nil;
    self.avatarImageView = nil;
    self.activityImageView = nil;
    self.organizerView = nil;
}

- (id)initWithActivity:(Activity *)activity {
    self = [super init];
    if(self) {
        self.activity = activity;
    }
    return self;
}

#pragma mark -
#pragma mark custom setter & getter

#pragma mark -
#pragma mark Logic methods

- (BOOL)isCurrentUserValid {
    BOOL result = (self.currentUser != nil);
    if(result == NO)
        [UIApplication showAlertMessage:@"该功能需要配合个人帐号才能使用，请登录微同济。" withTitle:@"出错啦"];
    return result;
}

#pragma mark -
#pragma mark UI methods

- (void)configureTabBarUIStyle {
    UIStyle style = [NSUserDefaults getCurrentUIStyle];
    if(style == UIStyleBlackChocolate){
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg.png"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_three_interval_seperator"];
        [self.favoriteButton setImage:[UIImage imageNamed:@"channel_btn_favorite"] forState:UIControlStateNormal];
        [self.scheduleButton setImage:[UIImage imageNamed:@"channel_btn_schedule"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"channel_btn_like"] forState:UIControlStateNormal];
    } else if(style == UIStyleWhiteChocolate) {
        self.tabBarBgImageView.image = [UIImage imageNamed:@"main_tab_bar_bg_white.png"];
        self.tabBarSeperatorImageView.image = [UIImage imageNamed:@"main_tab_bar_three_interval_seperator_white"];
        [self.favoriteButton setImage:[UIImage imageNamed:@"channel_btn_favorite_white"] forState:UIControlStateNormal];
        [self.scheduleButton setImage:[UIImage imageNamed:@"channel_btn_schedule_white"] forState:UIControlStateNormal];
        [self.likeButton setImage:[UIImage imageNamed:@"channel_btn_like_white"] forState:UIControlStateNormal];
    }
}

- (void)configureActivityImage {
    if(self.activity.image_link) {
        [self.activityImageView loadImageFromURL:self.activity.image_link completion:^(BOOL succeed) {
            if(succeed) {
                CGSize imageSize = self.activityImageView.image.size;
                //NSLog(@"imageSize width:%f, height:%f", imageSize.width, imageSize.height);
                CGSize imageViewSize = self.activityImageView.frame.size;
                imageViewSize.height = imageViewSize.width / imageSize.width * imageSize.height;
                //NSLog(@"imageViewSize width:%f height:%f", imageViewSize.width, imageViewSize.height);
                CGRect imageViewFrame = self.activityImageView.frame;
                imageViewFrame.size = imageViewSize;
                self.activityImageView.frame = imageViewFrame;
                
                self.activityOriginalImage = self.activityImageView.image;
                self.activityImageView.image = [self.activityImageView.image compressImage];
                
                [self.activityImageView configureShadow];
                [self refreshViewLayout];
            }
        } cacheInContext:self.managedObjectContext];
    }
}

- (void)configureActivityMiddleView {
    self.titleLabel.text = self.activity.what;
    [self.titleLabel sizeToFit];
    self.descriptionLabel.text = self.activity.content;
    [self.descriptionLabel sizeToFit];
    CGRect rect = self.descriptionLabel.frame;
    rect.origin.y = self.titleLabel.frame.origin.y + self.titleLabel.frame.size.height + 10;
    self.descriptionLabel.frame = rect;
    
    [self configureActivityImage];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollView:)];
    [self.scrollView addGestureRecognizer:gr];
}

- (void)configureActivityTopView {
    [self.avatarImageView loadImageFromURL:self.activity.avatar_link cacheInContext:self.managedObjectContext];
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAvatarImageView:)];
    [self.avatarImageView addGestureRecognizer:gr];
    
    self.organizerNameLabel.text = self.activity.organizer;
    [self.organizerNameLabel sizeToFit];
    NSArray *channelNames = [NSUserDefaults getChannelNameArray];
    self.activityCategoryLabel.text = [NSString stringWithFormat:@"发表 %@", [channelNames objectAtIndex:self.activity.channel_id.intValue]];
    [self.activityCategoryLabel sizeToFit];
    
    CGFloat organizerLabelHeight = self.organizerNameLabel.frame.size.height;
    organizerLabelHeight = organizerLabelHeight > ORGANIZER_NAME_LABEL_MAX_HEIGHT ?  ORGANIZER_NAME_LABEL_MAX_HEIGHT : organizerLabelHeight;
    CGRect organizerNameFrame = self.organizerNameLabel.frame;
    organizerNameFrame.size.height = organizerLabelHeight;
    self.organizerNameLabel.frame = organizerNameFrame;
    
    CGRect categoryFrame = self.activityCategoryLabel.frame;
    
    CGRect organizerViewFrame = self.organizerView.frame;
    if(organizerViewFrame.size.height < organizerNameFrame.size.height + categoryFrame.size.height) {
        organizerViewFrame.size.height = organizerNameFrame.size.height + categoryFrame.size.height + 3;
        self.organizerView.frame = organizerViewFrame;
    }
    
    categoryFrame.origin.y = organizerViewFrame.size.height - categoryFrame.size.height;
    self.activityCategoryLabel.frame = categoryFrame;
}

- (void)configureActivityBottomView {
    self.timeLabel.text = [NSString timeConvertFromBeginDate:self.activity.begin_time endDate:self.activity.end_time];
    self.placeLabel.text = self.activity.where;
    
    [self updateLikeLabel];
}

- (void)configureActivityView {
    [self configureActivityTopView];
    [self configureActivityMiddleView];
    [self configureActivityBottomView];
    
    self.likeButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_like_hl.png"];
    self.favoriteButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_favorite_hl.png"];
    self.scheduleButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_schedule_hl.png"];
    
    [self refreshViewLayout];
}

- (void)updateLikeLabel {
    int likeCount = self.activity.like_count.intValue;
    if(likeCount > 0)
        self.likeLabel.text = [NSString stringWithFormat:@"%d 人喜欢这个活动", likeCount];
    else 
        self.likeLabel.text = [NSString stringWithFormat:@"喜欢这个活动就为它投一票吧！"];
}

- (void)configureTabBar {
    if(self.activity.can_favorite.boolValue == NO && self.currentUser) {
        [self.favoriteButton setSelected:YES];
    }
    if(self.activity.can_schedule.boolValue == NO && self.currentUser) {
        [self.scheduleButton setSelected:YES];
    }
    if(self.activity.can_like.boolValue == NO && self.currentUser) {
        [self.likeButton setSelected:YES];
    }
}

- (void)refreshViewLayout {
    CGRect middleFrame = self.middleView.frame;
    middleFrame.size.height = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height;
    if(self.activityImageView.image != nil) {
        CGRect imageViewFrame = self.activityImageView.frame;
        imageViewFrame.origin.y = middleFrame.size.height + 10;
        middleFrame.size.height += imageViewFrame.size.height + 25;
        self.activityImageView.frame = imageViewFrame;
    } else {
        middleFrame.size.height += 15;
    }
    self.middleView.frame = middleFrame;
    
    self.middleView.image = [[UIImage imageNamed:@"paper_main"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.y = middleFrame.origin.y + middleFrame.size.height;
    self.bottomView.frame = bottomFrame;
    
    CGFloat scrollContentHeight = bottomFrame.origin.y + bottomFrame.size.height;
    scrollContentHeight = scrollContentHeight > self.scrollView.frame.size.height ? scrollContentHeight : self.scrollView.frame.size.height + 1;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, scrollContentHeight);
}

#pragma mark - 
#pragma mark IBActions 

- (IBAction)didClickFavoriteButton:(UIButton *)sender {
    if(![self isCurrentUserValid])
        return;
    BOOL select = !sender.selected;
    [self.favoriteButton setSelected:select];
    
    WTClient *client = [WTClient client];
    sender.userInteractionEnabled = NO;
    if(select) {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_favorite = [NSNumber numberWithBool:!self.activity.can_favorite.boolValue];
                [UIApplication presentToast:@"已添加到收藏。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.favoriteButton setSelected:NO];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client favoriteActivity:self.activity.activity_id];
    }
    else {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_favorite = [NSNumber numberWithBool:!self.activity.can_favorite.boolValue];
                [self.currentUser removeFavorObject:self.activity];
                [UIApplication presentToast:@"已移出收藏。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.favoriteButton setSelected:YES];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client unfavoriteActivity:self.activity.activity_id];
    }
}

- (IBAction)didClickLikeButton:(UIButton *)sender {
    if(![self isCurrentUserValid])
        return;
    BOOL select = !sender.selected;
    [self.likeButton setSelected:select];
    
    WTClient *client = [WTClient client];
    sender.userInteractionEnabled = NO;
    if(select) {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_like = [NSNumber numberWithBool:!self.activity.can_like.boolValue];
                self.activity.like_count = [NSNumber numberWithInt:self.activity.like_count.intValue + 1];
                [self updateLikeLabel];
                [UIApplication presentToast:@"你赞了这个活动。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.likeButton setSelected:NO];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client likeActivity:self.activity.activity_id];
    }
    else {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_like = [NSNumber numberWithBool:!self.activity.can_like.boolValue];
                self.activity.like_count = [NSNumber numberWithInt:self.activity.like_count.intValue - 1];
                [self updateLikeLabel];
                [UIApplication presentToast:@"你取消了赞这个活动。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.likeButton setSelected:YES];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client unlikeActivity:self.activity.activity_id];
    }
}

- (IBAction)didClickScheduleButton:(UIButton *)sender {
    if(![self isCurrentUserValid])
        return;
    BOOL select = !sender.selected;
    [self.scheduleButton setSelected:select];
    
    WTClient *client = [WTClient client];
    sender.userInteractionEnabled = NO;
    if(select) {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_schedule = [NSNumber numberWithBool:!self.activity.can_schedule.boolValue];
                [self.currentUser addScheduleObject:self.activity];
                [NSNotificationCenter postChangeScheduleNotification];
                [UIApplication presentToast:@"已添加到日程。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.scheduleButton setSelected:NO];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client scheduleActivity:self.activity.activity_id];
    }
    else {
        [client setCompletionBlock:^(WTClient *client) {
            if(!client.hasError) {
                self.activity.can_schedule = [NSNumber numberWithBool:!self.activity.can_schedule.boolValue];
                [self.currentUser removeScheduleObject:self.activity];
                [NSNotificationCenter postChangeScheduleNotification];
                [UIApplication presentToast:@"已移出日程。" withVerticalPos:DefaultToastVerticalPosition];
            } else {
                [self.scheduleButton setSelected:YES];
                [UIApplication presentAlertToast:@"操作失败。" withVerticalPos:DefaultToastVerticalPosition];
            }
            sender.userInteractionEnabled = YES;
        }];
        [client unscheduleActivity:self.activity.activity_id];
    }
}

- (void)didTapScrollView:(UIGestureRecognizer *)gestureRecognizer {
    if(self.activityImageView.image != nil) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.scrollView];
        CGRect frame = self.activityImageView.frame;
        frame.origin.y += self.middleView.frame.origin.y;
        if(CGRectContainsPoint(frame, touchPoint)) {
            [DetailImageViewController showDetailImageWithImage:self.activityOriginalImage];
        }
    }
}

- (void)didTapAvatarImageView:(UIGestureRecognizer *)gestureRecognizer {
    if(self.avatarImageView.image != nil) {
        [DetailImageViewController showDetailImageWithImage:self.avatarImageView.image];
    }
}

@end