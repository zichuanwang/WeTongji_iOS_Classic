//
//  Image+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Image.h"

@interface Image (Addition)

+ (Image *)imageWithURL:(NSString *)url inManagedObjectContext:(NSManagedObjectContext *)context;
+ (Image *)insertImage:(NSData *)data withURL:(NSString *)url inManagedObjectContext:(NSManagedObjectContext *)context;
+ (void)clearCacheInContext:(NSManagedObjectContext *)context;
+ (void)clearAllCacheInContext:(NSManagedObjectContext *)context;

@end
