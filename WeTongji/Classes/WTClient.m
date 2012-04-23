//
//  WTClient.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WTClient.h"
#import "JSON.h"

@interface WTClient()

@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, retain) ASIHTTPRequest *request;

@end

@implementation WTClient

@synthesize responseJSONObject = _responseJSONObject;
@synthesize responseStatusCode = _responseStatusCode;
@synthesize hasError = _hasError;
@synthesize errorDesc = _errorDesc;

@synthesize params = _params;
@synthesize request = _request;
@synthesize path = _path;

- (void)setCompletionBlock:(void (^)(WTClient* client))completionBlock {
    [_completionBlock autorelease];
    _completionBlock = [completionBlock copy];
}

- (WTCompletionBlock)completionBlock {
    return _completionBlock;
}

+ (id)client
{
    //autorelease intentially ommited here
    return [[WTClient alloc] init];
}

- (void)dealloc
{
    NSLog(@"WeiboClient dealloc");
    [_responseJSONObject release];
    [_errorDesc release];
    [_completionBlock release];
    [super dealloc];
}

@end
