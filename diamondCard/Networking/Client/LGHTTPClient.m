//
//  LGHTTPClient.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGHTTPClient.h"
#import <UIKit/UIKit.h>
#import "LGRequestProtocol.h"


NSString * const LGProcessRequestUnknownError = @"Unknown error: %ld";
NSString * const LGProcessRequestServerError = @"Server error: %ld";
NSString * const LGProcessRequestClientError = @"Client error: %ld";
NSString * const LGNilDataError = @"Request successed, but data is nil";
NSString * const LGNoInternet = @"No internet connection";

@interface LGHTTPClient()

@property (strong,nonatomic) NSURLSession *session;
@end

@implementation LGHTTPClient

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

static LGHTTPClient * instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LGHTTPClient alloc] init];
    });
    return instance;
}

#pragma mark - Public

- (NSURLSessionDataTask *)loadWithRequest:(id<LGRequestProtocol>)request
                                 callback:(LGHTTPClientCallback)callback {
    LGHTTPClient __weak *_self = self;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (!callback) {
                return;
            }
            LGError *respErr = [_self processResponceWithResponce:response error:error];
            if (respErr) {
                callback(respErr,nil);
                return;
            }
            if (!data) {
                callback([[LGError alloc] initWithString:LGNilDataError],nil);
                return;
            }
            callback(nil,data);
        });
    }];
    [task resume];
    return task;
}

#pragma mark - Private

- (LGError *)processResponceWithResponce:(NSURLResponse *)responce
                                   error:(NSError *)error{
    if(error) {
        return [[LGError alloc] initWithError:error];
    }
    NSHTTPURLResponse * httpResponce = (NSHTTPURLResponse *)responce;
    if (httpResponce.statusCode>=200&&httpResponce.statusCode<=299) {
        return nil;
    }
    if (httpResponce.statusCode>=400&&httpResponce.statusCode<=499) {
        return [[LGError alloc] initWithString:[NSString stringWithFormat:LGProcessRequestClientError,(long)httpResponce.statusCode]];
    }
    if (httpResponce.statusCode>=500&&httpResponce.statusCode<=599) {
        return [[LGError alloc] initWithString:[NSString stringWithFormat:LGProcessRequestServerError,(long)httpResponce.statusCode]];
    }
    return [[LGError alloc] initWithString:[NSString stringWithFormat:LGProcessRequestUnknownError,(long)httpResponce.statusCode]];
}

@end
