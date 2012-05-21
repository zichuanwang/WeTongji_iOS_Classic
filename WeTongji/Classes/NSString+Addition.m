//
//  NSString+Addition.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-26.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

- (NSDate *)convertToDate {
    NSString *src = self;
    if([src characterAtIndex:src.length - 3] == ':') {
        src = [src stringByReplacingCharactersInRange:NSMakeRange(src.length - 3, 1) withString:@""];
    }
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    [form setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
    
    NSDate *date = [form dateFromString:src];
    return date;
}

+ (NSString *)yearMonthDayConvertFromDate:(NSDate *)date {
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    [form setDateFormat:@"yyyy年MM月dd日"];
    NSString *result = [form stringFromDate:date];
    return result;
}

+ (NSString *)weekDayConvertFromInteger:(NSInteger)weekday {
    NSString *weekdayStr = nil;
    switch (weekday) {
        case 1:
            weekdayStr = @"周日";
            break;
        case 2:
            weekdayStr = @"周一";
            break;
        case 3:
            weekdayStr = @"周二";
            break;
        case 4:
            weekdayStr = @"周三";
            break;
        case 5:
            weekdayStr = @"周四";
            break;
        case 6:
            weekdayStr = @"周五";
            break;
        case 7:
            weekdayStr = @"周六";
            break;
            
        default:
            break;
    }
    return weekdayStr;
}

+ (NSString *)yearMonthDayWeekConvertFromDate:(NSDate *)date {
    NSString *result = [NSString yearMonthDayConvertFromDate:date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSWeekdayCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int weekday = [comps weekday];
    
    NSString *weekdayStr = [NSString weekDayConvertFromInteger:weekday];
    result = [NSString stringWithFormat:@"%@(%@)", result, weekdayStr];
    
    return result;
}

+ (NSString *)yearMonthDayWeekTimeConvertFromDate:(NSDate *)date {
    NSString *result = [NSString yearMonthDayWeekConvertFromDate:date];
    result = [NSString stringWithFormat:@"%@%@", result, [NSString timeConvertFromDate:date]];
    return result;
}

+ (NSString *)timeConvertFromDate:(NSDate *)date {
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    [form setDateFormat:@"HH:mm"];
    NSString *result = [form stringFromDate:date];
    return result;
}

+ (NSString *)timeConvertFromBeginDate:(NSDate *)begin endDate:(NSDate *)end {
    NSString *timeStr = [NSString yearMonthDayWeekTimeConvertFromDate:begin];
    timeStr = [NSString stringWithFormat:@"%@-%@", timeStr, [NSString timeConvertFromDate:end]];
    return timeStr;
}

- (BOOL)isSuitableForPassword {
    BOOL result = YES;
    NSString *password = self;
    for(int i = 0; i < password.length; i++) {
        unichar c = [password characterAtIndex:i];
        if(isalnum(c) == 0 && c != '_') {
            result = NO;
            break;
        }
    }
    return result;
}

- (NSNumber *)weekDayStringCovertToNumber {
    NSNumber *result = nil;
    NSInteger weekDay = -1;
    if([self isEqualToString:@"星期一"]) 
        weekDay = 0;
    else if([self isEqualToString:@"星期二"])
        weekDay = 1;
    else if([self isEqualToString:@"星期三"])
        weekDay = 2;
    else if([self isEqualToString:@"星期四"])
        weekDay = 3;
    else if([self isEqualToString:@"星期五"])
        weekDay = 4;
    else if([self isEqualToString:@"星期六"])
        weekDay = 5;
    else if([self isEqualToString:@"星期日"])
        weekDay = 6;
    result = [NSNumber numberWithInteger:weekDay];
    return result;
}

+ (NSString *)getTodayBeginDayFormatString {
    return [NSString yearMonthDayWeekConvertFromDate:[NSDate date]];
}

+ (NSString *)getTomorrowBeginDayFormatString {
    return [NSString yearMonthDayWeekConvertFromDate:[[NSDate date] dateByAddingTimeInterval:60 * 60 * 24]];
}

- (BOOL)isGifURL {
    BOOL result = NO;
    NSString* extName = [self substringFromIndex:([self length] - 3)];
    if ([extName compare:@"gif"] == NSOrderedSame)
        result =  YES;
    return result;
}

+ (NSString *)standardDateStringCovertFromDate:(NSDate *)date {
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    [form setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"];
    NSString *result = [form stringFromDate:date];
    NSLog(@"standard:%@", result);
    return result;
}

- (NSString*)setPublishTimeHTMLString:(NSDate *)date {
    NSArray* array = [self componentsSeparatedByString:@"@#PublishTime#@"];
    NSString *time = [NSString yearMonthDayConvertFromDate:date];
    NSString* returnString = [[NSString alloc] initWithFormat:@"%@发表于 %@%@", [array objectAtIndex:0], time, [array objectAtIndex:1]];
    return returnString;
}

- (NSString*)setContentHTMLString:(NSString*)content {
    NSArray* array = [self componentsSeparatedByString:@"@#Content#@"];
    NSString* returnString = [[NSString alloc] initWithFormat:@"%@%@%@", [array objectAtIndex:0], content, [array objectAtIndex:1]];
    return returnString;
}

- (NSString*)setTitleHTMLString:(NSString*)title {
    NSArray* array = [self componentsSeparatedByString:@"@#Title#@"];
    NSString* returnString = [[NSString alloc] initWithFormat:@"%@%@%@",[array objectAtIndex:0], title, [array objectAtIndex:1]];
    return returnString;
}

@end
