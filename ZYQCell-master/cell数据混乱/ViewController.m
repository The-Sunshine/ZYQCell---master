//
//  ViewController.m
//  cell数据混乱
//
//  Created by bjzyzl on 2017/6/20. ceshi
//  Copyright © 2017年 bjzyzl. All rights reserved.
//

#import "ViewController.h"
static NSString * IDcell = @"cell";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation ViewController
{
    NSMutableDictionary * _dict;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dict = [NSMutableDictionary dictionary];

    UITableView * tableview = [[UITableView alloc]init];
    tableview.frame = self.view.bounds;
    tableview.delegate = self;
    tableview.dataSource = self;
    [self.view addSubview:tableview]; 
}
-(void)textFieldDidChange :(UITextField *)textField{
    
    NSUInteger index = textField.tag - 100;
    [_dict setObject:textField.text forKey:[NSString stringWithFormat:@"%ld",index]];
}
#pragma mark - tabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:IDcell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDcell];
    }
    
    UITextField * tf = [cell viewWithTag:100 + indexPath.row];
    [cell willRemoveSubview:tf];
    
    UITextField * textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(20, 30, self.view.frame.size.width - 40, 40);
    textField.tag = 100 + indexPath.row;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    textField.backgroundColor = [UIColor yellowColor];
    [cell addSubview:textField];

    NSString * str2 = [_dict objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    if (str2.length > 0) {
        
        textField.text = str2;
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
