//
//  Activity.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * activity_id;
@property (nonatomic, retain) NSString * avatar_link;
@property (nonatomic, retain) NSString * begin_day;
@property (nonatomic, retain) NSDate * begin_time;
@property (nonatomic, retain) NSNumber * can_favorite;
@property (nonatomic, retain) NSNumber * can_like;
@property (nonatomic, retain) NSNumber * can_schedule;
@property (nonatomic, retain) NSNumber * channel_id;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSNumber * favorite_count;
@property (nonatomic, retain) NSNumber * hidden;
@property (nonatomic, retain) NSNumber * like_count;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * organizer;
@property (nonatomic, retain) NSNumber * schedule_count;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * sub_organizer;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * channel_update_date;
@property (nonatomic, retain) NSDate * favorite_update_date;
@property (nonatomic, retain) User *favoredBy;
@property (nonatomic, retain) User *scheduledBy;

@end
