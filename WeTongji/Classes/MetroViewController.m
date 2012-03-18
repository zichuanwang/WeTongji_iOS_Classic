//
//  MetroViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MetroViewController.h"
#import "RootView.h"

#define BUTTON_WIDTH        70
#define BUTTON_HEIGHT       67
#define BUTTON_REAL_WIDTH   70
#define BUTTON_REAL_HEIGHT  75

#define BUTTON_HORIZONTAL_INTERVAL  8
#define BUTTON_VERTICAL_INTERVAL    8
#define BUTTON_HORIZONTAL_OFFSET    8
#define BUTTON_VERTICAL_OFFSET      9

#define BUTTON_COUNT    24

#define SCROLL_VIEW_SHRINK_POS_Y    100
#define SCROLL_VIEW_SPREAD_POS_Y    100
#define SCROLL_HEADER_VIEW_HEIGHT   (460 - BUTTON_HEIGHT - BUTTON_VERTICAL_OFFSET - BUTTON_VERTICAL_INTERVAL)

@interface MetroViewController ()

@property (strong, nonatomic) NSMutableArray *buttonHeap;
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
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, BUTTON_REAL_WIDTH, BUTTON_REAL_HEIGHT)];
        CGRect frame = button.frame;
        int j = i % 4;
        int k = i / 4;
        frame.origin.x = BUTTON_HORIZONTAL_OFFSET + (BUTTON_HORIZONTAL_INTERVAL + BUTTON_WIDTH) * j;
        frame.origin.y = BUTTON_VERTICAL_OFFSET + (BUTTON_VERTICAL_INTERVAL + BUTTON_HEIGHT) * k + SCROLL_HEADER_VIEW_HEIGHT;
        button.frame = frame;
        [button setBackgroundImage:[UIImage imageNamed:@"dock_btn@2x.png"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        //button.backgroundColor = [UIColor colorWithRed:63.0f / 255.0f green:191.0f / 255.0f blue:237.0f / 255.0f alpha:1.0f];
        
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
        
    self.scrollView.contentOffset = CGPointMake(0, SCROLL_HEADER_VIEW_HEIGHT);
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
    NSLog(@"duration:%f", duration);
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
    NSLog(@"begin drag");
    _scrollViewStartTouch = YES;
    self.shrinking = NO;
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
    NSLog(@"end drag");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //[self adjustScrollViewAnimation];
    self.shrinking = NO;
}

@end
