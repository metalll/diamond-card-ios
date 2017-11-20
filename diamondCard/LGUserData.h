//
//  LGUserData.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGUserData : NSObject

@property(strong,nonatomic) NSDictionary * baseUser;
@property(strong,nonatomic) NSDictionary * userInfo;
@property(strong,nonatomic) NSString *userRole;
+(instancetype) sharedInstance;
- (void)updateDataWithCallback:(void (^)(void))callback;
- (void)saveWithName:(NSString *)name pass:(NSString *)pass;
- (void)loadUserOfflineUser;
- (NSDictionary *)creditalsForStoredUser;
- (BOOL)hasUser;
- (void)logout;
@end
