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
#import "NSDBuyerOperationCell.h"


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
    [self.table registerNib:[UINib nibWithNibName:@"NSDBuyerOperationCell" bundle:nil] forCellReuseIdentifier:@"NSDBuyerOperationCell"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDBuyerOperationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NSDBuyerOperationCell"];
  
//    cell.textLabel.text = [[ @"Кешбек на сумму: " stringByAppendingString: self.operations[indexPath.row][@"operationValue"]] stringByAppendingString :@" грн"];
//
 
    cell.value.text = self.operations[indexPath.row][@"preparedTagetOperationValue"];
    
    NSString * rawDate = [self.operations[indexPath.row][@"data"] substringToIndex:10];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    NSDate *sevenDaysAgo = [[dateFormatter dateFromString:rawDate] dateByAddingTimeInterval:14*24*60*60];
    
    NSString *rawCalcDate =  [sevenDaysAgo descriptionWithLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    
    cell.age.text = [rawCalcDate componentsSeparatedByString:@","][1];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.operations.count;
}

@end
