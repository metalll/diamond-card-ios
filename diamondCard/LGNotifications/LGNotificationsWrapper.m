//
//  LGNotificationsWrapper.m
//  lezGO
//
//  Created by user-letsgo6 on 27.11.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LGNotificationsWrapper.h"
#import "AppDelegate+LGNotificationsWrapper.h"
#import "LGHTTPClient.h"
#import "LGNotificationsRequest.h"

@import UserNotifications;

@implementation LGNotificationsWrapper

#pragma mark - Lazy Singletone

static LGNotificationsWrapper *instance;
+ (instancetype)currentInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self.class new];
    });
    return instance;
}

- (void)requestWithCallback:(void (^)(BOOL isGranted))callback {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(granted);
            });
        }
    }];
}

- (void)sendToken:(NSData *)token {
    
    
    
    NSString * deviceTokenString = [[[[token description]
                                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    
    
    
    NSLog(@"The generated device token string is : %@",deviceTokenString);
    NSLog(@"Token descr : %@",[token description]);

    [[LGHTTPClient sharedInstance] loadWithRequest:[[LGNotificationsRequest alloc] initPostSubscriveToNotificationsRequestWithToken:[token description]]                                                callback:^(LGError *clientError, NSData *requestData) {
        
    }];

}

- (void)registerNotifications {
    
    if (![[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (void)unregister {
    if ([[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
#warning TBD
    //TBD send unregister to server
}

- (void)settingsWithCallback:(void (^)(UNNotificationSettings * _Nonnull settings))callback {
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
               callback(settings);
            });
        }
    }];
}

@end
