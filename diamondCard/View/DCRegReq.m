//
//  DCRegReq.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "DCRegReq.h"
#import "NSDictionary+LGHTTP.h"
#import "NSMutableURLRequest+LGHTTP.h"

@interface DCRegReq()
@property (strong,nonatomic) NSURLRequest *request;
@end

@implementation DCRegReq
- (instancetype)initWithLogin:(NSString *)login pass:(NSString *)pass {
    
    
    self = [self init];
    if(!self) return self;
    
    NSMutableURLRequest * loginRequest = [NSMutableURLRequest new];
    loginRequest.HTTPMethod = @"POST";
    loginRequest.URL = [NSURL URLWithString:@"https://diamond-card.herokuapp.com/Reg"];
    NSDictionary * params = @{
                              @"email":login,
                              @"pass":pass,
                              @"rePass":pass
                              };
    
    NSString * encodedString = [params encodedStringWithHttpBody];
    NSData *bodyData = [encodedString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    
    [loginRequest setBodyData:bodyData isJSONData:NO];
    
    self.request = loginRequest;
    
    return self;
}

@end
