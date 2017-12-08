//
//  AppDelegate+LGNotificationsWrapper.h
//  lezGO
//
//  Created by user-letsgo6 on 27.11.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (LGNotificationsWrapper)
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
@end
