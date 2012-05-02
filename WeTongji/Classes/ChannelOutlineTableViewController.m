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

- (void)configureTableViewFooter {
    if(self.numberOfRowsInFirstSection == 0) {
        [self configureTableViewFooterWithType:EGOTableViewFooterEmptyWithHint];
    }
    else {
        [self configureTableViewFooterWithType:EGOTableViewFooterEmpty];
    }
}

- (void)configureTableViewHeaderFooter {
    [self configureTableViewHeader];
    [self configureTableViewFooter];
}

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
        outlineCell.titleLabel.text = activity.title;
        outlineCell.locationLabel.text = activity.location;
        outlineCell.timeLabel.text = [NSString timeConvertFromBeginDate:activity.begin_time endDate:activity.end_time];
        outlineCell.likeCountLabel.text = [NSString stringWithFormat:@"%d赞", activity.like_count.intValue];
    }
}

- (void)configureRequest:(NSFetchRequest *)request
{
    [request setEntity:[NSEntityDescription entityForName:@"Activity" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"channel_id IN %@", [NSUserDefaults getFollowedChannelArray]];
    [request setPredicate:predicate];
    NSSortDescriptor *sortByLike = [[NSSortDescriptor alloc] initWithKey:@"like_count" ascending:NO];
    NSSortDescriptor *sortByBegin = [[NSSortDescriptor alloc] initWithKey:@"begin_time" ascending:YES];
    ChannelSortMethod methodCode = [NSUserDefaults getChannelSortMethod];
    NSArray *descriptors = nil;
    if(methodCode == ChannelSortByLikeCount)
        descriptors = [NSArray arrayWithObjects:sortByLike, sortByBegin, nil];
    else 
        descriptors = [NSArray arrayWithObjects:sortByBegin, sortByLike, nil];
    [request setSortDescriptors:descriptors]; 
    request.fetchBatchSize = 20;
}

- (void)insertCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureTableViewFooter];
}

#pragma mark -
#pragma mark EGORefresh Method

- (void)refresh {
    //[self hideLoadMoreDataButton];
    [self loadMoreData];
}

- (void)clearData
{
    
}

- (void)loadMoreData {
    WTClient *client = [WTClient client];
    [client setCompletionBlock:^(WTClient *client) {
        if(!client.hasError) {
            NSDictionary *dict = client.responseJSONObject;
            NSDictionary *data = [dict objectForKey:@"Data"];
            NSArray *array = [data objectForKey:@"Activities"];
            for(NSDictionary *activityDict in array) {
                [Activity insertActivity:activityDict inManagedObjectContext:self.managedObjectContext];
            }
        }
        [self doneLoadingTableViewData];
    }];
    [client getActivitesWithChannelIds:[NSUserDefaults getChannelFollowStatusString] page:1];
}

@end
