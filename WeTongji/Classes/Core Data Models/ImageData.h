//
//  ImageData.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Image;

@interface ImageData : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) Image *owner;

@end
