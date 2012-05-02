//
//  WTTabelViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTTabelViewController.h"

@interface WTTabelViewController ()

@end

@implementation WTTabelViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.tableView = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

#pragma mark -
#pragma mark UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [self customCellClassNameAtIndexPath:indexPath];
    if(!name)
        name = [self customCellClassName];
    
    NSString *CellIdentifier = name ? name : @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (name) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
            cell = [nib lastObject];
        }
        else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark -
#pragma mark Methods to overwrite

- (NSString *)customCellClassName
{
    return nil;
}

- (NSString *)customCellClassNameAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

@end
