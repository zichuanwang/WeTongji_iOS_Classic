//
//  Activity.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * activity_description;
@property (nonatomic, retain) NSString * activity_id;
@property (nonatomic, retain) NSDate * begin_time;
@property (nonatomic, retain) NSNumber * can_follow;
@property (nonatomic, retain) NSNumber * can_hot;
@property (nonatomic, retain) NSNumber * can_like;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSNumber * follow_count;
@property (nonatomic, retain) NSNumber * hot_count;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * organizer;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * channel_id;
@property (nonatomic, retain) NSString * sub_organizer;

@end
