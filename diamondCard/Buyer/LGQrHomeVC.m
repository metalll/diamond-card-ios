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
@property (weak, nonatomic) IBOutlet UILabel *shadow;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@end

@implementation LGQrHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadQr];
    self.balance.text = s;
    self.shadow.text = @"";
    
    
    
    // Do any additional setup after loading the view.
}

- (void)loadQr {
    self.qrImageView.image = [[[QRCodeGenerator alloc] initWithString:[LGUserData sharedInstance].basUser[@"cashbackCardNumber"]] getImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
