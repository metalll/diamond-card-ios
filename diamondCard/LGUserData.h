//
//  LGUserData.h
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGUserData : NSObject

@property(strong,nonatomic) NSDictionary * basUser;

+(instancetype) sharedInstance;
@end
