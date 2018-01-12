//
//  DCSignInUpVC.m
//  diamondCard
//
//  Created by NSD on 07.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "DCSignInUpVC.h"

@interface DCSignInUpVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@end

@implementation DCSignInUpVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __typeof__(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.35f animations:^{
        weakSelf.signInButton.alpha = 1.f;
        weakSelf.signUpButton.alpha = 1.f;
        weakSelf.logoTopConstraint.constant = 30.f;
        [weakSelf.view layoutIfNeeded];
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
