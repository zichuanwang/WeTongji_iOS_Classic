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

@property (nonatomic, strong) IBOutlet UIWebView *webView;

- (id)initWithNews:(News *)news;

@end
