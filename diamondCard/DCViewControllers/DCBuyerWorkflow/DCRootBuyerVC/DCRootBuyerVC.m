//
//  DCRootBuyerVC.m
//  diamondCard
//
//  Created by NSD on 07.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "DCRootBuyerVC.h"
#import "UIViewController+LGSideMenuController.h"
#import "QRCodeReader.h"
@interface DCRootBuyerVC ()
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIView *diamondOnlineView;
@property (weak, nonatomic) IBOutlet UIView *contrAgentView;
@property (weak, nonatomic) IBOutlet UIView *sharesView;
@property (weak, nonatomic) IBOutlet UIView *mapContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UIImageView *im3;
@property (weak, nonatomic) IBOutlet UIImageView *im4;

@end

@implementation DCRootBuyerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configShapeViews];
    
    UISwipeGestureRecognizer *slideToTop = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(activateMap)];
    slideToTop.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *slideToBottom = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deactivateMap)];
    slideToBottom.direction = UISwipeGestureRecognizerDirectionDown;
    self.mapContainerView.userInteractionEnabled = YES;
    [self.mapContainerView addGestureRecognizer:slideToTop];
    [self.mapContainerView addGestureRecognizer:slideToBottom];
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DCVC"];
    self.rightViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"LGQrHomeVC"];
    //self.rootViewController = self.navigationController;
 
}


- (void)activateMap {
    self.leading.constant = 0;
    self.top.constant = 0;
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)deactivateMap {
    self.leading.constant = 100.f;
    self.top.constant = 400.f;
    [UIView animateWithDuration:0.35f animations:^{
         [self.view layoutIfNeeded];
    }];
}

- (void)configShapeViews {
    
    self.qrView.layer.cornerRadius = self.qrView.frame.size.width/2.f;
    self.diamondOnlineView.layer.cornerRadius = self.diamondOnlineView.frame.size.width/2.f;
    self.contrAgentView.layer.cornerRadius = self.contrAgentView.frame.size.width/2.f;
    self.sharesView.layer.cornerRadius = self.sharesView.frame.size.width/2.f;
    
    self.qrView.layer.masksToBounds = YES;
    self.diamondOnlineView.layer.masksToBounds = YES;
    self.contrAgentView.layer.masksToBounds = YES;
    self.sharesView.layer.masksToBounds = YES;
    self.mapContainerView.layer.cornerRadius = 5.f;
    self.mapContainerView.layer.masksToBounds = YES;
    
    
    self.im1.layer.masksToBounds = YES;
    self.im1.layer.cornerRadius = self.im1.frame.size.width/2.f;
    self.im2.layer.masksToBounds = YES;
    self.im2.layer.cornerRadius = self.im1.frame.size.width/2.f;
    self.im3.layer.masksToBounds = YES;
    self.im3.layer.cornerRadius = self.im1.frame.size.width/2.f;
    self.im4.layer.masksToBounds = YES;
    self.im4.layer.cornerRadius = self.im1.frame.size.width/2.f;
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
- (IBAction)showLeftVC:(id)sender {
      [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (IBAction)showRightVC:(id)sender {
      [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];
}

@end
