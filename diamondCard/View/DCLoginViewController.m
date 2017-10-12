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

@interface DCLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (weak, nonatomic) IBOutlet UITextField *loginField;
@property (weak, nonatomic) IBOutlet UILabel *regLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation DCLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTextFields];
    [self configureRegLabel];
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
    [self login];
}

- (void)login {
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
        }else {
            if(clientError == nil) {
                [[[ACProgressBarDisplayer alloc] init] displayOnView:self.view
                                                         withMessage:@"Вход..."
                                                            andColor:[UIColor greenColor]
                                                        andIndicator:YES
                                                            andFaded:YES];
                
                
                DCRequest * request1 = [[DCRequest alloc] initRequetCurrentUserAuthRole];
                
                [[LGHTTPClient sharedInstance] loadWithRequest:request1 callback:^(LGError *clientError, NSData *requestData){
                    
                    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
                    NSLog(@"json %@",jsonDic);
                 
                    [weakSelf performSegueWithIdentifier:@"LGRoleBuyer" sender:nil];
                    
                }];
                
            }
        }
    }];
    
    
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
    self.constraint.constant = -80.f;
    __typeof__(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.constraint.constant = 0.f;
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
