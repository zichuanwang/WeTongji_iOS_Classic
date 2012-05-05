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
#import "NSUserDefaults+Addition.h"

static NSString* const APIDomain = @"106.187.95.107:8080";

@interface WTClient()

@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) ASIHTTPRequest *request;
@property (nonatomic, assign, getter = isSessionRequired) BOOL sessionRequired;
@property (nonatomic, assign, getter = isCurrentUserIDRequired) BOOL currentUserIDRequired;

@end

@implementation WTClient

@synthesize responseStatusCode = _responseStatusCode;
@synthesize hasError = _hasError;
@synthesize errorDesc = _errorDesc;
@synthesize responseData = _responseData;

@synthesize params = _params;
@synthesize request = _request;
@synthesize sessionRequired = _sessionRequired;
@synthesize currentUserIDRequired = _currentUserIDRequired;

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
    [_errorDesc release];
    [_completionBlock release];
    [_params release];
    [_request release];
    [_responseData release];
    [super dealloc];
}

- (id)init {
    self = [super init];
    if(self) {
        self.params = [[NSMutableDictionary alloc] initWithCapacity:10];
        self.hasError = NO;
        self.responseStatusCode = 0;
        
        self.request = [[ASIHTTPRequest alloc] initWithURL:nil];
        self.request.delegate = self;
        
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
            NSLog(@"error %@", self.errorDesc);
            goto report_completion;
        }
    }
    
    id responseJSONObject = [request.responseString JSONValue];
    NSLog(@"respond dict:%@", responseJSONObject);
    
    if ([responseJSONObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary*)responseJSONObject;
        NSDictionary *status = [dict objectForKey:@"Status"];
        NSString *statusId = [status objectForKey:@"Id"];
        NSDictionary *data = [dict objectForKey:@"Data"];
        if(data && [statusId intValue] == 0) {
            self.responseData = data;
        } else {
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
    NSLog(@"%@", self.request.error);
    
    self.hasError = YES;
    self.errorDesc = @""; //to do
    
    //same block called when failed
    [self reportCompletion];
}

#pragma mark - 
#pragma mark URL generation

- (NSString *)hashQueryString:(NSString *)queryString {
    NSMutableString *result = [NSMutableString stringWithString:@"&H="];
    NSString *md5 = [queryString md5HexDigest];
    [result appendFormat:@"%@", md5];
    return result;
}

- (NSString *)queryString
{
    NSArray *names = [self.params allKeys];
    NSArray *sortedNames = [names sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
    }];    
    
    NSMutableString *result = [NSMutableString stringWithCapacity:10];
    for (int i = 0; i < [sortedNames count]; i++) {
        if (i > 0)
            [result appendString:@"&"];
        NSString *name = [sortedNames objectAtIndex:i];
        NSString *parameter = [self.params objectForKey:name];
        [result appendString:[NSString stringWithFormat:@"%@=%@", [name URLEncodedString], 
                           [parameter URLEncodedString]]];
    }
    NSString *hash = [self hashQueryString:result];
    [result appendFormat:@"%@", hash];
        
    return result;
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
    if ([self.request url]) {
        return;
    }
    
    if(self.isCurrentUserIDRequired)
        [self.params setObject:[NSUserDefaults getCurrentUserID] forKey:@"U"];
    if(self.isSessionRequired)
        [self.params setObject:[NSUserDefaults getCurrentUserSession] forKey:@"S"];

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

- (void)activateUser:(NSString *)name stutentNum:(NSString *)num password:(NSString *)password {
    [self.params setObject:@"User.Active" forKey:@"M"];
    [self.params setObject:name forKey:@"Name"];
    [self.params setObject:num forKey:@"NO"];
    [self.params setObject:password forKey:@"Password"];
    [self sendRequest];
}

- (void)login:(NSString *)num password:(NSString *)password {
    [self.params setObject:@"User.LogOn" forKey:@"M"];
    [self.params setObject:num forKey:@"NO"];
    [self.params setObject:password forKey:@"Password"];
    [self sendRequest];
}

- (void)logout {
    [self.params setObject:@"User.LogOut" forKey:@"M"];
    [self sendRequest];
}

- (void)updateUserDisplayName:(NSString *)display_name {
    [self.params setObject:@"User.Update" forKey:@"M"];
    self.currentUserIDRequired = YES;
    self.sessionRequired = YES;
    NSDictionary *itemDict = [NSDictionary dictionaryWithObjectsAndKeys:display_name, @"DisplayName", nil];
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:itemDict forKey:@"User"];
    NSString *userJSONStr = [userDict JSONRepresentation];
    NSLog(@"userJSONStr %@", userJSONStr);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nil];
    [request setPostValue:userJSONStr forKey:@"User"];
    self.request = request;
    request.delegate = self;
    [self sendRequest];
}

- (void)updateUserAvatar:(UIImage *)image {
    [self.params setObject:@"User.Update.Avatar" forKey:@"M"];
    self.currentUserIDRequired = YES;
    self.sessionRequired = YES;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:nil];
    request.delegate = self;
    [request addData:imageData forKey:@"Image"];
    self.request = request;
    [self sendRequest];
}

@end
