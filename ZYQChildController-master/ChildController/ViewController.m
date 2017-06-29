//
//  ViewController.m
//  AFN网络请求
//
//  Created by bjzyzl on 2017/5/15.
//  Copyright © 2017年 bjzyzl. All rights reserved.
//

#import "ViewController.h"
#import "ZYQTitleSCView.h"
#import "ZYQHomeTableViewController.h"
#import "ZYQFirstVC.h"
#define MSW ([UIScreen mainScreen].bounds.size.width)
#define MSH ([UIScreen mainScreen].bounds.size.height)



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"子控制器";
    
    NSArray * array = @[@"子控制器-1",@"子控制器-2",@"子控制器-3",@"子控制器-4",@"子控制器-5",@"子控制器-6",@"子控制器-7",@"子控制器-8"];
    
    ZYQTitleSCView * scView = [ZYQTitleSCView titleScrollViewWithFrame:CGRectMake(0, 64, MSW, MSH - 64) titleArray:array];
    [self.view addSubview:scView];
    
    scView.contentArray = @[[[ZYQFirstVC alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init],[[ZYQHomeTableViewController alloc]init]];
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
