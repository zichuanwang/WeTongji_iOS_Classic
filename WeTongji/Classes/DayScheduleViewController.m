//
//  DayScheduleViewController.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DayScheduleViewController.h"
#import "DayScheduleView.h"
#import "quartzView.h"

@interface DayScheduleViewController ()

@property (nonatomic, strong) quartzView *previousView;
@property (nonatomic, strong) quartzView *currentView;
@property (nonatomic, strong) quartzView *nextView;

@property (nonatomic, retain) NSString *currentDate;

@end

@implementation DayScheduleViewController

@synthesize dayScheduleView = _dayScheduleView;
@synthesize previousView = _previousView;
@synthesize currentView = _currentView;
@synthesize nextView = _nextView;
@synthesize currentDate = _currentDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dayScheduleView = [[DayScheduleView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (void)moveToToday{
    [self.dayScheduleView moveToToday];
}

- (void)update{
    //self.currentDateLabel.text = self.currentDate;
    
    self.currentView.currentDate = self.currentDate;
    [self.currentView updateCourses];
    [self moveToToday];
}

#pragma mark - 
#pragma mark UIScrollViewDelegate


#pragma mark - 
#pragma mark IBActions 
/*- (IBAction)didClickNextDay:(id)sender{
    int tmpIndex = [self.datesIndexArray indexOfObject:self.currentDate];
    self.currentDate = [self.datesIndexArray objectAtIndex:(tmpIndex+1)];
    
    [self update];
}

- (IBAction)didClickPreviousDay:(id)sender{
    int tmpIndex = [self.datesIndexArray indexOfObject:self.currentDate];
    self.currentDate = [self.datesIndexArray objectAtIndex:(tmpIndex-1)];
    
    [self update];
}*/

@end
