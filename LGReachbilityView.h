//
//  LGReachbilityView.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LGReachibility.h"
@interface LGReachibilityView : NSObject
@property (strong,nonatomic) LGReachability *rechibility;
@property (assign,nonatomic) BOOL isPresentedUnreachAlert;
+ (instancetype)sharedInstance;
- (void)setUp;
- (void)off;
@end
