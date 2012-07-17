//
//  NewsDetailViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"
#import "News+Addition.h"

@interface NewsDetailViewController : WTNavigationViewController

@property (nonatomic, weak) IBOutlet UIImageView *middleView;
@property (nonatomic, weak) IBOutlet UIView *bottomView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *publicationTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *newsCategoryLabel;
@property (nonatomic, weak) IBOutlet UIImageView *newsImageView;

- (id)initWithNews:(News *)news;

@end
