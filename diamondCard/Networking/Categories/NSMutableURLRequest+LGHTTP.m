//
//  NSMutableURLRequest+LGHTTP.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "NSMutableURLRequest+LGHTTP.h"

@implementation NSMutableURLRequest (LGHTTP)

-(void)setBodyData:(NSData *)data isJSONData:(BOOL)isJSONData{
    self.HTTPBody = data;
    if(isJSONData) return;
    [self setValue: [NSString stringWithFormat:@"%ld",(long)data.length] forHTTPHeaderField:@"Content-Length"];
    [self setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

@end
