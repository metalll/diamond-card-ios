//
//  CIColor+QRCode.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <CoreImage/CoreImage.h>

#import <Foundation/Foundation.h>

@interface CIColor (QRCode)

+ (instancetype)colorWithRGBA:(NSString *)rgba;

@end
