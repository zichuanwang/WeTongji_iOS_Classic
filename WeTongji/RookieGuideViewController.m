//
//  RookieGuideViewController.m
//  WeTongji
//
//  Created by Ziqi on 12-9-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RookieGuideViewController.h"
#import "MWPhotoBrowser.h"
#import "UIViewController+RECurtainViewController.h"
@interface RookieGuideViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic ,strong) NSArray *guidePhotos;
@property (nonatomic ,strong) MWPhotoBrowser *browser;
@end

@implementation RookieGuideViewController
@synthesize guidePhotos = _guidePhotos;
@synthesize browser = _browser;

- (NSArray *)guidePhotos
{
    if (_guidePhotos == nil) {
        _guidePhotos = [NSArray arrayWithObjects:
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"1-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"2-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"3-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"4-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"5-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"6-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"7-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"8-new" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"9-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"10-1" ofType:@"jpg"]],
                        [MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"11-1" ofType:@"jpg"]],
                        nil];
    }
    return _guidePhotos;
}

- (MWPhotoBrowser *)browser
{
    if (_browser == nil) {
        _browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _browser.displayActionButton = YES;
    }
    return _browser;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新生指南";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.browser = nil;
    self.guidePhotos = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.guidePhotos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.guidePhotos.count)
        return [self.guidePhotos objectAtIndex:index];
    return nil;
}

- (IBAction)seeDetail:(id)sender
{
    [self curtainRevealViewController:self.browser fromViewController:self transitionStyle:RECurtainTransitionHorizontal];
}

@end
