//
//  LGKeychain.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LGKeychain : NSObject

+ (instancetype)defaultKeychain;

- (BOOL)storeUsername:(NSString *)username password:(NSString *)password identifier:(NSString *)identifier forService:(NSString *)service;

- (BOOL)storeUsername:(NSString *)username password:(NSString *)password identifier:(NSString *)identifier info:(NSDictionary *)info forService:(NSString *)service;

- (BOOL)storeUsername:(NSString *)username password:(NSString *)password identifier:(NSString *)identifier expirationDate:(NSDate *)expirationDate forService:(NSString *)service;

- (NSDictionary *)credentialsForIdentifier:(NSString *)identifier service:(NSString *)service;

- (NSDictionary *)credentialsForUsername:(NSString *)username service:(NSString *)service;

- (NSArray *)allCredentialsForService:(NSString *)service limit:(NSUInteger)limit;

- (BOOL)deleteCredentialsForIdentifier:(NSString *)identifier service:(NSString *)service;

- (BOOL)deleteCredentialsForUsername:(NSString *)username service:(NSString *)service;

- (BOOL)deleteAllCredentialsForService:(NSString *)service;

@end

