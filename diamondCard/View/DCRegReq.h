//
//  DCRegReq.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGRequestProtocol.h"

@interface DCRegReq : NSObject <LGRequestProtocol>
- (instancetype)initWithLogin:(NSString *)login pass:(NSString *)pass;
@end
