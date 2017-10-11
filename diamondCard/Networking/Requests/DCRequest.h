//
//  DCRequest.h
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGRequestProtocol.h"

@interface DCRequest : NSObject <LGRequestProtocol>

- (instancetype)initLoginRequestWithLogin:(NSString *)login
                                 password:(NSString *)password;

- (instancetype)initRequetCurrentUserAuthRole;

@end
