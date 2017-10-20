//
//  QRCodeGenerator.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CIColor+QRCode.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, QRErrorCorrection) {
    QRErrorCorrectionLow = 0,
    QRErrorCorrectionMedium = 1,
    QRErrorCorrectionQuartile = 2,
    QRErrorCorrectionHigh = 3,
};

@interface QRCodeGenerator : NSObject

@property (nonatomic, strong, readonly) NSData *data;
@property (nonatomic, assign) QRErrorCorrection errorCorrection;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, strong) CIColor *color; // Defaults to black
@property (nonatomic, strong) CIColor *backgroundColor; // Defaults to white

- (instancetype)init;
- (instancetype)initWithData:(NSData *)data;
- (instancetype)initWithString:(NSString *)string;

- (UIImage *)getImage;
@end
