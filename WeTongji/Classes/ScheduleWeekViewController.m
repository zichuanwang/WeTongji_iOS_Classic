//
//  ScheduleWeekViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-12.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ScheduleWeekViewController.h"
#import "ScheduleWeekRightTableViewCell.h"
#import "ScheduleWeekLeftTableViewCell.h"
#import "NSUserDefaults+Addition.h"
#import "NSString+Addition.h"

#define DAY_TIME_INTERVAL (60 * 60 * 24)

@interface ScheduleWeekViewController ()

@end

@implementation ScheduleWeekViewController

@synthesize leftTableView = _leftTableView;
@synthesize rightTableView = _rightTableView;

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
    [self configureRightTableView];
    [self configureView];
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getTodayRowInRightTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getNowRowInLeftTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.leftTableView = nil;
    self.rightTableView = nil;
}

#pragma mark -
#pragma mark Logic methods 

- (NSInteger)getNowRowInLeftTableView {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];  
    NSInteger unitFlags = NSHourCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger hour = [comps hour];
    NSInteger result = hour - BEGIN_HOUR;
    if(result < 0)
        result = 0;
    if(result > LEFT_TABLE_VIEW_ROW_COUNT - 1)
        result = LEFT_TABLE_VIEW_ROW_COUNT - 1;
    return result;
}

- (NSInteger)getTodayRowInRightTableView {
    NSDate *today = [NSDate date];
    NSTimeInterval timeIntervalSinceSemesterBegin = [today timeIntervalSinceDate:[NSUserDefaults getCurrentSemesterBeginDate]];
    NSInteger todayRow = timeIntervalSinceSemesterBegin / DAY_TIME_INTERVAL;
    return todayRow;
}

- (NSArray *)getRightCellDataArrayAtIndexPath:(NSIndexPath *)indexPath {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *ownerPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.schedule];
    NSDate *semesterBegin = [NSUserDefaults getCurrentSemesterBeginDate];
    NSTimeInterval timeInterval = indexPath.row * DAY_TIME_INTERVAL;
    NSPredicate *beginPredicate = [NSPredicate predicateWithFormat:@"begin_time >= %@", [semesterBegin dateByAddingTimeInterval:timeInterval]];
    NSPredicate *endPredicate = [NSPredicate predicateWithFormat:@"begin_time < %@", [semesterBegin dateByAddingTimeInterval:timeInterval + DAY_TIME_INTERVAL]];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:ownerPredicate, beginPredicate, endPredicate, nil]]];
        
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:NULL];
    return result;
}

#pragma mark -
#pragma mark UI methods

- (void)configureView {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"paper_wide_main"]];
}

- (void)configureRightTableView {
    CGRect frame =  self.rightTableView.frame;
    self.rightTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    frame.size.height = LEFT_TABLE_VIEW_ROW_COUNT * LEFT_CELL_HEIGHT;
    NSLog(@"frame:%f,%f,%f,%f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    self.rightTableView.frame = frame;
    self.rightTableView.contentInset = UIEdgeInsetsMake(65.0f, 0, 0, 0);
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if([cell isKindOfClass:[ScheduleWeekLeftTableViewCell class]]) {
        NSInteger hour = indexPath.row + BEGIN_HOUR;
        NSString *hourString = nil;
        if(hour < 10)
            hourString = [NSString stringWithFormat:@"0%d:00", hour];
        else
            hourString = [NSString stringWithFormat:@"%d:00", hour];
        
        ScheduleWeekLeftTableViewCell *leftCell = (ScheduleWeekLeftTableViewCell *)cell;
        leftCell.hourLabel.text = hourString;
        if(hour == END_HOUR) 
            leftCell.separatorImageView.hidden = YES;
        else
            leftCell.separatorImageView.hidden = NO;
        
    } else {
        NSInteger weekDay = (indexPath.row + 1) % 7 + 1;
        NSString *weekDayString = [NSString weekDayConvertFromInteger:weekDay];
        
        NSInteger week = indexPath.row / 7;
        if(weekDay == 2) {
            NSArray *weekStringArray = [NSArray arrayWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", nil];
            NSString *weekString = nil;
            
            if(week >= 99) {
                weekString = @"第??周";
            } else if(week % 10 == 9) {
                if(week < 10)
                    weekString = [NSString stringWithFormat:@"第十周"];
                else 
                    weekString = [NSString stringWithFormat:@"第%@十周", [weekStringArray objectAtIndex:week / 10]];
            } else {
                if(week < 10)
                    weekString = [NSString stringWithFormat:@"第%@周", [weekStringArray objectAtIndex:week]];
                else if(week < 20)
                    weekString = [NSString stringWithFormat:@"第十%@周", [weekStringArray objectAtIndex:week % 10]];
                else 
                    weekString = [NSString stringWithFormat:@"第%@十%@周", [weekStringArray objectAtIndex:week / 10 - 1], [weekStringArray objectAtIndex:week % 10]];
            }
            weekDayString = weekString;
        }
        
        ScheduleWeekRightTableViewCell *rightCell = (ScheduleWeekRightTableViewCell *)cell;
        rightCell.weekDayLabel.text = weekDayString;
        
        if([self getTodayRowInRightTableView] == indexPath.row)
            rightCell.weekDayLabel.textColor = [UIColor colorWithRed:0 green:0.37f blue:0.66f alpha:1];
        
        [rightCell setDrawViewVerticalOffset:self.leftTableView.contentOffset.y row:indexPath.row dataArray:[self getRightCellDataArrayAtIndexPath:indexPath]];
    }
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.rightTableView) {
        NSDate *begin = [NSUserDefaults getCurrentSemesterBeginDate];
        NSDate *end = [NSUserDefaults getCurrentSemesterEndDate];
        NSTimeInterval timeInterval = [end timeIntervalSinceDate:begin]; 
        NSInteger result = timeInterval / 60 / 60 / 24;
        NSLog(@"right row:%d", result);
        return result;
    } else {
        return LEFT_TABLE_VIEW_ROW_COUNT;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    if(tableView == self.rightTableView)
        cellIdentifier = @"ScheduleWeekRightTableViewCell";
    else 
        cellIdentifier = @"ScheduleWeekLeftTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
    cell = [nib objectAtIndex:0];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark IBActions

- (void)didClickTodayButton {
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getTodayRowInRightTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self getNowRowInLeftTableView] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView == self.leftTableView) {
        for(ScheduleWeekRightTableViewCell *cell in self.rightTableView.visibleCells) {
            [cell setDrawViewVerticalOffset:self.leftTableView.contentOffset.y];
        }
        [scrollView setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark ScheduleWeekLeftTableView delegate

- (void)scheduleWeekLeftTableView:(ScheduleWeekLeftTableView *)tableView didSwipeHorizontally:(CGFloat)x swipeVertically:(CGFloat)y {
    CGPoint rightPoint = CGPointMake(self.rightTableView.contentOffset.x, self.rightTableView.contentOffset.y + x);
    if(rightPoint.y > 0 && rightPoint.y < self.rightTableView.contentSize.height - self.rightTableView.frame.size.width)
        [self.rightTableView setContentOffset:rightPoint animated:NO];
    
    CGPoint leftPoint = CGPointMake(self.leftTableView.contentOffset.x, self.leftTableView.contentOffset.y + y);
    if(leftPoint.y > 0 && leftPoint.y < self.leftTableView.contentSize.height - self.leftTableView.frame.size.height)
        [self.leftTableView setContentOffset:leftPoint animated:NO];
}

@end
