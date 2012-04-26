//
//  NSString+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



@interface NSString (Addition)

- (NSDate *)convertToDate;
+ (NSString *)monthDayWeekTimeConvertFromDate:(NSDate *)date;
+ (NSString *)timeConvertFromDate:(NSDate *)date;

@end
