//
//  Image.h
//  WeTongji
//
//  Created by 紫川 王 on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Image : NSManagedObject

@property (nonatomic, retain) NSDate * update_date;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) id image;

@end
