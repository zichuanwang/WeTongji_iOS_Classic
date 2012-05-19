//
//  SettingInfoReader.m
//  WeTongji
//
//  Created by 紫川 王 on 12-5-6.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#define kSettingInfoSectionArray        @"kSettingInfoSectionArray"
#define kSectionName                    @"kSectionName"
#define kSectionArray                   @"kSectionArray"

#define kWayToPresentViewController     @"kWayToPresentViewController"
#define kNibFileName                    @"kNibFileName"
#define kAccessoryType                  @"kAccessoryType"
#define kItemTitle                      @"kItemTitle"

#import "SettingInfoReader.h"

@interface SettingInfoReader()

@property (nonatomic, strong) NSDictionary *settingInfoMap;

@end

@implementation SettingInfoReader

@synthesize settingInfoMap = _settingInfoMap;

- (id)init {
    self = [super init];
    if(self) {
        [self readPlist];
    }
    return self;
}

- (void)readPlist {
    NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"SettingInfo" ofType:@"plist"];  
    self.settingInfoMap = [[NSDictionary alloc] initWithContentsOfFile:configFilePath]; 
}

- (NSArray *)getSettingInfoSectionArray {
    NSArray *sectonArray = [NSArray arrayWithArray:[self.settingInfoMap objectForKey:kSettingInfoSectionArray]];
    NSMutableArray *result = [NSMutableArray array];
    for(NSDictionary *sectionDict in sectonArray) {
        SettingInfoSection *section = [[SettingInfoSection alloc] init];
        section.sectionTitle = [sectionDict objectForKey:kSectionName];
        NSArray *infoArray = [sectionDict objectForKey:kSectionArray];
        NSMutableArray *parsedInfoArray = [NSMutableArray arrayWithCapacity:4];
        for(NSDictionary *infoDict in infoArray) {
            SettingInfo *info = [[SettingInfo alloc] init];
            info.itemTitle = [infoDict objectForKey:kItemTitle];
            info.nibFileName = [infoDict objectForKey:kNibFileName];
            info.accessoryType = [infoDict objectForKey:kAccessoryType];
            info.wayToPresentViewController = [infoDict objectForKey:kWayToPresentViewController];
            [parsedInfoArray addObject:info];
        }
        section.itemArray = parsedInfoArray;
        [result addObject:section];
    }
    return result;
}

@end

@implementation SettingInfoSection

@synthesize sectionTitle = _sectionTitle;
@synthesize itemArray = _itemArray;

@end

@implementation SettingInfo

@synthesize itemTitle = _itemTitle;
@synthesize nibFileName = _nibFileName;
@synthesize wayToPresentViewController = _wayToPresentViewController;
@synthesize accessoryType = _accessoryType;

@end
