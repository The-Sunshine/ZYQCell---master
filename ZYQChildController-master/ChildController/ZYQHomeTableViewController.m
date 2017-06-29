//
//  ZYQHomeTableViewController.m
//  
//
//  Created by zyq on 16/10/11.
//  Copyright © 2016年 zyq. All rights reserved.
//

#import "ZYQHomeTableViewController.h"

@interface ZYQHomeTableViewController ()

@end

@implementation ZYQHomeTableViewController

static NSString * ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text =[NSString stringWithFormat:@"%@ - %zd",self.title,indexPath.row];

    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}
@end
