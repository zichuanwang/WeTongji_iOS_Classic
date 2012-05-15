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
    
    NSString *planStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Plan"]];
    if(![planStr isEqualToString:@"<null>"])
        self.plan = [NSNumber numberWithInt:[planStr intValue]];
    NSString *enrollYearStr = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Year"]];
    if(![enrollYearStr isEqualToString:@"<null>"])
        self.enroll_year = [NSNumber numberWithInt:[enrollYearStr intValue]];
    NSLog(@"enroll_year:%d", self.enroll_year.integerValue);
    
    self.department = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Department"]];
    self.major = [NSString stringWithFormat:@"%@", [dict objectForKey:@"Major"]];
    self.major = [self.major stringByReplacingOccurrencesOfString:@"（" withString:@"("];
    self.major = [self.major stringByReplacingOccurrencesOfString:@"）" withString:@")"];
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
