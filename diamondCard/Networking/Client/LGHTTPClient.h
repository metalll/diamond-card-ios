//
//  LGHTTPClient.h
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

//
//  LGHTTPClient.h
//  lezGO
//
//  Created by user-letsgo6 on 19.09.17.
//  Copyright © 2017 user-letsgo6. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGHTTPClient.h"
#import "LGRequestProtocol.h"
#import "LGError.h"


typedef void (^LGHTTPClientCallback)(LGError *clientError,NSData *requestData);

@interface LGHTTPClient : NSObject
+ (instancetype)sharedInstance;
- (NSURLSessionDataTask *)loadWithRequest:(id<LGRequestProtocol>)request
                                 callback:(LGHTTPClientCallback)callback;
@end
