//
//  LGReachbilityView.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGReachbilityView.h"

#import "ACProgressBarDisplayer.h"

@implementation LGReachibilityView

static LGReachibilityView *instance;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LGReachibilityView new];
    });
    return instance;
}

- (void)setUp {
   
    
    self.rechibility = [LGReachability reachabilityWithHostName:@"www.google.com"];
    
    __typeof__(self) __weak weakSelf = self;
    self.rechibility.reachableBlock = ^(LGReachability *reach) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!weakSelf.isPresentedUnreachAlert) {
                return ;
            }
            weakSelf.isPresentedUnreachAlert = NO;
            UIView *parentVC = [[UIApplication sharedApplication] keyWindow];
              [[ACProgressBarDisplayer alloc] removeFromView:parentVC];
        });
    };
    
    self.rechibility.unreachableBlock = ^(LGReachability *reachability){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.isPresentedUnreachAlert) {
                return ;
            }
            weakSelf.isPresentedUnreachAlert = YES;
              UIView *parentVC = [[UIApplication sharedApplication] keyWindow];
            
            [[ACProgressBarDisplayer alloc] displayOnView:parentVC withMessage:@"Нет интернета!" andColor:[UIColor redColor] andIndicator:NO andFaded:NO];
          
        });
    };
    
    [self.rechibility startNotifier];
}

- (void)off {
    [self.rechibility stopNotifier];
    self.rechibility = nil;
    self.isPresentedUnreachAlert = NO;
}



@end
