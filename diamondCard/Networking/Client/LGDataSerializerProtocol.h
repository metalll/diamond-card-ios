//
//  LGDataSerializerProtocol.h
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LGDataSerializerProtocol <NSObject>
- (id)processRequestData:(NSData *)data;
@end
