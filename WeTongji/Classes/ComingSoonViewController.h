//
//  ComingSoonViewController.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-17.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTNavigationViewController.h"

@interface ComingSoonViewController : WTNavigationViewController

@property (nonatomic, strong) IBOutlet UIView *mainBgView;
@property (nonatomic, strong) IBOutlet UIImageView *placeHolderImageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *comingSoonLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@end
