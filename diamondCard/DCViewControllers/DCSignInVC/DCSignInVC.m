//
//  DCSignInVC.m
//  diamondCard
//
//  Created by NSD on 07.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "DCSignInVC.h"
#import <WebKit/WebKit.h>
#import "DCRegViewController.h"
#import "LGHTTPClient.h"
#import "DCRequest.h"
#import "ACProgressBarDisplayer.h"
#import "VPBiometricAuthenticationFacade.h"
#import "LGUserData.h"
#import "LGKeychain.h"
#import "LGReachibility.h"
#import "NavigationController.h"
#import "DCRootBuyerVC.h"
#import "SLViewController.h"

@interface DCSignInVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *eyeVisibleButton;
@property (weak, nonatomic) IBOutlet UILabel *progressViewLabel;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (assign,nonatomic) BOOL isVisiblePassword;
@end

@implementation DCSignInVC

- (void)dealloc {
    [self unsubscribe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self subscribe];
    [self configSignInButton];
    [self configFields];
}


- (void)configFields {
    self.passwordField.delegate = self;
    self.emailField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 0) {
        [self.passwordField becomeFirstResponder];
    }
    if (textField.tag == 1) {
        [self.passwordField endEditing:YES];
        [self login];
    }
    
    return YES;
}

- (IBAction)didTapEyeVisibleButton:(id)sender {
    __typeof__(self) __weak weakSelf = self;
    self.isVisiblePassword = !self.isVisiblePassword;
    
    if (self.isVisiblePassword) {
        
        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
            [weakSelf.eyeVisibleButton setImage:[UIImage imageNamed:@"ic_eye_open"] forState:UIControlStateNormal];
             weakSelf.passwordField.secureTextEntry = NO;
        } completion:nil];
        
    } else {

        [UIView animateWithDuration:0.35f delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            [weakSelf.eyeVisibleButton setImage:[UIImage imageNamed:@"ic_eye_close"] forState:UIControlStateNormal];
              weakSelf.passwordField.secureTextEntry = YES;
        } completion:nil];
        
    }
}

- (void)configSignInButton {
    self.signInButton.layer.cornerRadius = 5.f;
    self.signInButton.layer.masksToBounds = YES;
}

- (IBAction)didTapSignInButton:(id)sender {
    
    
    
    
    [self login];
}

- (void)login {
    [self.emailField endEditing:YES];
    [self.passwordField endEditing:YES];
    [self showProgressView];
    
 
    DCRequest * request = [[DCRequest alloc] initLoginRequestWithLogin:self.emailField.text password:self.passwordField.text];
    
    __typeof__(self) __weak weakSelf = self;
    NSURLSessionTask * task = [[LGHTTPClient sharedInstance] loadWithRequest:request callback:^(LGError *clientError, NSData *requestData) {
        
        NSString *responceStringData = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responceStringData);
        NSLog(@"%@",clientError.description);
        
        
        
        if([clientError.description isEqualToString:@"Client error: 401"]) {
            [[[ACProgressBarDisplayer alloc] init] displayOnView:weakSelf.mainView
                                                     withMessage:@"Error login or password"
                                                        andColor:[UIColor redColor]
                                                    andIndicator:NO
                                                        andFaded:YES];
            
            [weakSelf hideProgessView];
        } else {
            
            if (clientError) {
                [weakSelf hideProgessView];
                [[[ACProgressBarDisplayer alloc] init] displayOnView:weakSelf.mainView
                                                         withMessage:@"Network error"
                                                            andColor:[UIColor redColor]
                                                        andIndicator:NO
                                                            andFaded:YES];
                return;
            }
            
            if(clientError == nil) {
                weakSelf.progressViewLabel.text = @"Loading data...";
                
                DCRequest * request1 = [[DCRequest alloc] initRequetCurrentUserAuthRole];
                
                [[LGHTTPClient sharedInstance] loadWithRequest:request1 callback:^(LGError *clientError, NSData *requestData){
                    
                    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
                    NSLog(@"json %@",jsonDic);
                    [weakSelf hideProgessView];
                    
                     SLViewController *viewController = [SLViewController new];
                    
                    
                    if([jsonDic[@"data"][1] isEqualToString:@"ROLE_BUYER"]) {
                        
                        [LGUserData sharedInstance].userRole = jsonDic[@"data"][1];
                        [LGUserData sharedInstance].baseUser = [jsonDic[@"data"] firstObject];
                        [LGUserData sharedInstance].userInfo = [jsonDic[@"data"] objectAtIndex:2];
                        [[LGUserData sharedInstance] saveWithName:weakSelf.emailField.text pass:weakSelf.passwordField.text];
                        [[ACProgressBarDisplayer alloc] removeFromView:weakSelf.view];
                   
                        // -> BUYER MAIN
                        
                        DCRootBuyerVC *vc =(DCRootBuyerVC *) [self.storyboard instantiateViewControllerWithIdentifier:@"DCRootBuyerVC"];
                        
                        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:viewController];
                        vc.rootViewController = nav;
                        UIWindow *window = UIApplication.sharedApplication.delegate.window;
                        window.rootViewController = vc;
                        
                        
                        
                        [UIView transitionWithView:window
                                          duration:0.3
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:nil
                                        completion:nil];
                        
                    }
                    
                    if([jsonDic[@"data"][1] isEqualToString:@"ROLE_CONTR_AGENT"]) {
                        [LGUserData sharedInstance].baseUser = [jsonDic[@"data"] firstObject];
                
                        
                        // -> CONTR_AGENT MAIN
                    }
                    
                }];
                
            } } }];
    
    
    
    
}


- (void)showProgressView {
    [UIView animateWithDuration:0.35f animations:^{
        self.progressView.alpha = 1.f;
    }];
    
}

- (void)hideProgessView {
    [UIView animateWithDuration:0.35f animations:^{
        self.progressView.alpha = 0.f;
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)subscribe {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unsubscribe {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)keyboardWillHide:(NSNotification*)notification {
    self.scrollViewBottomConstraint.constant = 0;
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.scrollViewBottomConstraint.constant = kbSize.height;
    
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutIfNeeded];
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
