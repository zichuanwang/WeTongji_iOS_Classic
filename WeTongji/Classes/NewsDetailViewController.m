//
//  NewsDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NSString+Addition.h"
#import "UIImageView+Addition.h"
#import "UIImage+Addition.h"
#import "DetailImageViewController.h"

@interface NewsDetailViewController ()

@property (nonatomic, strong) News *news;
@property (nonatomic, strong) UIImage *newsOriginalImage;

@end

@implementation NewsDetailViewController

@synthesize news = _news;
@synthesize middleView = _middleView;
@synthesize scrollView = _scrollView;
@synthesize titleLabel = _titleLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize publicationTimeLabel = _publicationTimeLabel;
@synthesize newsCategoryLabel = _newsCategoryLabel;
@synthesize titleView = _titleView;
@synthesize newsImageView = _newsImageView;
@synthesize newsOriginalImage = _newsOriginalImage;
@synthesize bottomView = _bottomView;

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
    [self configureNavBar];
    [self configureNewsView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.middleView = nil;
    self.scrollView = nil;
    self.titleLabel = nil;
    self.descriptionLabel = nil;
    self.publicationTimeLabel = nil;
    self.newsCategoryLabel = nil;
    self.titleView = nil;
    self.newsImageView = nil;
    self.bottomView = nil;
}

- (id)initWithNews:(News *)news {
    self = [super init];
    if(self) {
        self.news = news;
    }
    return self;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"新闻详情"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureNewsView {
    self.titleLabel.text = self.news.title;
    [self.titleLabel sizeToFit];
    
    self.newsCategoryLabel.text = [NSString stringWithFormat:@"%@", self.news.category];
    self.publicationTimeLabel.text = [NSString stringWithFormat:@"发表于 %@", [NSString yearMonthDayConvertFromDate:self.news.create_at]];
    
    CGFloat titleHeight = self.titleLabel.frame.size.height;
    CGFloat otherHeight = self.titleView.frame.size.height - self.newsCategoryLabel.frame.origin.y;
    CGFloat titleViewHeight = titleHeight + otherHeight + 5;
    CGRect titleViewFrame = self.titleView.frame;
    titleViewFrame.size.height = titleViewHeight;
    self.titleView.frame = titleViewFrame;
    
    self.descriptionLabel.text = self.news.content;
    [self.descriptionLabel sizeToFit];
    CGRect descriptionFrame = self.descriptionLabel.frame;
    descriptionFrame.origin.y = titleViewFrame.origin.y + titleViewFrame.size.height + 10;
    self.descriptionLabel.frame = descriptionFrame;
    
    [self configureNewsImage];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapScrollView:)];
    [self.scrollView addGestureRecognizer:gr];
    
    [self refreshViewLayout];
}

- (void)configureNewsImage {
    if(self.news.image_link) {
        [self.newsImageView loadImageFromURL:self.news.image_link completion:^(BOOL succeed) {
            if(succeed) {
                CGSize imageSize = self.newsImageView.image.size;
                //NSLog(@"imageSize width:%f, height:%f", imageSize.width, imageSize.height);
                CGSize imageViewSize = self.newsImageView.frame.size;
                imageViewSize.height = imageViewSize.width / imageSize.width * imageSize.height;
                //NSLog(@"imageViewSize width:%f height:%f", imageViewSize.width, imageViewSize.height);
                CGRect imageViewFrame = self.newsImageView.frame;
                imageViewFrame.size = imageViewSize;
                self.newsImageView.frame = imageViewFrame;
                
                self.newsOriginalImage = self.newsImageView.image;
                self.newsImageView.image = [self.newsImageView.image compressImage];
                
                [self.newsImageView configureShadow];
                [self refreshViewLayout];
            }
        } cacheInContext:self.managedObjectContext];
    }
}

- (void)refreshViewLayout {
    CGRect middleFrame = self.middleView.frame;
    middleFrame.size.height = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.size.height;
    if(self.newsImageView.image != nil) {
        CGRect imageViewFrame = self.newsImageView.frame;
        imageViewFrame.origin.y = middleFrame.size.height + 10;
        middleFrame.size.height += imageViewFrame.size.height + 25;
        self.newsImageView.frame = imageViewFrame;
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

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didTapScrollView:(UIGestureRecognizer *)gestureRecognizer {
    if(self.newsImageView.image != nil) {
        CGPoint touchPoint = [gestureRecognizer locationInView:self.scrollView];
        CGRect frame = self.newsImageView.frame;
        frame.origin.y += self.middleView.frame.origin.y;
        if(CGRectContainsPoint(frame, touchPoint)) {
            [DetailImageViewController showDetailImageWithImage:self.newsOriginalImage];
        }
    }
}

@end
