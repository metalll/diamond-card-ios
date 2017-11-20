//
//  LGReachibility.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

//
//  LGReachibility.h
//  lezGO
//
//  Created by user-letsgo6 on 22.09.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>

#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif
FOUNDATION_EXPORT double ReachabilityVersionNumber;
FOUNDATION_EXPORT const unsigned char ReachabilityVersionString[];
extern NSString * const LGReachabilityDefaultHost;
extern NSString * const kReachabilityChangedNotification;
extern NSString * const kReachibilityStatus;
typedef NS_ENUM(NSInteger, NetworkStatus) {
    NotReachable = 0,
    ReachableViaWiFi = 2,
    ReachableViaWWAN = 1
};

@class LGReachability;
typedef void (^NetworkReachable)(LGReachability *reachability);
typedef void (^NetworkUnreachable)(LGReachability *reachability);
typedef void (^NetworkReachability)(LGReachability *reachability, SCNetworkConnectionFlags flags);

@interface LGReachability : NSObject
@property (nonatomic,copy) NetworkReachable reachableBlock;
@property (nonatomic,copy) NetworkUnreachable unreachableBlock;
@property (nonatomic,copy) NetworkReachability reachabilityBlock;
@property (nonatomic,assign) BOOL reachableOnWWAN;
+ (instancetype)reachabilityWithHostname:(NSString*)hostname;
+ (instancetype)reachabilityWithHostName:(NSString*)hostname;
+ (instancetype)reachabilityForInternetConnection;
+ (instancetype)reachabilityWithAddress:(void *)hostAddress;
+ (instancetype)reachabilityForLocalWiFi;
- (instancetype)initWithReachabilityRef:(SCNetworkReachabilityRef)ref;
- (BOOL)startNotifier;
- (void)stopNotifier;
- (BOOL)isReachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;
- (BOOL)isConnectionRequired;
- (BOOL)connectionRequired;
- (BOOL)isConnectionOnDemand;
- (BOOL)isInterventionRequired;
- (NetworkStatus)currentReachabilityStatus;
- (SCNetworkReachabilityFlags)reachabilityFlags;
- (NSString*)currentReachabilityString;
- (NSString*)currentReachabilityFlags;
+ (BOOL)isBaseReach;
@end

