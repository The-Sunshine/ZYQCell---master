//
//  ZYQTitleSCView.h
//
//
//  Created by zyq on 2017/6/6.
//  Copyright © 2017年 zyq. All rights reserved.


#import <UIKit/UIKit.h>

@interface ZYQTitleSCView : UIView

/** 初始化标题栏 */
+(instancetype)titleScrollViewWithFrame:(CGRect)frame titleArray:(NSArray *)array;

/** 字体大小 */
@property (nonatomic,strong) UIFont  * titleFont;

/** 字体间隔 */
@property (nonatomic,assign) NSInteger btnInterval;

/** 字体颜色 */
@property (nonatomic,strong) UIColor * titleColor;

/** 选中字体颜色 */
@property (nonatomic,strong) UIColor * selectTitleColor;

/** 标题栏背景色 */
@property (nonatomic,strong) UIColor * titleBackGroundColor;

/** 标题数组 */
@property (nonatomic,strong) NSArray * titleArray;

/** 标题栏高度 */
@property (nonatomic,assign) CGFloat titleHeight;

/** 字体放大是否开启 默认开启 */
@property (nonatomic,assign) BOOL isExpand;

/** 内容栏控制器数组 需要放在所有方法实现后 */
@property (nonatomic,strong) NSArray * contentArray;

@end
