//
//  LGUserData.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGUserData.h"

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

@end
