//
//  LGNotificationsRequest.m
//  diamondCard
//
//  Created by user-letsgo6 on 08.12.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGNotificationsRequest.h"
#import "NSDictionary+LGHTTP.h"
#import "NSMutableURLRequest+LGHTTP.h"

@interface LGNotificationsRequest()
@property (strong,nonatomic) NSURLRequest *request;
@end;

@implementation LGNotificationsRequest

- (instancetype) initPostSubscriveToNotificationsRequestWithToken:(NSString *)token {
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"POST";
    loginRequest.URL = [NSURL URLWithString:@"https://diamond-card.herokuapp.com/API/subscribe"];
    NSDictionary * params = @{
                              @"key":token
                              };
    
    NSString * encodedString = [params encodedStringWithHttpBody];
    NSData *bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    [loginRequest setBodyData:bodyData isJSONData:NO];
    
    self.request = loginRequest;
    
    return self;
}


@end
