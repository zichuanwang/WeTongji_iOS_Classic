//
//  User+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@interface User (Addition)

- (void)initWithDict:(NSDictionary *)dict;
+ (User *)insertUser:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;
+ (User *)userWithID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context;

@end
