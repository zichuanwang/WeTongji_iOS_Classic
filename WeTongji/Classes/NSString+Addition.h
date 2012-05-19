//
//  NSString+Addition.h
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//



@interface NSString (Addition)

- (NSDate *)convertToDate;
+ (NSString *)yearMonthDayConvertFromDate:(NSDate *)date;
+ (NSString *)yearMonthDayWeekConvertFromDate:(NSDate *)date;
+ (NSString *)yearMonthDayWeekTimeConvertFromDate:(NSDate *)date;
+ (NSString *)timeConvertFromDate:(NSDate *)date;
+ (NSString *)timeConvertFromBeginDate:(NSDate *)begin endDate:(NSDate *)end;
+ (NSString *)standardDateStringCovertFromDate:(NSDate *)date;
+ (NSString *)weekDayConvertFromInteger:(NSInteger)weekday;

- (BOOL)isSuitableForPassword;
- (NSNumber *)weekDayStringCovertToNumber;
+ (NSString *)getTodayBeginDayFormatString;
+ (NSString *)getTomorrowBeginDayFormatString;
- (BOOL)isGifURL;

@end
