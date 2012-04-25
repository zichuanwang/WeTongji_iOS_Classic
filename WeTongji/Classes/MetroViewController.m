//
//  MetroViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MetroViewController.h"
#import "RootView.h"
#import "WTDockButton.h"
#import "ChannelViewController.h"

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

@interface MetroViewController ()

@property (nonatomic, strong) NSMutableArray *buttonHeap;
@property (readonly, nonatomic) CGFloat scrollViewHeight;

@property (getter = isShrink, nonatomic) BOOL shrink;
@property (getter = isShrinking, nonatomic) BOOL shrinking;

- (void)refreshScrollViewContentHeight;

@end

@implementation MetroViewController

@synthesize scrollView = _scrollView;
@synthesize buttonHeap = _buttonHeap;
@synthesize scrollBackgroundView = _scrollBackgroundView;

@synthesize shrink = _shrink;
@synthesize shrinking = _shrinking;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.buttonHeap =  [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    for(int i = 0; i < BUTTON_COUNT; i++) {
        WTButton *button = nil;
        if(i == 0) {
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_channel.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_channel_hl.png"] title:@"频道"];
            [button addTarget:self action:@selector(didClickChannelButton:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if(i == 1)
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_news.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_news_hl.png"] title:@"新闻"];
        else if(i == 2)
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_collect.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_collect_hl.png"] title:@"收藏"];
        else if(i == 3)
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_schedule.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_schedule_hl.png"] title:@"日程"];
        else if(i == 4)
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_circles.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_circles_hl.png"] title:@"圈子"];
        else if(i == 5)
            button = [[WTDockButton alloc] initWithImage:[UIImage imageNamed:@"dock_btn_mail.png"] highlightedImage:[UIImage imageNamed:@"dock_btn_mail_hl.png"] title:@"邮箱"];
        else 
            button = [[WTDockButton alloc] initWithImage:nil highlightedImage:nil title:@""];
        
        CGPoint center = button.center;
        int j = i % 4;
        int k = i / 4;
        
        center.x = BUTTON_HORIZONTAL_OFFSET + (BUTTON_HORIZONTAL_INTERVAL + BUTTON_WIDTH) * j + BUTTON_WIDTH / 2;
        center.y = BUTTON_VERTICAL_OFFSET + (BUTTON_VERTICAL_INTERVAL + BUTTON_HEIGHT) * k + SCROLL_HEADER_VIEW_HEIGHT + BUTTON_HEIGHT / 2;
        button.center = center;

        [self.scrollView addSubview:button];
        [self.buttonHeap addObject:button];
    }
    
    CGRect frame = self.scrollBackgroundView.frame;
    frame.origin.y = SCROLL_HEADER_VIEW_HEIGHT;
    self.scrollBackgroundView.frame = frame;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320.0f, SCROLL_HEADER_VIEW_HEIGHT)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.tag = ROOT_METRO_SCROLL_HEADER_VIEW_TAG;
    [self.scrollView addSubview:headerView];
        
    //self.scrollView.contentOffset = CGPointMake(0, SCROLL_HEADER_VIEW_HEIGHT);
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self refreshScrollViewContentHeight];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)refreshScrollViewContentHeight {
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollViewHeight);
    CGRect frame = self.scrollBackgroundView.frame;
    frame.size.height = self.scrollViewHeight + 460.0f;
    self.scrollBackgroundView.frame = frame;
}

#pragma mark -
#pragma mark Animations

- (void)shrinkAnimation {
    [UIView animateWithDuration:0.2f animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        self.shrinking = NO;
    }];
}

- (void)spreadAnimation {
    float duration = _willScrollViewDecelerate ? 0.1f : 0.2f;
    [UIView animateWithDuration:duration animations:^{
        self.scrollView.contentOffset = CGPointMake(0, SCROLL_HEADER_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        if(!self.scrollView.isDecelerating)
            self.shrinking = NO;
        self.scrollView.userInteractionEnabled = YES;
    }];
}

- (void)adjustScrollViewAnimation {
    if(!self.isShrink) {
        [self spreadAnimation];
    }
}

#pragma mark -
#pragma mark Properties 

- (CGFloat)scrollViewHeight {
    NSInteger k = self.buttonHeap.count / 4 + (self.buttonHeap.count % 4 == 0 ? 0 : 1);
    CGFloat result = BUTTON_VERTICAL_OFFSET + (BUTTON_HEIGHT + BUTTON_VERTICAL_INTERVAL) * k + SCROLL_HEADER_VIEW_HEIGHT;
    if(result < 460.0f + SCROLL_HEADER_VIEW_HEIGHT)
        result = 460.0f + SCROLL_HEADER_VIEW_HEIGHT;
    return result;
}

- (void)setShrink:(BOOL)shrink {
    _shrink = shrink;
    self.shrinking = YES;
    
    if(shrink) {
        [self shrinkAnimation];
    }
    else {
        [self spreadAnimation];
    }
}

- (void)setShrinking:(BOOL)shrinking {
    _shrinking = shrinking;
    if(shrinking)
        self.scrollView.userInteractionEnabled = NO;
    else 
        self.scrollView.userInteractionEnabled = YES;
}

#pragma mark -
#pragma mark UIScrollView delegate 

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _scrollViewStartTouch = YES;
    self.shrinking = NO;
    [self refreshScrollViewContentHeight];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat posY = scrollView.contentOffset.y;
    _isScrollingDownward = posY < _lastScrollContentOffsetY;
    //NSLog(@"posY:%f, last:%f", posY, _lastScrollContentOffsetY);
    _lastScrollContentOffsetY = posY;
    if(posY > SCROLL_HEADER_VIEW_HEIGHT && !self.shrink && self.isShrinking && !_scrollViewStartTouch) {
        self.scrollView.contentOffset = CGPointMake(0, SCROLL_HEADER_VIEW_HEIGHT);
    }
    else if(posY < SCROLL_HEADER_VIEW_HEIGHT && !self.shrink && self.scrollView.isDecelerating && !_scrollViewStartTouch) {
        self.scrollView.contentOffset = CGPointMake(0, SCROLL_HEADER_VIEW_HEIGHT);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _willScrollViewDecelerate = decelerate;
    if(_lastScrollContentOffsetY < SCROLL_HEADER_VIEW_HEIGHT)
        self.shrink = _isScrollingDownward;
    _scrollViewStartTouch = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //[self adjustScrollViewAnimation];
    self.shrinking = NO;
}

- (void)didClickChannelButton:(UIButton *)sender {
    ChannelViewController *channel = [[ChannelViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channel];
    [self presentModalViewController:nav animated:YES];
}

@end
