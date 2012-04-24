//
//  WTClient.m
//  WeTongji
//
//  Created by 紫川 王 on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
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
        default:
        {
            self.hasError = YES;
            self.errorDesc = [NSHTTPURLResponse localizedStringForStatusCode:request.responseStatusCode];
            goto report_completion;
        }
    }
    
    self.responseJSONObject = [request.responseString JSONValue];
    
    if ([self.responseJSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary* dic = (NSDictionary*)self.responseJSONObject;
        NSString* errorCodeString = [dic objectForKey:@"error_code"];
        
        if (errorCodeString) {
            self.hasError = YES;
            self.responseStatusCode = [errorCodeString intValue];
            self.errorDesc = [dic objectForKey:@"error"];
            NSLog(@"Server responsed error code: %d\n\
                  desc: %@\n\
                  url: %@\n", self.responseStatusCode, self.errorDesc, request.url);
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

- (NSString *)queryString
{
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    
    NSArray *names = [_params allKeys];
    for (int i = 0; i < [names count]; i++) {
        if (i > 0) {
            [str appendString:@"&"];
        }
        NSString *name = [names objectAtIndex:i];
        [str appendString:[NSString stringWithFormat:@"%@=%@", [name URLEncodedString], 
                           [[self.params objectForKey:name] URLEncodedString]]];
    }
    
    return str;
}

- (void)buildURL
{
    NSString* url = [NSString stringWithFormat:@"http://%@/%@", APIDomain, self.path];
    
    if ([self.params count]) {
        url = [NSString stringWithFormat:@"%@?%@", url, [self queryString]];
    }
    
    NSURL *finalURL = [NSURL URLWithString:url];
    
    NSLog(@"requestURL: %@", finalURL);
    
    [_request setURL:finalURL];
}

- (void)sendRequest
{
    if ([_request url]) {
        return;
    }
    
    [self buildURL];
    
    [self.request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    self.request.requestMethod = @"POST";
    NSString *postBody = [self queryString];
    NSMutableData *postData = [[[NSMutableData alloc] initWithData:[postBody dataUsingEncoding:NSUTF8StringEncoding]] autorelease];
    [self.request setPostBody:postData];
    
    [self.request startAsynchronous];
}

#pragma mark -
#pragma mark APIs

- (void)getChannel {
    self.path = @"channel";
    [self.params setObject:@"channel.get" forKey:@"m"];
    [self sendRequest];
}

@end
