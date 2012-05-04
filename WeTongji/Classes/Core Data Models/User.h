//
//  User.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * avatar_link;
@property (nonatomic, retain) NSString * birth_place;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * email_address;
@property (nonatomic, retain) NSString * mobile_phone;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * weibo_account;
@property (nonatomic, retain) NSSet *favor;
@property (nonatomic, retain) NSSet *schedule;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFavorObject:(Activity *)value;
- (void)removeFavorObject:(Activity *)value;
- (void)addFavor:(NSSet *)values;
- (void)removeFavor:(NSSet *)values;

- (void)addScheduleObject:(Activity *)value;
- (void)removeScheduleObject:(Activity *)value;
- (void)addSchedule:(NSSet *)values;
- (void)removeSchedule:(NSSet *)values;

@end
