//
//  ContrAgentHomeVC.m
//  diamondCard
//
//  Created by user-letsgo6 on 20.10.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "ContrAgentHomeVC.h"
#import <QRCodeReaderViewController.h>
#import "PuscareViewController.h"

@interface ContrAgentHomeVC () <QRCodeReaderDelegate>
@property (weak, nonatomic) IBOutlet UILabel *corpName;
@property (strong,nonatomic) QRCodeReader *reader;
@property (strong,nonatomic) QRCodeReaderViewController *vc;

@property (strong,nonatomic) NSString *lastScanResult;
@end

@implementation ContrAgentHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    _vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Отменить" codeReader:_reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    _vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // Define the delegate receiver
    _vc.delegate = self;
    
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toScan:(id)sender {
    [self presentViewController:_vc animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        self.lastScanResult = result;
        PuscareViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PuscareViewController"];
        vc.cashbaskCard = result;
        [self.navigationController pushViewController:vc animated:NO];
        
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:NO completion:NULL];
    
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
