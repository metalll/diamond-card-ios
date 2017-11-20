//
//  LGUserData.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGUserData.h"
#import "DCRequest.h"
#import "LGHTTPClient.h"
#import "LGKeychain.h"

static NSString *const keychainName = @"DCService";

@interface LGUserData ()

@end

@implementation LGUserData

static LGUserData *data;
+(instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [LGUserData new];
    });
    return data;
}

- (void)updateDataWithCallback:(void (^)(void))callback {
    
    DCRequest * request1 = [[DCRequest alloc] initRequetCurrentUserAuthRole];
    __typeof__(self) __weak weakSelf = self;
    [[LGHTTPClient sharedInstance] loadWithRequest:request1 callback:^(LGError *clientError, NSData *requestData){
        
        NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
        NSLog(@"json %@",jsonDic);
        
        if([jsonDic[@"data"][1] isEqualToString:@"ROLE_BUYER"]) {
            
            
            weakSelf.baseUser = [jsonDic[@"data"] firstObject];
            weakSelf.userInfo = [jsonDic[@"data"] objectAtIndex:2];
            if (callback) {
                callback();
            }
        }
        
    }];
    
}


- (void)saveWithName:(NSString *)name pass:(NSString *)pass {
    [[LGKeychain defaultKeychain] storeUsername:name password:pass identifier:keychainName info:@{
                                                                                                  @"A":self.baseUser,
                                                                                                  @"B":self.userInfo,
                                                                                                  } forService:keychainName];
}

- (void)loadUserOfflineUser {
    NSDictionary *userInfoDic = [[LGKeychain defaultKeychain] credentialsForIdentifier:keychainName service:keychainName];
    
    self.baseUser = userInfoDic[@"info"][@"A"];
    self.userInfo = userInfoDic[@"info"][@"B"];
    
    NSLog(@"");
}

- (NSDictionary *)creditalsForStoredUser {
    return [[LGKeychain defaultKeychain] credentialsForIdentifier:keychainName service:keychainName];
}

- (BOOL)hasUser {
   NSDictionary *respDic = [[LGKeychain defaultKeychain] credentialsForIdentifier:keychainName service:keychainName];
    if (respDic && respDic.allKeys.count>1) {
        return YES;
    }
    return NO;
}

@end
