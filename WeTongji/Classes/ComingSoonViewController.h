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

@property (nonatomic, weak) IBOutlet UIView *mainBgView;
@property (nonatomic, weak) IBOutlet UIImageView *placeHolderImageView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UILabel *comingSoonLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end
