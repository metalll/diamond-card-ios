//
//  LGNotificationsWrapper.h
//  lezGO
//
//  Created by user-letsgo6 on 27.11.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UserNotifications;

@interface LGNotificationsWrapper : NSObject
+ (instancetype)currentInstance;
- (void)requestWithCallback:(void (^)(BOOL isGranted))callback;
- (void)registerNotifications;
- (void)unregister;
- (void)settingsWithCallback:(void(^)(UNNotificationSettings *settings))callback;
- (void)sendToken:(NSData *)token;
@end
