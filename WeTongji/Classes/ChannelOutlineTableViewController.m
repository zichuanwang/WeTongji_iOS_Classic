//
//  ChannelOutlineTableViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "ChannelOutlineTableViewController.h"
#import "ChannelOutlineTableViewCell.h"
#import "WTClient.h"
#import "Activity+Addition.h"
#import "NSString+Addition.h"
#import "NSUserDefaults+Addition.h"

@interface ChannelOutlineTableViewController ()

@end

@implementation ChannelOutlineTableViewController

@synthesize delegate = _delegate;

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
    [self configureTableViewHeaderFooter];
    [self loadMoreData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

#pragma mark -
#pragma mark UITableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Activity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.delegate channelOutlineTableViewDidSelectActivity:activity];
}

#pragma mark -
#pragma mark CoreDataTableViewController methods to overwrite

- (NSString *)customCellClassName {
    return @"ChannelOutlineTableViewCell";
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if([cell isMemberOfClass:[ChannelOutlineTableViewCell class]]) {
        ChannelOutlineTableViewCell *outlineCell = (ChannelOutlineTableViewCell *)cell;
        Activity *activity = [self.fetchedResultsController objectAtIndexPath:indexPath];
        outlineCell.titleLabel.text = activity.what;
        outlineCell.locationLabel.text = activity.where;
        outlineCell.timeLabel.text = [NSString timeConvertFromBeginDate:activity.begin_time endDate:activity.end_time];
    }
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *channelPredicate = [NSPredicate predicateWithFormat:@"channel_id IN %@", [NSUserDefaults getFollowedChannelArray]];
    NSPredicate *hiddenPredicate = [NSPredicate predicateWithFormat:@"hidden == NO"];
    NSPredicate *compoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:channelPredicate, hiddenPredicate, nil]];
    [request setPredicate:compoundPredicate];
    NSSortDescriptor *sortByUpdate = [[NSSortDescriptor alloc] initWithKey:@"channel_update_date" ascending:YES];
    NSSortDescriptor *sortByLike = [[NSSortDescriptor alloc] initWithKey:@"like_count" ascending:NO];
    NSSortDescriptor *sortByBegin = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    ChannelSortMethod methodCode = [NSUserDefaults getChannelSortMethod];
    NSArray *descriptors = nil;
    if(methodCode == ChannelSortByLikeCount)
        descriptors = [NSArray arrayWithObjects:sortByUpdate, sortByLike, sortByBegin, nil];
    else 
        descriptors = [NSArray arrayWithObjects:sortByUpdate, sortByBegin, sortByLike, nil];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath {
    [super insertCellAtIndexPath:indexPath];
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark EGORefresh Method

- (void)refresh {
    self.nextPage = 0;
    [self loadMoreData];
}

- (void)clearData {
    NSArray *activitiesArray = [Activity allActivitiesInManagedObjectContext:self.managedObjectContext];
    for(Activity *activity in activitiesArray) {
        activity.hidden = [NSNumber numberWithBool:YES];
    }
}

- (void)loadMoreData {
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            if(self.nextPage == 0)
                [self clearData];
            NSArray *array = [client.responseData objectForKey:@"Activities"];
            NSDate *updateDate = [NSDate date];
            for(NSDictionary *activityDict in array) {
                Activity *activity = [Activity insertActivity:activityDict inManagedObjectContext:self.managedObjectContext];
                activity.hidden = [NSNumber numberWithBool:NO];
                activity.channel_update_date = updateDate;
            }
            
            self.nextPage = [[NSString stringWithFormat:@"%@", [client.responseData objectForKey:@"NextPager"]] intValue];
            NSLog(@"next:%d", self.nextPage);
            [self configureTableViewFooter];
        }
        [self doneLoadingTableViewData];
    }];
    ChannelSortMethod methodCode = [NSUserDefaults getChannelSortMethod];
    GetActivitySortType sortType = GetActivitySortTypeBeginAsc;
    if(methodCode == ChannelSortByLikeCount)
        sortType = GetActivitySortTypeLikeDesc;
    [client getActivitesWithChannelIds:[NSUserDefaults getChannelFollowStatusString] sortType:sortType page:self.nextPage];
}

@end
