//
//  User.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-15.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * account;
@property (nonatomic, retain) NSString * avatar_link;
@property (nonatomic, retain) NSString * birth_place;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSString * display_name;
@property (nonatomic, retain) NSString * email_address;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * has_login;
@property (nonatomic, retain) NSNumber * is_current_user;
@property (nonatomic, retain) NSDate * login_time;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone_number;
@property (nonatomic, retain) NSString * qq_number;
@property (nonatomic, retain) NSString * session;
@property (nonatomic, retain) NSString * sina_weibo_name;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSSet *favor;
@property (nonatomic, retain) NSSet *schedule;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addFavorObject:(Event *)value;
- (void)removeFavorObject:(Event *)value;
- (void)addFavor:(NSSet *)values;
- (void)removeFavor:(NSSet *)values;

- (void)addScheduleObject:(Event *)value;
- (void)removeScheduleObject:(Event *)value;
- (void)addSchedule:(NSSet *)values;
- (void)removeSchedule:(NSSet *)values;

@end
