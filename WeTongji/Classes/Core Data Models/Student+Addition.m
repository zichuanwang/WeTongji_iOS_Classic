//
//  Student+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Student+Addition.h"
#import "User+Addition.h"

@implementation Student (Addition)

- (void)initWithDict:(NSDictionary *)dict {
    [super initWithDict:dict];
    self.degree = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"Degree"]] intValue]];
    self.plan = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"Plan"]] intValue]];
     self.enroll_year = [NSNumber numberWithInt:[[NSString stringWithFormat:@"%@", [dict objectForKey:@"Year"]] intValue]];
    self.department = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Department"]];
    self.major = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Major"]];
    self.student_number = [NSString stringWithFormat:@"%@", [dict objectForKey:@"NO"]];
}

+ (Student *)insertStudent:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSString *userID = [NSString stringWithFormat:@"%@",[dict objectForKey:@"UID"]];
    
    if (!userID || [userID isEqualToString:@""]) {
        return nil;
    }
    
    Student *result = [Student studentWithID:userID inManagedObjectContext:context];
    if (!result) {
        result = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:context];
    }
    result.user_id = userID;
    [result initWithDict:dict];
    return result;
}

+ (Student *)studentWithID:(NSString *)userID inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"user_id == %@", userID]];
    
    Student *result = [[context executeFetchRequest:request error:NULL] lastObject];
    
    return result;
}

@end
