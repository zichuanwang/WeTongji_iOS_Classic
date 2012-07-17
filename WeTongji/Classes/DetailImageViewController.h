//
//  DetailImageViewController.h
//  SocialFusion
//
//  Created by He Ruoyun on 12-1-16.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailImageViewControllerDelegate;

@interface DetailImageViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, weak) id<DetailImageViewControllerDelegate> delegate;

- (IBAction)didClickSaveButton:(id)sender;

+ (DetailImageViewController *)showDetailImageWithURL:(NSString*)url context:(NSManagedObjectContext *)context;
+ (DetailImageViewController *)showDetailImageWithImage:(UIImage *)image;

@end

@protocol DetailImageViewControllerDelegate <NSObject>

@optional
- (void)detailImageViewControllerDidFinishShow;

@end

