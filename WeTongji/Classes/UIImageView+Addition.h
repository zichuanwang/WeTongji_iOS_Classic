//
//  UIImageView+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Addition)

@property (nonatomic, assign, readonly) CGFloat contentScaleFactor;

- (void)loadImageFromURL:(NSString *)urlString 
              completion:(void (^)(BOOL succeed))completion 
          cacheInContext:(NSManagedObjectContext *)context;

- (void)loadImageFromURL:(NSString *)urlString cacheInContext:(NSManagedObjectContext *)context;

@end
