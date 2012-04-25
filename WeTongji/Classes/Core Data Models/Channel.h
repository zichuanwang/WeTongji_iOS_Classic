//
//  Channel.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * photo_link;
@property (nonatomic, retain) NSDate * begin_time;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSNumber * favorite_count;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSNumber * schedule_count;

@end
