//
//  CirclesViewController.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "CirclesViewController.h"

@interface CirclesViewController ()

@end

@implementation CirclesViewController

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
    UILabel *titleLabel = [UILabel getNavBarTitleLabel:@"圈子"];
    self.navigationItem.titleView = titleLabel;
}

- (void)configurePlaceHolder {
    self.placeHolderImageView.image = [UIImage imageNamed:@"coming_soon_circles"];
    self.descriptionLabel.text = @"群发通知 交换名片 关注好友动态";
}
@end
