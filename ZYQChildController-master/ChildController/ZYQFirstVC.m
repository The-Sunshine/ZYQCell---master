//
//  ZYQFirstVC.m
//  ChildController
//
//  Created by bjzyzl on 2017/6/23.
//  Copyright © 2017年 bjzyzl. All rights reserved.
//

#import "ZYQFirstVC.h"

@interface ZYQFirstVC ()

@end

@implementation ZYQFirstVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor greenColor];
    view.frame = CGRectMake(0, 100, self.view.frame.size.width, 40);
    [self.view addSubview:view];
    
    UIView * view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor grayColor];
    view2.frame = CGRectMake(20, 150, self.view.frame.size.width - 40, 40);
    [self.view addSubview:view2];
  
}


@end
