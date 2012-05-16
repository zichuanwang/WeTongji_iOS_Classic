//
//  ScheduleMonthViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ScheduleMonthViewController.h"
#import "ScheduleMonthDateViewCell.h"

@interface ScheduleMonthViewController ()

@property (nonatomic, strong) IBOutlet UIView *scheduleMonthHeadView;
@property (nonatomic, strong) IBOutlet UIView *scheduleMonthDateView;
@property (nonatomic, strong) IBOutlet UIView *scheduleMonthEventView;

@end

@implementation ScheduleMonthViewController

@synthesize currentDate = _currentDate;
@synthesize currentMonthDate = _currentMonthDate;
@synthesize currentSelectDate = _currentSelectDate;
@synthesize currentTime = _currentTime;
@synthesize lastMonth = _lastMonth;

@synthesize scheduleMonthDateView = _scheduleMonthDateView;
@synthesize scheduleMonthHeadView = _scheduleMonthHeadView;
@synthesize scheduleMonthEventView = _scheduleMonthEventView;
@synthesize headTitle = _headTitle;

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
    [self configureHeadView];
    [self configureDateView];
    [self configureEventView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)configureHeadView{
    self.currentTime=CFAbsoluteTimeGetCurrent();
    self.currentMonthDate=CFAbsoluteTimeGetGregorianDate(self.currentTime,CFTimeZoneCopyDefault());
    self.lastMonth = CFAbsoluteTimeGetGregorianDate(self.currentTime, CFTimeZoneCopyDefault());
    //self.currentMonthDate.day = 1;
	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%d年%d月",self.currentMonthDate.year,self.currentMonthDate.month];
    self.headTitle.text = title_Month;
    
    NSDate *date = [NSDate date];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;  
    
    NSDateComponents *dd = [cal components:unitFlags fromDate:date]; 
    
    int week = [dd year];
    
    int hour = [dd hour];
    
    int minute = [dd minute];
    
    int second = [dd second];
    NSLog(@"week:%d hour:%d min:%d sec:%d",week,hour,minute,second);
}

- (void)configureDateView{
    self.currentDate = [NSDate date]; 
    
    self.scheduleMonthDateView.frame = CGRectMake(0, 60, 320, 46*[self getLineNumberOfMonth:self.currentMonthDate]);
    for (int i=0; i<[self getLineNumberOfMonth:self.currentMonthDate]; i++) {
        for(int j=0;j<7;j++){
            ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake(j*46, i*46, 46, 46)];
            [self.scheduleMonthDateView addSubview:tmpCell];
        }
    }
    
    //[self drawDateWords];
    
}

- (void)configureEventView{
    self.scheduleMonthEventView.backgroundColor = [UIColor grayColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma mark -- Logic methods
- (int)getDayCountOfaMonth:(CFGregorianDate)date{ 
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if(date.year%4==0 && date.year%100!=0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}
             

- (int)getLineNumberOfMonth:(CFGregorianDate)date{
    int row_count = 0;
    if ([self getMonthWeekday:self.currentMonthDate] != 7) {
        row_count = ([self getDayCountOfaMonth:self.currentMonthDate]+[self getMonthWeekday:self.currentMonthDate]-1)/7+1;
    }else {
        row_count = ([self getDayCountOfaMonth:self.currentMonthDate])/7+1;
    }
    return row_count;
}

- (int)getMonthWeekday:(CFGregorianDate)date
{
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year=date.year;
	month_date.month=date.month;
	month_date.day=1;
	month_date.hour=0;
	month_date.minute=0;
	month_date.second=1;
	return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date,tz),tz);
}

- (int)getDayCountsOfLastMonth:(CFGregorianDate)date{
    
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
    month_date.year = date.year;
    month_date.month = date.month - 1;
    month_date.day = 1;
    month_date.hour = 0;
    month_date.minute = 0;
    month_date.second = 0;
    return [self getDayCountOfaMonth:month_date];
}

@end
