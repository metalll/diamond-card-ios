//
//  PuscareViewController.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "PuscareViewController.h"
#import "DCCashbackRequest.h"
#import "LGHTTPClient.h"

@interface PuscareViewController ()
@property (weak, nonatomic) IBOutlet UITextField *value;

@end

@implementation PuscareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)didTapOk:(id)sender {
    __typeof__(self) __weak weakSelf = self;
    [[LGHTTPClient sharedInstance] loadWithRequest:[[DCCashbackRequest alloc]initLoginRequestWithCashbackCardID:self.cashbaskCard andValue:self.value.text]  callback:^(LGError *clientError, NSData *requestData) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
        
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
        
        
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
