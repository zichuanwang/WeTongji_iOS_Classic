//
//  WTClient.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 Tongji Apple Club. All rights reserved.
//

#import "WTClient.h"
#import "JSON.h"
#import "NSString+URLEncoding.h"

static NSString* const APIDomain = @"106.187.95.107:8080";

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

+ (id)client {
    //autorelease intentially ommited here
    return [[WTClient alloc] init];
}

- (void)dealloc {
    NSLog(@"WeiboClient dealloc");
    [_responseJSONObject release];
    [_errorDesc release];
    [_completionBlock release];
    [_params release];
    [_path release];
    [_request release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if(self) {
        _params = [[NSMutableDictionary alloc] initWithCapacity:10];
        _hasError = NO;
        _responseStatusCode = 0;
        
        _request = [[ASIHTTPRequest alloc] initWithURL:nil];
        _request.delegate = self;
        
        [self.params setObject:@"iPhone" forKey:@"D"];
        [self.params setObject:@"1.0" forKey:@"V"];
    }
    return self;
}

- (void)reportCompletion {
    if (_completionBlock) {
        _completionBlock(self);
    }
    [self autorelease];
}

#pragma mark -
#pragma mark ASIHTTPRequest delegate

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"Request Finished");
    //NSLog(@"Response raw string:\n%@", [request responseString]);
    NSLog(@"Response code:%d", request.responseStatusCode);
    
    switch (request.responseStatusCode) {
        case 200: // OK: everything went awesome.
            break;
        default:
        {
            self.hasError = YES;
            self.errorDesc = [NSHTTPURLResponse localizedStringForStatusCode:request.responseStatusCode];
            goto report_completion;
        }
    }
    
    self.responseJSONObject = [request.responseString JSONValue];
    NSLog(@"respond dict:%@", self.responseJSONObject);
    
    if ([self.responseJSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary*)self.responseJSONObject;
        NSDictionary *status = [dic objectForKey:@"Status"];
        NSString *statusId = [status objectForKey:@"Id"];
        if([statusId intValue] != 0) {
            self.hasError = YES;
            self.responseStatusCode = [statusId intValue];
            self.errorDesc = [status objectForKey:@"Memo"];
            NSLog(@"Server responsed error code:%d\n\
                  desc: %@\n", self.responseStatusCode, self.errorDesc);
        }
    }
    
report_completion:
    [self reportCompletion];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"Request Failed");
    NSLog(@"%@", _request.error);
    
    self.hasError = YES;
    self.errorDesc = @""; //to do
    
    //same block called when failed
    [self reportCompletion];
}

#pragma mark - 
#pragma mark URL generation

- (NSString *)hashQueryString:(NSString *)queryString {
    NSMutableString *result = [NSMutableString stringWithString:queryString];
    NSString *md5 = [queryString md5HexDigest];
    [result appendFormat:@"&H=%@", md5];
    return result;
}

- (NSString *)queryString
{
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    
    NSArray *names = [_params allKeys];
    NSArray *sortedNames = [names sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
    }];
    
    for (int i = 0; i < [sortedNames count]; i++) {
        if (i > 0) {
            [str appendString:@"&"];
        }
        NSString *name = [sortedNames objectAtIndex:i];
        [str appendString:[NSString stringWithFormat:@"%@=%@", name, 
                           [self.params objectForKey:name]]];
    }
        
    return [self hashQueryString:str];
}

- (void)buildURL
{
    NSString* url = [NSString stringWithFormat:@"http://%@/%@", APIDomain, @"api/call"];
    
    if ([self.params count]) {
        url = [NSString stringWithFormat:@"%@?%@", url, [self queryString]];
    }
    
    NSURL *finalURL = [NSURL URLWithString:url];
    
    NSLog(@"requestURL: %@", finalURL);
    
    [self.request setURL:finalURL];
}

- (void)sendRequest
{
    if ([_request url]) {
        return;
    }
    
    [self buildURL];
    [self.request startAsynchronous];
}

#pragma mark -
#pragma mark APIs

- (void)getActivitesWithChannelIds:(NSString *)channelStatusStr page:(NSInteger)page {
    [self.params setObject:@"Activities.Get" forKey:@"M"];
    if(channelStatusStr) {
        [self.params setObject:channelStatusStr forKey:@"Channel_Ids"];
    }
    else {
        [self.params setObject:[NSString stringWithFormat:@"1,2,3,4"] forKey:@"Channel_Ids"];
    }
    if(page <= 0)
        page = 1;
    [self.params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"P"];
    [self sendRequest];
}

- (void)getNewsList:(NSInteger)page {
    [self.params setObject:@"News.GetList" forKey:@"M"];
    if(page <= 0)
        page = 1;
    [self.params setObject:[NSString stringWithFormat:@"%d", page] forKey:@"P"];
    [self sendRequest];
}

@end
