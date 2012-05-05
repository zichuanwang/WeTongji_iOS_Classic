//
//  MonthEventTableViewController.m
//  WeTongji
//
//  Created by M.K.Rain on 12-5-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MonthEventTableViewController.h"
#import "ScheduleTableViewCell.h"

@interface MonthEventTableViewController ()

@end

@implementation MonthEventTableViewController

@synthesize courses = _courses;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setupData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    self.courses = [[NSArray alloc] initWithObjects:course1, course2,course3,course4, nil];
}

- (void)setViewPositionY:(float)y viewHeight:(float)height{
    self.view.frame = CGRectMake(0, y, self.view.frame.size.width, height);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.courses.count <= 2) {
        return 2;
    }else {
        return self.courses.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellTableIdentifier = @"ScheduleTableViewCell";
    
    ScheduleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellTableIdentifier owner:self options:nil];
        cell = [nib lastObject];
    }
    
    NSDictionary *rowData = [self.courses objectAtIndex:[indexPath row]];
    
    cell.nameLabel.text = [rowData objectForKey:@"Name"];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@:%@",[rowData objectForKey:@"startHour"],[rowData objectForKey:@"startMin"]];
    cell.locationLabel.text = [rowData objectForKey:@"Location"];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
