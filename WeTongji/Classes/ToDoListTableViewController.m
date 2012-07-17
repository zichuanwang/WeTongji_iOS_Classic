//
//  ToDoListTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-14.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ToDoListTableViewController.h"
#import "ToDoListTableViewCell.h"
#import "NSNotificationCenter+Addition.h"
#import "NSString+Addition.h"
#import "Event+Addition.h"
#import "Course+Addition.h"
#import "Activity+Addition.h"
#import "CourseDetailViewController.h"
#import "ActivityDetailViewController.h"
#import "UIApplication+Addition.h"

@interface ToDoListTableViewController ()

@end

@implementation ToDoListTableViewController

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
    [self configureTableView];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NSNotificationCenter registerChangeCurrentUserNotificationWithSelector:@selector(handleChangeCurrentUserNotification:) target:self];
    [NSNotificationCenter registerChangeScheduleNotificationWithSelector:@selector(handleChangeScheduleNotification:) target:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObject:self];
}

#pragma mark -
#pragma mark Logic methods 

- (NSFetchRequest *)getToDoListFetchRequest {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:sort, nil];
    [request setSortDescriptors:descriptors];
    request.fetchBatchSize = 20;
    return request;
}

- (NSArray *)getTodayToDoList {
    NSFetchRequest *request = [self getToDoListFetchRequest];
    NSPredicate *todayPredicate = [NSPredicate predicateWithFormat:@"begin_day == %@", [NSString getTodayBeginDayFormatString]];
    NSPredicate *timePredicate = [NSPredicate predicateWithFormat:@"end_time > %@", [NSDate date]];
    NSPredicate *ownerPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.schedule];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:ownerPredicate, todayPredicate, timePredicate, nil]]];
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:nil];
    return result;
}

- (NSArray *)getTomorrowToDoList {
    NSFetchRequest *request = [self getToDoListFetchRequest];
    NSPredicate *tomorrowPredicate = [NSPredicate predicateWithFormat:@"begin_day == %@", [NSString getTomorrowBeginDayFormatString]];
    NSPredicate *ownerPredicate = [NSPredicate predicateWithFormat:@"SELF IN %@", self.currentUser.schedule];
    [request setPredicate:[NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:ownerPredicate, tomorrowPredicate, nil]]];

    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:nil];
    return result;
}

- (void)refresh {
    [self configureDataSource];
    [self.tableView reloadData];

}

#pragma mark -
#pragma mark UI methods 

- (void)configureTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
}

#pragma mark -
#pragma mark WTGroupTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ToDoListTableViewCell";
}

- (void)configureDataSource {
    
    [self.dataSourceDictionary removeAllObjects];
    [self.dataSourceIndexArray removeAllObjects];
    
    NSArray *todayToDoList = [NSArray array];
    NSArray *tomorrowToDoList = [NSArray array];
    if(self.currentUser) {
        todayToDoList = [self getTodayToDoList];
        tomorrowToDoList = [self getTomorrowToDoList];
    }
    
    if(todayToDoList.count > 0) {
        if(todayToDoList.count > 1)
            [self.dataSourceIndexArray addObject:@"当前"];
       else 
            [self.dataSourceIndexArray addObject:@"今天"];
        [self.dataSourceDictionary setValue:[NSArray arrayWithObject:[todayToDoList objectAtIndex:0]] forKey:[self.dataSourceIndexArray objectAtIndex:0]];
        if(todayToDoList.count > 1) {
            [self.dataSourceIndexArray addObject:@"稍后"];
            NSArray *todayLaterToDoList = [todayToDoList subarrayWithRange:NSMakeRange(1, todayToDoList.count - 1)];
            [self.dataSourceDictionary setValue:todayLaterToDoList forKey:[self.dataSourceIndexArray objectAtIndex:1]];
        }
    } else {
        [self.dataSourceIndexArray addObject:@"今天"];
        NSObject *temp = [[NSObject alloc] init];
        [self.dataSourceDictionary setValue:[NSArray arrayWithObject:temp] forKey:[self.dataSourceIndexArray objectAtIndex:0]];
    }
    [self.dataSourceIndexArray addObject:@"明天"];
    if(tomorrowToDoList.count > 0) {
        [self.dataSourceDictionary setValue:tomorrowToDoList forKey:[self.dataSourceIndexArray objectAtIndex:self.dataSourceIndexArray.count - 1]];
    } else {
        NSObject *temp = [[NSObject alloc] init];
        [self.dataSourceDictionary setValue:[NSArray arrayWithObject:temp] forKey:[self.dataSourceIndexArray objectAtIndex:self.dataSourceIndexArray.count - 1]];
    }
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ToDoListTableViewCell *toDoListCell = (ToDoListTableViewCell *)cell;
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    Event *event = [value objectAtIndex:indexPath.row];
    
    if(![event isKindOfClass:[Event class]]) {
        [toDoListCell setAsEmptyCell];
    } else {
        [toDoListCell setAsNormalCell];
        toDoListCell.whenLabel.text = [NSString timeConvertFromDate:event.begin_time];
        toDoListCell.whatLabel.text = event.what;
        toDoListCell.whereLabel.text = event.where;
        
        if([event isMemberOfClass:[Course class]]) {
            Course *course = (Course *)event;
            if([course.require_type isEqualToString:@"必修"]) {
                [toDoListCell setEventType:EventTypeRequiredCurriculum];
            } else {
                [toDoListCell setEventType:EventTypeOptionalCurriculum];
            }
        } else if([event isMemberOfClass:[Activity class]]) {
            [toDoListCell setEventType:EventTypeActivity];
        }
    }
}

#pragma mark -
#pragma mark UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [self.dataSourceIndexArray objectAtIndex:indexPath.section];
    NSArray *value = [self.dataSourceDictionary objectForKey:key];
    Event *event = [value objectAtIndex:indexPath.row];
    //[self.delegate toDoListTableViewController:self didSelectEvent:event];
    EventDetailViewController *vc = nil;
    if([event isKindOfClass:[Course class]])
        vc = [[CourseDetailViewController alloc] initWithCourse:(Course *)event];
    else if([event isKindOfClass:[Activity class]])
        vc = [[ActivityDetailViewController alloc] initWithActivity:(Activity *)event];
    else 
        return;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[UIApplication sharedApplication].rootViewController presentModalViewController:nav animated:YES];
}

#pragma mark -
#pragma mark Handle notifications

- (void)handleChangeCurrentUserNotification:(NSNotification *)notification {
    [self refresh];
}

- (void)handleChangeScheduleNotification:(NSNotification *)notification {
    [self refresh];
}

@end
