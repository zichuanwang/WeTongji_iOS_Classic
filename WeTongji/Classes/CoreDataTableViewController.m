//
//  CoreDataTableViewController.m
//  PushBox
//
//  Created by Xie Hasky on 11-7-24.
//  Copyright 2011年 同济大学. All rights reserved.
//

#import "CoreDataTableViewController.h"

@implementation CoreDataTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;
@synthesize tableView = _tableView;

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tableView = nil;
    self.fetchedResultsController.delegate = nil;
    self.fetchedResultsController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark to_override
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)configureRequest:(NSFetchRequest *)request
{
    
}

- (NSString *)customCellClassName
{
    return nil;
}

- (NSString *)customSectionNameKeyPath {
    return nil;
}

- (void)insertCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
}

- (void)deleteCellAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if(!_noAnimationFlag)
        [self.tableView beginUpdates];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [self configureRequest:fetchRequest];

    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:[self customSectionNameKeyPath] cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	[self.fetchedResultsController performFetch:NULL];
    
    return _fetchedResultsController;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [self customCellClassName];
    
    NSString *CellIdentifier = name ? name : @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (name) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:[self customCellClassName] owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
                         atIndexPath:indexPath];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    if(_noAnimationFlag)
        return;
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            //NSLog(@"did insert");
            [self insertCellAtIndexPath:newIndexPath];
            break;
            
        case NSFetchedResultsChangeDelete:
            // NSLog(@"did delete");
            [self deleteCellAtIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeUpdate:
            // NSLog(@"did update");
            [self updateCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            // NSLog(@"did move");
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
	if(_noAnimationFlag)
        return;
    
	switch(type) {
			
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if(_noAnimationFlag)
        [self.tableView reloadData];
    else
        [self.tableView endUpdates];
}

- (NSInteger)numberOfRowsInFirstSection {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] lastObject];
    NSInteger count = [sectionInfo numberOfObjects];
    return count;
}

@end
