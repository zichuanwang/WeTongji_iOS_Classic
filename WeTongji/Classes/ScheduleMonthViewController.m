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
@synthesize currentSelectDate = _currentSelectDate;
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
    self.currentDate = [NSDate date]; 
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
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;  
    NSDateComponents *dd = [cal components:unitFlags fromDate:self.currentDate]; 
    
	NSString *title_Month   = [[NSString alloc] initWithFormat:@"%d年%d月",[dd year],[dd month]];
    self.headTitle.text = title_Month;

}

- (void)configureDateView{
    self.scheduleMonthDateView.frame = CGRectMake(0, 60, 320, 46*[self getLineNumberOfMonth:self.currentDate]);
    NSLog(@"%f",self.scheduleMonthDateView.frame.size.height);
    for (int i=0; i<[self getLineNumberOfMonth:self.currentDate]; i++) {
        for(int j=0;j<7;j++){
            ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake(j*46, i*46, 46, 46)];
            [self.scheduleMonthDateView addSubview:tmpCell];
        }
    }
    
    int dayCount=[self getDayCountOfMonth:self.currentDate];
	int day=0;
	int x=0;
	int y=0;
	int curr_Weekday=[self getMonthWeekday:self.currentDate];
    int lastWeekday = [self getLastMonthWeekday:self.currentDate];
    
    //draw the dates of current month
	for(int i=1;i<dayCount+1;i++)
	{
		day=i+curr_Weekday-1;
        x=day % 7;
        if (curr_Weekday != 7) {
            y=day / 7;
        }else {
            y =day / 7 - 1;
        }
		NSString *date=[[NSString alloc] initWithFormat:@"%2d",i];
        ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake(x*46, y*46, 46, 46)];
        [tmpCell setDay:[date intValue]];
        [self.scheduleMonthDateView addSubview:tmpCell];
	}
    
    //draw the dates of last month
    int dayCountsOfLastMonth = [self getDayCountsOfLastMonth:self.currentDate];
    if (curr_Weekday != 7) {
        for (int i=0; i<curr_Weekday; i++) {
            ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake(i*46, 0, 46, 46)];
            [tmpCell setDay:dayCountsOfLastMonth-(curr_Weekday-i-1)];
            [self.scheduleMonthDateView addSubview:tmpCell];
        }
    }
    
    //draw the dates of next month
    if (lastWeekday != 6) {
        for (int i=0; i<6-lastWeekday; i++) {
            ScheduleMonthDateViewCell *tmpCell = [[ScheduleMonthDateViewCell alloc] initWithFrame:CGRectMake((lastWeekday+1+i)*46, ([self getLineNumberOfMonth:self.currentDate]-1)*46, 46, 46)];
            [tmpCell setDay:(i+1)];
            [self.scheduleMonthDateView addSubview:tmpCell];
        }
    }
}

- (void)configureEventView{
    self.scheduleMonthEventView.frame = CGRectMake(0, 60+46*[self getLineNumberOfMonth:self.currentDate], 320, 400-46*[self getLineNumberOfMonth:self.currentDate]);
    NSLog(@"y:%f",self.scheduleMonthEventView.frame.origin.y);
    NSLog(@"height:%f",self.scheduleMonthEventView.frame.size.height);
    self.scheduleMonthEventView.backgroundColor = [UIColor grayColor];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma mark -- Logic methods
- (int)getDayCountOfMonth:(NSDate *)date{ 
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSMonthCalendarUnit;  
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
	switch ([dd month]) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
		case 2:
			if([dd year]%4==0 && [dd year]%100!=0)
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

- (int)getLineNumberOfMonth:(NSDate *)date{
    int rowCount = 0;
    if ([self getMonthWeekday:self.currentDate] != 7) {
        rowCount = ([self getDayCountOfMonth:self.currentDate]+[self getMonthWeekday:self.currentDate]-1)/7+1;
    }else {
        rowCount = ([self getDayCountOfMonth:self.currentDate])/7+1;
    }
    return rowCount;
}

- (int)getMonthWeekday:(NSDate *)date{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit; 
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    
    [dd setDay:1];
    [dd setHour:0];
    [dd setMinute:0];
    [dd setSecond:1];
    NSDate *tmpDate  = [cal dateFromComponents:dd];
    dd = [cal components:unitFlags fromDate:tmpDate];
    return [dd weekday]-1;
}
- (int)getLastMonthWeekday:(NSDate *)date{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit; 
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    
    [dd setDay:[self getDayCountOfMonth:date]];
    [dd setHour:0];
    [dd setMinute:0];
    [dd setSecond:1];
    NSDate *tmpDate  = [cal dateFromComponents:dd];
    dd = [cal components:unitFlags fromDate:tmpDate];
    return [dd weekday]-1;
}

- (int)getDayCountsOfLastMonth:(NSDate *)date{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;  
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    [dd setMonth:([dd month]-1)];
    NSDate *resDate  = [cal dateFromComponents:dd];
    
    return [self getDayCountOfMonth:resDate];
}

#pragma mark
#pragma mark --- IBActions
- (void)movePrev:(UIButton *)sender{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit; 
    NSDateComponents *dd = [cal components:unitFlags fromDate:self.currentDate];
    [dd setMonth:([dd month]-1)];
    self.currentDate = [cal dateFromComponents:dd];
    
    [self configureDateView];
    [self configureEventView];
    [self configureHeadView];
}

- (void)moveNext:(UIButton *)sender{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |  
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit; 
    NSDateComponents *dd = [cal components:unitFlags fromDate:self.currentDate];
    [dd setMonth:([dd month]+1)];
    self.currentDate = [cal dateFromComponents:dd];
    
    [self configureDateView];
    [self configureEventView];
    [self configureHeadView];
}

@end