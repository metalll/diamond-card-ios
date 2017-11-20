//
//  DCRegViewController.m
//  diamondCard
//
//  Created by NSD on 08.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "DCRegViewController.h"
#import "LGHTTPClient.h"
#import "DCRegReq.h"
#import "ACProgressBarDisplayer.h"
#import "DCRequest.h"
#import "LGUserData.h"

@interface DCRegViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *rePass;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constaint;

@end

@implementation DCRegViewController

-(void)dealloc {
    [self unsubscribe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configMainView];
    [self subscribe];
}

- (void)configMainView {
    self.mainView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.mainView addGestureRecognizer:tapGestureRecognizer];
}

- (void)handleTap:(UIGestureRecognizer *)recognizer {
    [self.pass endEditing:YES];
    [self.login endEditing:YES];
    [self.rePass endEditing:YES];
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
    
    self.constaint.constant = 90.f;
    self.bottomConstraint.constant = 20.f;
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutSubviews];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    self.constaint.constant = -20.f;
    self.bottomConstraint.constant = kbSize.height + 10;
    
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutSubviews];
        [self.view layoutIfNeeded];
    }];
}



- (void)unsubscribe {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)reg:(id)sender {
    
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:self.login.text options:0 range:NSMakeRange(0, [self.login.text length])];
    
    if (!regExMatches) {
        
        [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                 withMessage:@"Неверный email!"
                                                    andColor:[UIColor redColor]
                                                andIndicator:NO
                                                    andFaded:YES];
        
        return;
    }
    
    if (self.pass.text.length < 6) {
        
        [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                 withMessage:@"Пароль меньше 6 символов!"
                                                    andColor:[UIColor redColor]
                                                andIndicator:NO
                                                    andFaded:YES];
        
        return;
    }
    
    if (![self.rePass.text isEqual:self.pass.text]) {
        [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                 withMessage:@"Пароли не совпадают!"
                                                    andColor:[UIColor redColor]
                                                andIndicator:NO
                                                    andFaded:YES];
        
        return;
    }
    
    
    [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                             withMessage:@"Регистрация..."
                                                andColor:[UIColor blueColor]
                                            andIndicator:YES
                                                andFaded:NO];
    
    [[LGHTTPClient sharedInstance] loadWithRequest:[[DCRegReq alloc] initWithLogin:self.login.text pass:self.pass.text] callback:^(LGError *clientError, NSData *requestData) {
        
        NSDictionary * reqDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
        
        NSString *status = reqDic[@"status"];
        
        if ([@"USER_IS_EXIST" isEqualToString:status]) {
            
            [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                     withMessage:@"Email занят!"
                                                        andColor:[UIColor redColor]
                                                    andIndicator:NO
                                                        andFaded:YES];
            return ;
        }
        
        if ([@"BAD" isEqualToString:status]) {
            
            [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                     withMessage:@"Сервер временно недоступен"
                                                        andColor:[UIColor redColor]
                                                    andIndicator:NO
                                                        andFaded:YES];
            return ;
        }
        
        if ([@"OK" isEqualToString:status]) {
            [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                     withMessage:@"Авторизация..."
                                                        andColor:[UIColor blueColor]
                                                    andIndicator:YES
                                                        andFaded:NO];
            
            
            DCRequest * request = [[DCRequest alloc] initLoginRequestWithLogin:self.login.text password:self.pass.text];
            
            __typeof__(self) __weak weakSelf = self;
            NSURLSessionTask * task = [[LGHTTPClient sharedInstance] loadWithRequest:request callback:^(LGError *clientError, NSData *requestData) {
                
                NSString *responceStringData = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
                NSLog(@"%@",responceStringData);
                NSLog(@"%@",clientError.description);
                
                if([clientError.description isEqualToString:@"Client error: 401"]) {
                    
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
                            
                            if([jsonDic[@"data"][1] isEqualToString:@"ROLE_BUYER"]) {
                                
                                
                                [LGUserData sharedInstance].baseUser = [jsonDic[@"data"] firstObject];
                                [LGUserData sharedInstance].userInfo = [jsonDic[@"data"] objectAtIndex:2];
                                
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
                                [[ACProgressBarDisplayer alloc] removeFromView:weakSelf.view];
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
                                //
                                
                           // }];
                                
                                
                                
                
                                
                            }
                            
                        }];
                        
                    } } }];
            
            
            
        }
        
        
        NSLog(@"%@",reqDic);
        
    }];
}

- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
