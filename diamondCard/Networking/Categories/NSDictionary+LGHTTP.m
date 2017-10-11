//
//  NSDictionary+LGHTTP.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "NSDictionary+LGHTTP.h"

@implementation NSDictionary (LGHTTP)

-(NSString *)encodedStringWithHttpBody {
    NSMutableArray *partsArray = [NSMutableArray new];
    for (NSString *key in self.allKeys) {
        NSString *keyArr = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSString *valueArr = [[self valueForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        [partsArray addObject:[[(NSString *)keyArr stringByAppendingString: @"="]stringByAppendingString:(NSString *)valueArr]] ;
    }
    return [partsArray componentsJoinedByString:@"&"];
}
@end
