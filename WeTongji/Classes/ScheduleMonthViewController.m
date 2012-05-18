//
//  ScheduleMonthViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMonthViewController.h"
#import "NSString+Addition.h"
#import "Event+Addition.h"

#define DAY_TIME_INTERVAL   (60 * 60 * 24)
#define HOUR_TIME_INTERVAL  (60 * 60)

@interface ScheduleMonthViewController ()

@end

@implementation ScheduleMonthViewController

@synthesize tableViewController = _tableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableViewController = [[ScheduleMonthTableViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTableView];
    [self configureMonthCalendarView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - 
#pragma mark UI methods

- (void)configureMonthCalendarView {
    [self.monthView selectDate:[NSDate date]];
}

- (void)configureTableView {
    [self.view insertSubview:self.tableViewController.view belowSubview:self.monthView];
    [self updateTableViewFrame];
}

- (void)updateTableViewFrame {
    UITableView *tableView = self.tableViewController.tableView;
	float y = self.monthView.frame.origin.y + self.monthView.frame.size.height;
	tableView.frame = CGRectMake(tableView.frame.origin.x, y, tableView.frame.size.width, self.tableViewController.view.frame.size.height - y);
}

#pragma mark - 
#pragma mark Month View Delegate & Data Source

- (void)calendarMonthView:(TKCalendarMonthView*)monthView didSelectDate:(NSDate*)date {
    self.tableViewController.selectedDate = date;
}

- (void)calendarMonthView:(TKCalendarMonthView*)monthView monthDidChange:(NSDate*)month animated:(BOOL)animated {
	[self updateTableOffset:animated];
}

- (void)updateTableOffset:(BOOL)animated {
	if(animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3f];
	}
	[self updateTableViewFrame];
	if(animated) 
        [UIView commitAnimations];
}

- (NSArray*)calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.tableViewController.managedObjectContext]];
    NSPredicate *ownerPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.tableViewController.currentUser.schedule];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:[NSDate date]];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date]];
    NSTimeInterval timeZoneIntervalOffset = destinationGMTOffset - sourceGMTOffset;
    
    NSPredicate *beginPredicate = [NSPredicate predicateWithFormat:@"begin_time >= %@", [startDate dateByAddingTimeInterval:timeZoneIntervalOffset]];
    NSPredicate *endPredicate = [NSPredicate predicateWithFormat:@"begin_time < %@", [lastDate dateByAddingTimeInterval:timeZoneIntervalOffset]];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:ownerPredicate, beginPredicate, endPredicate, nil]]];
    
    NSArray *items = [self.tableViewController.managedObjectContext executeFetchRequest:request error:NULL];
    NSMutableArray *result = [NSMutableArray array];
    NSTimeInterval interval = [lastDate timeIntervalSinceDate:startDate]; 
    int dayCount = interval / DAY_TIME_INTERVAL + 1;
    
    for(int i = 0; i < dayCount ; i++) {
        NSDate *beginDate = [startDate dateByAddingTimeInterval:DAY_TIME_INTERVAL * i + timeZoneIntervalOffset];
        NSDate *endDate = [startDate dateByAddingTimeInterval:DAY_TIME_INTERVAL * (i + 1) + timeZoneIntervalOffset];
        NSPredicate *beginPredicate = [NSPredicate predicateWithFormat:@"begin_time >= %@", beginDate];
        NSPredicate *endPredicate = [NSPredicate predicateWithFormat:@"begin_time < %@", endDate];
        //NSLog(@"begin:%@, end:%@", [NSString yearMonthDayWeekTimeConvertFromDate:beginDate], [NSString yearMonthDayWeekTimeConvertFromDate:endDate]);
        BOOL hasEvent = NO;
        NSArray *filteredItmes = [items filteredArrayUsingPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:beginPredicate, endPredicate, nil]]];
        if(filteredItmes.count > 0) {
            Event *event = filteredItmes.lastObject;
            if(event.what != nil)
                hasEvent = YES;
        }
        [result addObject:[NSNumber numberWithBool:hasEvent]];
    }
    return result;
}

#pragma mark - 
#pragma mark IBActions

- (void)didClickTodayButton {
    [self.monthView selectDate:[NSDate date]];
    self.tableViewController.selectedDate = [NSDate date];
}

@end
