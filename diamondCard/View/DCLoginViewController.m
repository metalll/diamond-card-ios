//
//  DCLoginViewController.m
//  diamondCard
//
//  Created by NSD on 07.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "DCLoginViewController.h"
#import <WebKit/WebKit.h>
#import "DCRegViewController.h"
#import "LGHTTPClient.h"
#import "DCRequest.h"
#import "ACProgressBarDisplayer.h"
#import "VPBiometricAuthenticationFacade.h"
#import "LGUserData.h"
#import "LGKeychain.h"

@interface DCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UIImageView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UILabel *regLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) NSURLSessionTask *task;
@end

@implementation DCLoginViewController

#pragma mark - Life Cycle

- (void)dealloc {
    [self unsubscribe];
}

- (void)showIndicator {
    [self.indicator startAnimating];
    self.btn.hidden = YES;
}

- (void)hideIndicator {
    [self.indicator stopAnimating];
    self.btn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    [self configureRegLabel];
    [self subscribe];
    [self configMainView];
    
    
    if ([[LGUserData sharedInstance] hasUser]) {
        NSDictionary *dic = [[LGUserData sharedInstance] creditalsForStoredUser];
        
        self.loginField.text = dic[@"username"];
        self.passwordField.text = dic[@"password"];
        
        [self login];
        
    }
}



- (void)configMainView {
    self.mainView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.mainView addGestureRecognizer:tapGestureRecognizer];

    
    
    
}

- (void)handleTap:(UIGestureRecognizer *)recognizer {
    [self.loginField endEditing:YES];
    [self.passwordField endEditing:YES];
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

- (void)keyboardWillHide:(NSNotification*)notification {
   
      self.constraint.constant = 0.f;
    self.bottomConstraint.constant = 32;
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutSubviews];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
   
    self.constraint.constant = -120.f;
    self.bottomConstraint.constant = kbSize.height + 10;
    
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutSubviews];
        [self.view layoutIfNeeded];
    }];
}



- (void)unsubscribe {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Private

- (void)configureTextFields {
    self.loginField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)configureRegLabel {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(didTapRegLabel:)];
    tap.numberOfTapsRequired = 1;
    [self.regLabel addGestureRecognizer:tap];
    self.regLabel.userInteractionEnabled = YES;
}

- (void)didTapRegLabel:(UITapGestureRecognizer *)tap {
    [self performSegueWithIdentifier:NSStringFromClass([DCRegViewController class])
                              sender:self];
}
- (IBAction)didTapLoginButton:(id)sender {
    [self.loginField endEditing:YES];
    [self.passwordField endEditing:YES];
    [self login];
}

- (void)login {
    [self showIndicator];
    [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                             withMessage:@"Авторизация..."
                                                andColor:[UIColor blueColor]
                                            andIndicator:YES
                                                andFaded:NO];
    DCRequest * request = [[DCRequest alloc] initLoginRequestWithLogin:self.loginField.text password:self.passwordField.text];
    
    __typeof__(self) __weak weakSelf = self;
    NSURLSessionTask * task = [[LGHTTPClient sharedInstance] loadWithRequest:request callback:^(LGError *clientError, NSData *requestData) {
        
        NSString *responceStringData = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responceStringData);
        NSLog(@"%@",clientError.description);
        
        if([clientError.description isEqualToString:@"Client error: 401"]) {
            [self displayErrorWithMessage:@"Неверный логин или пароль"];
             [self hideIndicator];
        }else {
            if(clientError == nil) {
                [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                         withMessage:@"Вход..."
                                                            andColor:[UIColor greenColor]
                                                        andIndicator:YES
                                                            andFaded:NO];
                
                
                DCRequest * request1 = [[DCRequest alloc] initRequetCurrentUserAuthRole];
                
                [[LGHTTPClient sharedInstance] loadWithRequest:request1 callback:^(LGError *clientError, NSData *requestData){
                    
                    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
                    NSLog(@"json %@",jsonDic);
                     [self hideIndicator];
                    
                    
                    
                    
                    if([jsonDic[@"data"][1] isEqualToString:@"ROLE_BUYER"]) {
                        
                        
                        [LGUserData sharedInstance].baseUser = [jsonDic[@"data"] firstObject];
                        [LGUserData sharedInstance].userInfo = [jsonDic[@"data"] objectAtIndex:2];
                        [[LGUserData sharedInstance] saveWithName:weakSelf.loginField.text pass:weakSelf.passwordField.text];
                        [weakSelf performSegueWithIdentifier:@"LGRoleBuyer" sender:jsonDic];
                        [[ACProgressBarDisplayer alloc] removeFromView:weakSelf.view];
                        
                        
                        //                        VPBiometricAuthenticationFacade *biometricFacade = [[VPBiometricAuthenticationFacade alloc] init];
                        //
                        //
                        //                        [biometricFacade enableAuthenticationForFeature:@"My secure feature" succesBlock:^{
                        //
                        //                        } failureBlock:^(NSError * _Nonnull error) {
                        //
                        //                        }];
                        //
                        //
                        //
                        //
                        //                        [biometricFacade authenticateForAccessToFeature:@"My secure feature" withReason:@"Подвердите вашу личность" succesBlock:^{
                        //                            // Access granted
                        //
                        //                        } failureBlock:^(NSError *error) {
                        //                            // Access denied
                        //                            NSLog(@"error %@",error);
                        //                            [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                        //                                                                     withMessage:@"Ошибка подтверждения!"
                        //                                                                        andColor:[UIColor redColor]
                        //                                                                    andIndicator:NO
                        //                                                                        andFaded:YES];
                        //                        }];
                        //
                        //
                        //
                        //
                        
                        
                        
                        
                        
                    }
                    
                    if([jsonDic[@"data"][1] isEqualToString:@"ROLE_CONTR_AGENT"]) {
                        [LGUserData sharedInstance].baseUser = [jsonDic[@"data"] firstObject];
                        [weakSelf performSegueWithIdentifier:@"LGRoleContrAgent" sender:jsonDic];
                        
                        
                        //                        VPBiometricAuthenticationFacade *biometricFacade = [[VPBiometricAuthenticationFacade alloc] init];
                        //
                        //
                        //                        [biometricFacade enableAuthenticationForFeature:@"My secure feature" succesBlock:^{
                        //
                        //                        } failureBlock:^(NSError * _Nonnull error) {
                        //
                        //                        }];
                        //
                        //
                        //
                        //
                        //                        [biometricFacade authenticateForAccessToFeature:@"My secure feature" withReason:@"Подвердите вашу личность" succesBlock:^{
                        //                            // Access granted
                        //
                        //                        } failureBlock:^(NSError *error) {
                        //                            // Access denied
                        //                            [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                        //                                                                     withMessage:@"Ошибка подтверждения!"
                        //                                                                        andColor:[UIColor redColor]
                        //                                                                    andIndicator:NO
                        //                                                                        andFaded:YES];
                        //                        }];
                        
                        
                        
                        
                        
                        
                    }
                    
                }];
                
            } } }];
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (void)displayErrorWithMessage:(NSString *)message {
    [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                             withMessage:message
                                                andColor:[UIColor redColor]
                                            andIndicator:NO
                                                andFaded:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    __typeof__(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    __typeof__(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.loginField]) {
        [self.passwordField becomeFirstResponder];
    } else {
        [self.passwordField endEditing:YES];
        
        [self login];
    }
    return YES;
}





@end
