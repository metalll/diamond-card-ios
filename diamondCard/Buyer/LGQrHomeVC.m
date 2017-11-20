//
//  LGQrHomeVC.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "LGQrHomeVC.h"
#import "QRCodeGenerator.h"
#import "LGUserData.h"

@interface LGQrHomeVC ()
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UIView *balanceBox;
@property (weak, nonatomic) IBOutlet UILabel *shadow;
@property (weak, nonatomic) IBOutlet UIView *shadowBalanceBox;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (weak, nonatomic) IBOutlet UILabel *id_card;
@end

@implementation LGQrHomeVC


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __typeof__(self) __weak weakSelf = self;
    
    self.balanceBox.layer.cornerRadius = 5.f;
    self.balanceBox.layer.masksToBounds = YES;
    
    self.shadowBalanceBox.layer.cornerRadius = 5.f;
    self.shadowBalanceBox.layer.masksToBounds = YES;
    
    
    [[LGUserData sharedInstance] updateDataWithCallback:^{
        weakSelf.id_card.text = [@"ID карты: " stringByAppendingString:[LGUserData sharedInstance].baseUser[@"cashbackCardNumber"]];
        weakSelf.balance.text = [[LGUserData sharedInstance].userInfo[@"balance"] stringValue];
        weakSelf.shadow.text = [[LGUserData sharedInstance].userInfo[@"shadowBalance"] stringValue];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadQr];
    self.balance.text = [[LGUserData sharedInstance].userInfo[@"balance"] stringValue];
    self.shadow.text = [[LGUserData sharedInstance].userInfo[@"shadowBalance"] stringValue];
  
    self.id_card.text = [@"ID карты: " stringByAppendingString:[LGUserData sharedInstance].baseUser[@"cashbackCardNumber"]];
    
    self.id_card.layer.cornerRadius = 5.f;
    self.id_card.layer.masksToBounds = YES;
    
    
}

- (void)loadQr {
    self.qrImageView.backgroundColor = [UIColor clearColor];
    self.qrImageView.layer.cornerRadius = 5.0f;
    self.qrImageView.layer.masksToBounds = YES;
   QRCodeGenerator *generator = [[QRCodeGenerator alloc] initWithString:[LGUserData sharedInstance].baseUser[@"cashbackCardNumber"]];
    generator.backgroundColor = [CIColor colorWithCGColor:[UIColor colorWithWhite:0 alpha:0.5].CGColor];
    generator.color = [CIColor colorWithCGColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
    self.qrImageView.image = [generator getImage];
}
- (IBAction)logout:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[LGUserData sharedInstance] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
