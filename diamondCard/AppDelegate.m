//
//  AppDelegate.m
//  diamondCard
//
//  Created by NSD on 07.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "AppDelegate.h"
#import "LGReachbilityView.h"
#import "AppDelegate+LGNotificationsWrapper.h"
#import "LGNotificationsWrapper.h"
#import <UIKit/UIKit.h>
#import "ACProgressBarDisplayer.h"

@import UserNotifications;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LGReachibilityView sharedInstance] setUp];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
      [[LGReachibilityView sharedInstance] off];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[LGNotificationsWrapper currentInstance] sendToken:deviceToken];
}

- (BOOL)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
#ifdef DEBUG
    NSLog(@"AppDelegate+LGNotificationsWrapper.h -> recive remote %@",userInfo);
#endif
    
    UIView * v = [[UIApplication sharedApplication] keyWindow];
    
    [[[ACProgressBarDisplayer alloc] init] displayOnView:v
                                             withMessage:@"Запрос на кешбек"
                                                andColor:[UIColor blueColor]
                                            andIndicator:NO
                                                andFaded:YES];

    
    return YES;
}

@end
