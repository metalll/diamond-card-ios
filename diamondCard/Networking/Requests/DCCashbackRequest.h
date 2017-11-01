//
//  DCCashbackRequest.h
//  diamondCard
//
//  Created by user-letsgo6 on 01.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGRequestProtocol.h"
@interface DCCashbackRequest : NSObject <LGRequestProtocol>
- (instancetype)initLoginRequestWithCashbackCardID:(NSString *)cardId andValue:(NSString *)value;
- (instancetype)initGetAllActivity;

@end
