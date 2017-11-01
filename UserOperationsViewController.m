//
//  UserOperationsViewController.m
//  diamondCard
//
//  Created by user-letsgo6 on 01.11.17.
//  Copyright © 2017 NSD NULL. All rights reserved.
//

#import "UserOperationsViewController.h"
#import "DCCashbackRequest.h"
#import "LGHTTPClient.h"

@interface UserOperationsViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation UserOperationsViewController

- (void)viewDidAppear:(BOOL)animated {
    [[LGHTTPClient sharedInstance] loadWithRequest:[[DCCashbackRequest alloc] initGetAllActivity] callback:^(LGError *clientError, NSData *requestData) {
        NSDictionary *respDic = [NSJSONSerialization JSONObjectWithData:requestData options:0 error:nil];
        NSLog(@"resp dic %@",respDic);
        
        self.operations = respDic[@"data"][0];
        
        [self.table reloadData];
    }];
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.operations = [NSMutableArray new];
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    cell.textLabel.text = [[ @"Кешбек на сумму: " stringByAppendingString: self.operations[indexPath.row][@"operationValue"]] stringByAppendingString :@" грн"];
    
    
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.operations.count;
}

@end
