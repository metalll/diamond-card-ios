//
//  DCRequest.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "DCRequest.h"
#import "NSDictionary+LGHTTP.h"
#import "NSMutableURLRequest+LGHTTP.h"

NSString * const DCLogninURL = @"https://diamond-card.herokuapp.com/login";
NSString * const DCCurrentUser = @"https://diamond-card.herokuapp.com/auth";


@interface DCRequest()
@property (strong,nonatomic) NSURLRequest *request;
@end

@implementation DCRequest

- (instancetype)initLoginRequestWithLogin:(NSString *)login
                                 password:(NSString *)password {
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"POST";
    loginRequest.URL = [NSURL URLWithString:DCLogninURL];
    NSDictionary * params = @{
                              @"username":login,
                              @"password":password
                              };
    
    NSString * encodedString = [params encodedStringWithHttpBody];
    NSData *bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    [loginRequest setBodyData:bodyData isJSONData:NO];
    
    self.request = loginRequest;
    
    return self;
}

- (instancetype)initRequetCurrentUserAuthRole {
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * Crequest = [NSMutableURLRequest new];
    Crequest.HTTPMethod = @"POST";
    Crequest.URL = [NSURL URLWithString:DCCurrentUser];
    Crequest.cachePolicy = NSURLCacheStorageNotAllowed;
    self.request = Crequest;
    
    return self;
}

- (NSURLRequest *)request {
    return [_request copy];
}

- (instancetype)initLogout {
    self = [super init];
    if (!self) {
        return self;
    }
    
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"GET";
    loginRequest.URL = [NSURL URLWithString:@"https://diamond-card.herokuapp.com/logout"];
    self.request = loginRequest;
    
    return self;
}

@end
