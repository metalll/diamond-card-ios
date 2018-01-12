//
//  SLViewController.m
//  diamondCard
//
//  Created by user-letsgo6 on 12.01.18.
//  Copyright © 2018 NSD NULL. All rights reserved.
//

#import "SLViewController.h"
#import "UIViewController+LGSideMenuController.h"
@interface SLViewController ()

@end

@implementation SLViewController

- (void)showLeftView {
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (void)showRightView {
    [self.sideMenuController showRightViewAnimated:YES completionHandler:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Diamond club";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
