//
//  DCRootBuyerVC.m
//  diamondCard
//
//  Created by NSD on 07.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "DCRootBuyerVC.h"

@interface DCRootBuyerVC ()
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIView *diamondOnlineView;
@property (weak, nonatomic) IBOutlet UIView *contrAgentView;
@property (weak, nonatomic) IBOutlet UIView *sharesView;

@end

@implementation DCRootBuyerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)configShapeViews {
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}


@end
