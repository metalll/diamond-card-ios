//
//  DCCashbackRequest.m
//  diamondCard
//
//  Created by user-letsgo6 on 01.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "DCCashbackRequest.h"
#import "NSDictionary+LGHTTP.h"
#import "NSMutableURLRequest+LGHTTP.h"

@interface DCCashbackRequest()
@property (strong,nonatomic) NSURLRequest *request;
@end

@implementation DCCashbackRequest

- (instancetype)initLoginRequestWithCashbackCardID:(NSString *)cardId andValue:(NSString *)value {
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"POST";
    loginRequest.URL = [NSURL URLWithString:@"https://diamond-card.herokuapp.com/API/activity"];
    NSDictionary * params = @{
                              @"userCashCard":cardId,
                              @"type":@"CASHB",
                              @"value":value,
                              };
    
    NSString * encodedString = [params encodedStringWithHttpBody];
    NSData *bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    [loginRequest setBodyData:bodyData isJSONData:NO];
    
    self.request = loginRequest;
    
    return self;
}

- (instancetype)initGetAllActivity {
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"GET";
    loginRequest.URL = [NSURL URLWithString:@"https://diamond-card.herokuapp.com/API/activity"];
 
    
    self.request = loginRequest;
    
    return self;
    
}
    


@end
