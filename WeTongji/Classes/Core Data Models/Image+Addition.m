//
//  Image+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-9.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "Image+Addition.h"

@implementation Image (Addition)

+ (Image *)imageWithURL:(NSString *)url inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Image" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"url == %@", url]];
    
    Image *res = [[context executeFetchRequest:request error:NULL] lastObject];
    return res;
}

+ (Image *)insertImage:(NSData *)data withURL:(NSString *)url inManagedObjectContext:(NSManagedObjectContext *)context {
    
    if (!url || [url isEqualToString:@""]) {
        return nil;
    }
    
    Image *image = [self imageWithURL:url inManagedObjectContext:context];
    
    if (!image) {
        image = [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:context];
    }
    
    image.image = [UIImage imageWithData:data];
    image.url = url;
    image.update_date = [NSDate date];
    return image;
}

@end
