//
//  User+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "User+Addition.h"
#import "NSString+Addition.h"

@implementation User (Addition)

- (void)initWithDict:(NSDictionary *)dict {
    self.name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Name"]];
    self.avatar_link = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Avatar"]];
    self.display_name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"DisplayName"]];
    self.birthday = [[NSString stringWithFormat:@"%@", [dict objectForKey:@"Birthday"]] convertToDate];
    self.gender = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Gender"]];
    self.birth_place = [NSString stringWithFormat:@"%@", [dict objectForKey:@"NativePlace"]];
    self.qq_number = [NSString stringWithFormat:@"%@", [dict objectForKey:@"QQ"]];
    self.phone_number = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Phone"]];
    self.email_address = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Email"]];
    self.sina_weibo_name = [NSString stringWithFormat:@"%@", [dict objectForKey:@"SinaWeibo"]];
}

+ (User *)insertUser:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *userID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"UID"]];
    
    if (!userID || [userID isEqualToString:@""]) {
        return nil;
    }
    
    User *result = [User userWithID:userID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:context];
    }
    result.user_id = userID;
    [result initWithDict:dict];
    return result;
}

+ (User *)userWithID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"user_id == %@", userID]];
    
    User *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;
}

+ (User *)currentUserInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"is_current_user == YES"]];
    
    User *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;

}

+ (NSArray *)allObjectsInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];    
    [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    NSArray *result = [context executeFetchRequest:request error:NULL];
    return result;
}

+ (void)deleteAllObjectsInManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
    NSArray *items = [context executeFetchRequest:fetchRequest error:NULL];
    for (NSManagedObject *managedObject in items)
        [context deleteObject:managedObject];
}

+ (void)changeCurrentUser:(User *)newUser inManagedObjectContext:(NSManagedObjectContext *)context {
    NSArray *array = [User allObjectsInManagedObjectContext:context];
    for(User *user in array)
        user.is_current_user = [NSNumber numberWithBool:NO];
    newUser.is_current_user = [NSNumber numberWithBool:YES];
}

@end
