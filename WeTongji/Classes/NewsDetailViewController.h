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

@property (nonatomic, strong) IBOutlet UIImageView *middleView;
@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *titleView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *publicationTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *newsCategoryLabel;
@property (nonatomic, strong) IBOutlet UIImageView *newsImageView;

- (id)initWithNews:(News *)news;

@end
