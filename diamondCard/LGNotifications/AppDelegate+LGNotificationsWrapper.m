//
//  AppDelegate+LGNotificationsWrapper.m
//  lezGO
//
//  Created by user-letsgo6 on 27.11.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//

#import "AppDelegate+LGNotificationsWrapper.h"
#import "LGNotificationsWrapper.h"
@implementation AppDelegate (LGNotificationsWrapper)
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    [[LGNotificationsWrapper currentInstance] sendToken:deviceToken];
}

@end
