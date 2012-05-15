//
//  Event.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * what;
@property (nonatomic, retain) NSString * where;
@property (nonatomic, retain) NSDate * begin_time;
@property (nonatomic, retain) NSDate * end_time;
@property (nonatomic, retain) NSString * begin_day;
@property (nonatomic, retain) User *favoredBy;
@property (nonatomic, retain) User *scheduledBy;

@end
