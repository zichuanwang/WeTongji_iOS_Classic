//
//  MetroInfoReader.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-30.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//
    
#define kMetroInfoArray         @"kMetroInfoArray"
#define kButtonTitle            @"kButtonTitle"
#define kNibFileName            @"kNibFileName"
#define kButtonImageFileName    @"kButtonImageFileName"
#define kAlertMessage           @"kAlertMessage"

#import "MetroInfoReader.h"

@interface MetroInfoReader()

@property (nonatomic, strong) NSDictionary *metroInfoMap;

@end

@implementation MetroInfoReader

@synthesize metroInfoMap = _metroInfoMap;

- (id)init {
    self = [super init];
    if(self) {
        [self readPlist];
    }
    return self;
}

- (void)readPlist {
    NSString *configFilePath = [[NSBundle mainBundle] pathForResource:@"MetroInfo" ofType:@"plist"];  
    self.metroInfoMap = [[NSDictionary alloc] initWithContentsOfFile:configFilePath]; 
}

- (NSArray *)getMetroInfoArray {
    NSArray *infoArray = [NSArray arrayWithArray:[self.metroInfoMap objectForKey:kMetroInfoArray]];
    NSMutableArray *result = [NSMutableArray array];
    for(NSDictionary *dict in infoArray) {
        MetroInfo *info = [[MetroInfo alloc] init];
        NSString *imageFileName = [dict objectForKey:kButtonImageFileName];
        info.buttonImageFileName = [NSString stringWithFormat:@"%@.png", imageFileName];
        info.buttonHighlightImageFileName = [NSString stringWithFormat:@"%@_hl.png", imageFileName];
        info.buttonTitle = [dict objectForKey:kButtonTitle];
        info.nibFileName = [dict objectForKey:kNibFileName];
        info.alertMessage = [dict objectForKey:kAlertMessage];
        [result addObject:info];
    }
    return result;
}

@end

@implementation MetroInfo

@synthesize buttonTitle = _buttonTitle;
@synthesize nibFileName = _nibFileName;
@synthesize buttonImageFileName = _buttonImageFileName;
@synthesize buttonHighlightImageFileName = _buttonHighlightImageFileName;
@synthesize alertMessage = _alertMessage;

@end
