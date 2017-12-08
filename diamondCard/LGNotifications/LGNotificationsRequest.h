//
//  LGNotificationsRequest.h
//  diamondCard
//
//  Created by user-letsgo6 on 08.12.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGRequestProtocol.h"

@interface LGNotificationsRequest : NSObject <LGRequestProtocol>
- (instancetype) initPostSubscriveToNotificationsRequestWithToken:(NSString *)token;
@end
