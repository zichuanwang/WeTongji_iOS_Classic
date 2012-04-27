//
//  ChannelDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChannelDetailViewController.h"
#import "NSString+Addition.h"

@interface ChannelDetailViewController ()

@property (nonatomic, strong) Activity *activity;

@end

@implementation ChannelDetailViewController

@synthesize organizerNameLabel = _organizerNameLabel;
@synthesize timeLabel = _timeLabel;
@synthesize placeLabel = _placeLabel;
@synthesize descriptionTextView = _descriptionTextView;
@synthesize activityCategoryLabel = _activityCategoryLabel;
@synthesize titleLabel = _titleLabel;
@synthesize scrollView = _scrollView;

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
    [self configureNavBar];
    [self configureIBOutlets];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.organizerNameLabel = nil;
    self.timeLabel = nil;
    self.placeLabel = nil;
    self.descriptionTextView = nil;
    self.activityCategoryLabel = nil;
    self.titleLabel = nil;
    self.scrollView = nil;
}

- (id)initWithActivity:(Activity *)activity {
    self = [super init];
    if(self) {
        self.activity = activity;
    }
    return self;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"活动"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [UIBarButtonItem getBackButtonItemWithTitle:@"频道" target:self action:@selector(didClickBackButton)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureIBOutlets {
    self.titleLabel.text = self.activity.title;
    self.descriptionTextView.text = self.activity.activity_description;
    self.organizerNameLabel.text = self.activity.organizer;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height + 1);
    self.timeLabel.text = [NSString timeConvertFromBeginDate:self.activity.begin_time endDate:self.activity.end_time];
    self.placeLabel.text = self.activity.location;
}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
