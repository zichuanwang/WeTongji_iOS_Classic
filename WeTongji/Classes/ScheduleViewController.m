//
//  ScheduleViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleViewController.h"
#import "UIView+Addition.h"
#import "UIBarButtonItem+WTBarButtonItem.h"
#import "ListScheduleViewController.h"
#import "DayScheduleViewController.h"
#import "MonthScheduleViewController.h"

@interface ScheduleViewController ()

@property (nonatomic, strong) ListScheduleViewController *listScheduleViewController;
@property (nonatomic, strong) DayScheduleViewController *dayScheduleViewController;
@property (nonatomic, strong) MonthScheduleViewController *monthScheduleViewController;

- (void)configureNavigationBar;
- (void)configureToolBarButtons;
- (void)configureScheduleList;
- (void)configureScheduleDay;
- (void)configureScheduleMonth;

@end

@implementation ScheduleViewController

@synthesize datesIndexArray = _datesIndexArray;
@synthesize dateSourceDictionary = _dateSourceDictionary;
@synthesize toolBarView = _toolBarView;
@synthesize todayButton = _todayButton;
@synthesize segmentedControl = _segmentedControl;

@synthesize listScheduleViewController = _listScheduleViewController;
@synthesize dayScheduleViewController = _dayScheduleViewController;
@synthesize monthScheduleViewController = _monthScheduleViewController;

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
    
    [self configureNavigationBar];
    [self configureToolBarButtons];
    [self configureScheduleList];
    [self configureScheduleDay];
    [self configureScheduleMonth];    
   
}

- (void)configureNavigationBar{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text = @"日程";
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    titleLabel.shadowColor = [UIColor darkGrayColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.topItem.titleView = titleLabel;
    
    UIBarButtonItem *finishButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = finishButton;
    self.navigationItem.leftBarButtonItem.enabled = YES;
}

- (void)configureToolBarButtons{
    
}

- (void)configureScheduleList{
    ListScheduleViewController *list = [[ListScheduleViewController alloc] init];
    self.listScheduleViewController = list;
    [self.view insertSubview:list.view belowSubview:self.toolBarView];
    self.listScheduleViewController.view.alpha = 1;
}

- (void)configureScheduleDay{
    DayScheduleViewController *day = [[DayScheduleViewController alloc] init];
    self.dayScheduleViewController = day;
    [self.view insertSubview:day.view belowSubview:self.listScheduleViewController.view];
    self.dayScheduleViewController.view.alpha = 0;
}

- (void)configureScheduleMonth{
    MonthScheduleViewController *month = [[MonthScheduleViewController alloc] init];
    self.monthScheduleViewController = month;
    [self.view insertSubview:month.view belowSubview:self.dayScheduleViewController.view];
    self.monthScheduleViewController.view.alpha = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didClickFinishButton{
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark # IBActions
- (IBAction)toggleControls:(id)sender{
    UISegmentedControl *toggle = (UISegmentedControl *)sender;
    switch ([toggle selectedSegmentIndex]) {
        case 0:
            if (self.dayScheduleViewController.view.alpha == 1) {
                [self.dayScheduleViewController.view transitionFadeOut];
            }else if (self.monthScheduleViewController.view.alpha == 1) {
                [self.monthScheduleViewController.view transitionFadeOut];
            }
            [self.listScheduleViewController.view transitionFadeIn];
            [self.listScheduleViewController moveToToday];
            break;
        case 1:
            if (self.listScheduleViewController.view.alpha == 1) {
                [self.listScheduleViewController.view transitionFadeOut];
            }else if (self.monthScheduleViewController.view.alpha == 1) {
                [self.monthScheduleViewController.view transitionFadeOut];
            }
            [self.dayScheduleViewController.view transitionFadeIn];
            [self.dayScheduleViewController moveToToday];
            break;
        case 2:
            if (self.listScheduleViewController.view.alpha == 1) {
                [self.listScheduleViewController.view transitionFadeOut];
            }else if(self.dayScheduleViewController.view.alpha == 1){
            [self.dayScheduleViewController.view transitionFadeOut];
            }
            [self.monthScheduleViewController.view transitionFadeIn];
            //[self.monthScheduleViewController moveToToday];
            break;
        default:
            break;
    }
}

- (void)didClickTodayButton:(id)sender{
    if (self.listScheduleViewController.view.alpha == 1.0f) {
        [self.listScheduleViewController moveToToday];
    }else if(self.dayScheduleViewController.view.alpha == 1.0f){
        [self.dayScheduleViewController moveToToday];
    }
}

@end
