//
//  TreizeViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "TreizeViewController.h"

@interface TreizeViewController ()

@end

@implementation TreizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"ComingSoonViewController" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configureNavBar];
    [self configurePlaceHolder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark UI methods

- (void)configureNavBar {
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"treize"];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *nextButton = [UIBarButtonItem getFunctionButtonItemWithTitle:@"网店" target:self action:@selector(didClickStoreButton)];
    self.navigationItem.rightBarButtonItem = nextButton;
}

- (void)configurePlaceHolder {
    self.placeHolderImageView.image = [UIImage imageNamed:@"coming_soon_treize"];
    self.comingSoonLabel.hidden = YES;
    self.descriptionLabel.hidden = YES;
}

#pragma mark -
#pragma mark IBActions

- (void)didClickStoreButton {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://treize13.taobao.com"]];
}

@end
