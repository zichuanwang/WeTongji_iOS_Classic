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

@interface ActivityViewController ()

@property (nonatomic, strong) Activity *activity;

@end

@implementation ActivityViewController

@synthesize organizerNameLabel = _organizerNameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize placeLabel = _placeLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize activityCategoryLabel = _activityCategoryLabel;
@synthesize titleLabel = _titleLabel;
@synthesize scrollView = _scrollView;
@synthesize subOrganizerNameLabel = _subOrganizerNameLabel;
@synthesize favoriteButton = _favoriteButton;
@synthesize likeButton = _likeButton;
@synthesize scheduleButton = _scheduleButton;
@synthesize likeLabel = _likeLabel;
@synthesize middleView = _middleView;
@synthesize bottomView = _bottomView;
@synthesize tabBarBgImageView = _tabBarBgImageView;
@synthesize tabBarSeperatorImageView = _tabBarSeperatorImageView;

@synthesize activity = _activity;

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
    self.subOrganizerNameLabel = nil;
    self.favoriteButton = nil;
    self.likeButton = nil;
    self.scheduleButton = nil;
    self.likeLabel = nil;
    self.middleView = nil;
    self.bottomView = nil;
    self.tabBarBgImageView = nil;
    self.tabBarSeperatorImageView = nil;
}

- (id)initWithActivity:(Activity *)activity {
    self = [super init];
    if(self) {
        self.activity = activity;
    }
    return self;
}

#pragma mark -
#pragma mark Logic methods

- (BOOL)isCurrentUserValid {
    BOOL result = (self.currentUser != nil);
    if(result == NO)
        [UIApplication showAlertMessage:@"该功能需要配合个人账号才能使用，请登录微同济。" withTitle:@"出错啦"];
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

- (void)configureActivityView {
    self.titleLabel.text = self.activity.title;
    self.descriptionLabel.text = self.activity.content;
    [self.descriptionLabel sizeToFit];
    CGRect rect = self.descriptionLabel.frame;
    self.descriptionLabel.frame = rect;
    
    self.organizerNameLabel.text = self.activity.organizer;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + 1);
    self.timeLabel.text = [NSString timeConvertFromBeginDate:self.activity.begin_time endDate:self.activity.end_time];
    self.placeLabel.text = self.activity.location;
    self.subOrganizerNameLabel.text = self.activity.sub_organizer;
    NSArray *channelNames = [NSUserDefaults getChannelNameArray];
    self.activityCategoryLabel.text = [NSString stringWithFormat:@"发表%@", [channelNames objectAtIndex:self.activity.channel_id.intValue]];
    
    self.likeButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_like_hl.png"];
    self.favoriteButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_favorite_hl.png"];
    self.scheduleButton.highlightedImageView.image = [UIImage imageNamed:@"channel_btn_schedule_hl.png"];
    int likeCount = self.activity.like_count.intValue;
    if(likeCount > 0)
        self.likeLabel.text = [NSString stringWithFormat:@"%d 人喜欢这个活动", likeCount];
    else 
        self.likeLabel.text = [NSString stringWithFormat:@"喜欢这个活动就为它投一票吧！"];
    
    [self refreshViewLayout];
}

- (void)configureTabBar {
    if([self.currentUser.favor containsObject:self.activity]) {
        [self.favoriteButton setSelected:YES];
    }
    if([self.currentUser.schedule containsObject:self.activity]) {
        [self.scheduleButton setSelected:YES];
    }
}

- (void)refreshViewLayout {
    CGRect middleFrame = self.middleView.frame;
    middleFrame.size.height = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height + 15;
    self.middleView.frame = middleFrame;
    
    self.middleView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_main.png"]];
    
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
    if(select) {
        [self.currentUser addFavorObject:self.activity];
        [UIApplication presentToast:@"已添加到收藏。" withVerticalPos:DefaultToastVerticalPosition];
    }
    else {
        [self.currentUser removeFavorObject:self.activity];
        [UIApplication presentToast:@"已移出收藏。" withVerticalPos:DefaultToastVerticalPosition];
    }
}

- (IBAction)didClickLikeButton:(UIButton *)sender {
    if(![self isCurrentUserValid])
        return;
    BOOL select = !sender.selected;
    [self.likeButton setSelected:select];
    if(select) {
        [UIApplication presentToast:@"你赞了这个活动。" withVerticalPos:DefaultToastVerticalPosition];
    }
    else {
        [UIApplication presentToast:@"你取消赞这个活动。" withVerticalPos:DefaultToastVerticalPosition];
    }
}
- (IBAction)didClickScheduleButton:(UIButton *)sender {
    if(![self isCurrentUserValid])
        return;
    BOOL select = !sender.selected;
    [self.scheduleButton setSelected:select];
    if(select) {
        [self.currentUser addScheduleObject:self.activity];
        [UIApplication presentToast:@"已添加到日程。" withVerticalPos:DefaultToastVerticalPosition];
    }
    else {
        [self.currentUser removeScheduleObject:self.activity];
        [UIApplication presentToast:@"已移出日程。" withVerticalPos:DefaultToastVerticalPosition];
    }
}

@end
