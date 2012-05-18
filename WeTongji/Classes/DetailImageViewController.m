//
//  DetailImageViewController.m
//  SocialFusion
//
//  Created by He Ruoyun on 12-1-16.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "DetailImageViewController.h"
#import  <QuartzCore/QuartzCore.h>
#import "Image+Addition.h"
#import "UIImage+Addition.h"
#import "UIApplication+Addition.h"
#import "UIImageView+Addition.h"
#import "UIView+Addition.h"
#import "NSString+Addition.h"

#define IMAGE_MAX_WIDTH     320
#define IMAGE_MAX_HEIGHT    480

@interface DetailImageViewController()

- (void)hideActivityView;
- (void)showActivityView;

@end

@implementation DetailImageViewController

@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;
@synthesize saveButton = _saveButton;
@synthesize activityView = _activityView;
@synthesize delegate = _delegate;
@synthesize webView = _webView;

- (void)viewDidUnload {
    [super viewDidUnload];
    self.imageView = nil;
    self.scrollView = nil;
    self.saveButton = nil; 
    self.activityView = nil;
    self.webView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* gesture;
    gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [self.scrollView addGestureRecognizer:gesture];
    
    self.activityView.hidden = YES;
}

- (id)init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    
    self.imageView.image = image;
    
    CGRect frame = self.imageView.frame;
    CGSize size = self.imageView.image.size;
    
    if(size.width > IMAGE_MAX_WIDTH) {
        size.height *= IMAGE_MAX_WIDTH / size.width;
        size.width = IMAGE_MAX_WIDTH;
    }
    
    frame.size = size;
    self.imageView.frame = frame;
    
    if (size.height <= 480) 
        frame.origin.y = 480/2 - size.height/2;
    else 
        frame.origin.y = 0;
    
    if (size.width <= 320) 
        frame.origin.x = 320/2 - size.width/2;
    else
        frame.origin.x = 0;
    
    self.imageView.frame = frame;
    self.scrollView.contentSize = size;
    
    [self.imageView fadeIn];
}

#pragma mark -
#pragma mark Save image methos

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(!error) {
        [UIApplication presentToast:@"保存成功。" withVerticalPos:DefaultToastVerticalPosition];
    }
    else {
        [UIApplication presentAlertToast:@"保存失败。" withVerticalPos:DefaultToastVerticalPosition];
    }
    [self hideActivityView];
}

- (void)saveImageInBackground {
    [self showActivityView];
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark -
#pragma mark IBActions

- (IBAction)didClickSaveButton:(id)sender {
    [self performSelectorInBackground:@selector(saveImageInBackground) withObject:nil];
}

#pragma mark -
#pragma mark Dismiss view methods

- (void)dismissView
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [UIApplication dismissModalViewController];
        if(self.delegate && [self.delegate respondsToSelector:@selector(detailImageViewControllerDidFinishShow)]) {
            [self.delegate detailImageViewControllerDidFinishShow];
        }
    }];
}

#pragma mark -
#pragma mark UIScrollView delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGSize size = _imageView.frame.size;
    CGRect frame = self.imageView.frame;
    
    if (size.height <= 480) 
        frame.origin.y = 480/2 - size.height/2;
    else 
        frame.origin.y = 0;
    
    if (size.width <= 320) 
        frame.origin.x = 320/2 - size.width/2;
    else 
        frame.origin.x = 0;

    self.imageView.frame = frame;
    self.scrollView.contentSize = size;
}

- (void)hideActivityView {
    self.activityView.alpha = 1.0f;
    [UIView animateWithDuration:0.3f animations:^(void) {
        self.activityView.alpha = 0;
        [self.activityView stopAnimating];
    }];
}

- (void)showActivityView {
    self.activityView.hidden = NO;
    self.activityView.alpha = 1.0f;
    [self.activityView startAnimating];
}

- (void)loadImageWithURL:(NSString *)url context:(NSManagedObjectContext *)context {
    if([url isGifURL]) {
        [self.imageView setHidden:YES];
        [self.saveButton setHidden:YES];
        NSString* htmlStr = [NSString stringWithFormat:@"<html><head><link href=\"pocketsocial.css\" rel=\"stylesheet\" type=\"text/css\"/></head><body><div id=\"gifImg\"><span><img src=\"%@\" alt=""/></span></div></body></html>", url];
        [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    }
    else {
        [self.webView setHidden:YES];
        [self showActivityView];
        [self.imageView loadImageFromURL:url completion:^(BOOL succeed) {
            if(succeed) {
                [self setImage:self.imageView.image];
            }
            [self hideActivityView];
        } cacheInContext:context];
    }
}

- (void)show {
    self.view.alpha = 0;
    [UIApplication presentModalViewController:self animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.7f animations:^{
        self.view.alpha = 1;
    }];
}

+ (DetailImageViewController *)showDetailImageWithURL:(NSString*)bigURL context:(NSManagedObjectContext *)context {
    if(!bigURL)
        return nil;
    DetailImageViewController *vc = [[DetailImageViewController alloc] init];
    [vc show];
    [vc loadImageWithURL:bigURL context:context];
    return vc;
}

+ (DetailImageViewController *)showDetailImageWithImage:(UIImage *)image {
    if(!image)
        return nil;
    DetailImageViewController *vc = [[DetailImageViewController alloc] init];
    [vc show];
    [vc setImage:image];
    return vc;
}

#pragma mark -
#pragma mark UIWebView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.webView setHidden:YES];
    [self showActivityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webView setHidden:NO];
    self.webView.alpha = 0;
    [UIView animateWithDuration:0.3f animations:^{
        self.webView.alpha = 1;
    }];
    [self hideActivityView];
    self.webView.scrollView.contentOffset = CGPointMake((self.webView.scrollView.contentSize.width - 320.0f), (self.webView.scrollView.contentSize.height - 480.0f) / 2);
}

@end
