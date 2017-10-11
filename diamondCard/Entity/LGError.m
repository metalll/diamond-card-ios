//
//  LGError.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGError.h"

@interface LGError()
@property(strong,nonatomic) NSString *errorMessage;
@end

@implementation LGError
- (instancetype)initWithString:(NSString *)customMessage {
    if (self = [super init]) {
        self.errorMessage = customMessage;
    }
    return self;
}
- (instancetype)initWithError:(NSError *)error {
    return [self initWithString:error.localizedDescription];
}
- (NSString *)description {
    return self.errorMessage;
}
@end
