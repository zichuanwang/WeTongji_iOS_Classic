//
//  CoreDataTableViewController.h
//  PushBox
//
//  Created by Xie Hasky on 11-7-24.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataViewController.h"

@interface CoreDataTableViewController : CoreDataViewController <NSFetchedResultsControllerDelegate, 
UITableViewDelegate, UITableViewDataSource> {
    BOOL _noAnimationFlag;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, readonly) NSInteger numberOfRowsInFirstSection;

//methods to override
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)configureRequest:(NSFetchRequest *)request;
- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)customCellClassName;
- (NSString *)customSectionNameKeyPath;

@end
