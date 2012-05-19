//
//  EventDetailViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-18.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

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
    [self configureNavBarBackButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBarBackButton {
    UIBarButtonItem *leftButton = nil;
    if(self.navigationController.viewControllers.count > 1)
        leftButton = [UIBarButtonItem getBackButtonItemWithTitle:@"返回" target:self action:@selector(didClickBackButton)];
    else
        leftButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"完成" target:self action:@selector(didClickFinishButton)];
    self.navigationItem.leftBarButtonItem = leftButton;

}

#pragma mark - 
#pragma mark IBActions 

- (void)didClickBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didClickFinishButton {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
