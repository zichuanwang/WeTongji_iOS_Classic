//
//  ListScheduleViewController.m
//  WeTongji
//
//  Created by M.K.Rain on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ListScheduleViewController.h"
#import "ScheduleTableViewCell.h"

@interface ListScheduleViewController ()

@property (nonatomic, strong) NSString *currentDate;

- (void)setupData;

@end

@implementation ListScheduleViewController

@synthesize currentDate = _currentDate;

@synthesize datesIndexArray = _datesIndexArray;
@synthesize dateSourceDictionary = _dateSourceDictionary;
@synthesize tableView = _tableView;

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
    self.datesIndexArray = [NSMutableArray arrayWithCapacity:10];
    self.dateSourceDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    [self setupData];
    
    [self moveToToday];
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

- (void)setupData{
    self.currentDate = @"3月3日";
    
    //set up the course data
    NSDictionary *course1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"操作系统",@"Name",
                             @"9",@"startHour",@"00",@"startMin",
                             @"10",@"endHour",@"00",@"endMin",
                             @"A301",@"Location", nil];
    NSDictionary *course2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"组成原理",@"Name",
                             @"10",@"startHour",@"00",@"startMin",
                             @"12",@"endHour",@"00",@"endMin",
                             @"B410",@"Location", nil];
    NSDictionary *course3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"未来剧场",@"Name",
                             @"17",@"startHour",@"00",@"startMin",
                             @"19",@"endHour",@"00",@"endMin",
                             @"A310",@"Location", nil];
    NSDictionary *course4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"flash",@"Name",
                             @"16",@"startHour",@"00",@"startMin",
                             @"17",@"endHour",@"00",@"endMin",
                             @"F210",@"Location", nil];
    NSDictionary *course5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"平面设计",@"Name",
                             @"20",@"startHour",@"00",@"startMin",
                             @"22",@"endHour",@"00",@"endMin",
                             @"F301",@"Location", nil];
    NSDictionary *course6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"数据库",@"Name",
                             @"13",@"startHour",@"00",@"startMin",
                             @"14",@"endHour",@"00",@"endMin",
                             @"AG301",@"Location", nil];
    
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月1日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月2日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月3日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月4日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月5日"]];
    [self.datesIndexArray addObject:[NSString stringWithString:@"3月6日"]];
    NSArray *day1 = [NSArray arrayWithObjects:course1, nil];
    NSArray *day2 = [NSArray arrayWithObjects:course2, course3, nil];
    NSArray *day3 = [NSArray arrayWithObjects:course4, course5, course6, nil];
    NSArray *day4 = [NSArray arrayWithObjects:course1, course3, nil];
    NSArray *day5 = [NSArray arrayWithObjects:course2, course4, nil];
    NSArray *day6 = [NSArray arrayWithObjects:course4, course2, course6, nil];
    
    [self.dateSourceDictionary setValue:day1 forKey:[self.datesIndexArray objectAtIndex:0]];
    [self.dateSourceDictionary setValue:day2 forKey:[self.datesIndexArray objectAtIndex:1]];
    [self.dateSourceDictionary setValue:day3 forKey:[self.datesIndexArray objectAtIndex:2]];
    [self.dateSourceDictionary setValue:day4 forKey:[self.datesIndexArray objectAtIndex:3]];
    [self.dateSourceDictionary setValue:day5 forKey:[self.datesIndexArray objectAtIndex:4]];
    [self.dateSourceDictionary setValue:day6 forKey:[self.datesIndexArray objectAtIndex:5]];
    
}

- (void)moveToToday{
    NSInteger i = [self.datesIndexArray indexOfObject:self.currentDate];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //return [self.dates count]; 
    return [self.datesIndexArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dateSourceDictionary objectForKey:[self.datesIndexArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellTableIdentifier = @"ScheduleTableViewCell";
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellTableIdentifier owner:self options:nil];
        cell = [nib lastObject];
    }
    NSArray *tmp = [self.dateSourceDictionary objectForKey:[self.datesIndexArray objectAtIndex:[indexPath section]]];
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [tmp objectAtIndex:row];
    
    cell.nameLabel.text = [rowData objectForKey:@"Name"];
    cell.timeLabel.text = [rowData objectForKey:@"Name"];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@:%@",[rowData objectForKey:@"startHour"],[rowData objectForKey:@"startMin"]];
    cell.locationLabel.text = [rowData objectForKey:@"Location"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.datesIndexArray objectAtIndex:section];
}

@end
