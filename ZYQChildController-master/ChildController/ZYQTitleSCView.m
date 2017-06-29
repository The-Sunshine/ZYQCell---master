//
//  ZYQTitleSCView.m
//
//
//  Created by zyq on 2017/6/6.
//  Copyright © 2017年 zyq. All rights reserved.
//

#import "ZYQTitleSCView.h"

#define MSW ([UIScreen mainScreen].bounds.size.width)
#define MSH ([UIScreen mainScreen].bounds.size.height)

@interface ZYQTitleSCView ()<UIScrollViewDelegate>

@end

@implementation ZYQTitleSCView
{
    UIScrollView * _titleSV;
    UIScrollView * _contentSV;
    UIButton     * _lastSelect;
    UIView       * _line;
    CGFloat        _buttonWidth; // 计算button的总宽度
}
#pragma mark - initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initialization];
    [self setupMainView];
}
-(void)initialization
{
    _titleFont = [UIFont systemFontOfSize:13];
    _titleColor = [UIColor blackColor];
    _selectTitleColor = [UIColor orangeColor];
    _titleBackGroundColor = [UIColor grayColor];
    _btnInterval = 10;
    _titleHeight = 30;
    _isExpand = YES;
}
-(void)setupMainView
{
    UIScrollView * titleSV = [[UIScrollView alloc]init];
    titleSV.showsHorizontalScrollIndicator = NO;
    [self addSubview:titleSV];
    _titleSV = titleSV;
    
    UIScrollView * contentSV = [[UIScrollView alloc]init];
    contentSV.showsHorizontalScrollIndicator = NO;
    contentSV.showsVerticalScrollIndicator = NO;
    contentSV.pagingEnabled = YES;
    contentSV.delegate = self;
    contentSV.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentSV];
    _contentSV = contentSV;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _titleSV.frame = CGRectMake(0, 0, self.frame.size.width, _titleHeight);
    _titleSV.backgroundColor = _titleBackGroundColor;

    _contentSV.frame = CGRectMake(0, _titleHeight, MSW, self.frame.size.height - _titleHeight);
}

#pragma mark - setter
-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
}

-(void)setContentArray:(NSArray *)contentArray
{
    _contentArray = contentArray;
    
    _buttonWidth = 10; // 计算button的左边距
    
    for (NSInteger i = 0; i < _contentArray.count; i ++) {
        
        [self addChildViewController:_contentArray[i] title:_titleArray[i]];

        CGFloat width = [_titleArray[i] sizeWithAttributes:@{NSFontAttributeName:_titleFont}].width;
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(_buttonWidth, [self nextViewController:self].navigationController ? -64 : 0, width, _titleHeight)];
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)]];
        label.tag = 100 + i;
        label.font = _titleFont;
        label.userInteractionEnabled = YES;
        label.text =[[self nextViewController:self].childViewControllers[i]title];
        [_titleSV addSubview:label];
        
        if (i == 0) label.textColor = _selectTitleColor;
        
        if (i == _contentArray.count - 1) {
            
            UIView * line = [[UIView alloc]init];
            line.frame = CGRectMake(_buttonWidth, label.frame.size.height + label.frame.origin.y - 1, label.frame.size.width, 1);
            line.backgroundColor = _selectTitleColor;
            [_titleSV addSubview:line];
            _line = line;
        }
        _buttonWidth = _buttonWidth + width + _btnInterval;
    }
    
    _titleSV.contentSize = CGSizeMake(_buttonWidth, [self nextViewController:self].navigationController ? -64 : 0);

    _contentSV.contentSize = CGSizeMake(_contentArray.count * MSW, 0);
    
    // 默认显示第0个子控制器
    [self scrollViewDidEndScrollingAnimation:_contentSV];
}

#pragma mark - 初始化
+(instancetype)titleScrollViewWithFrame:(CGRect)frame titleArray:(NSArray *)array
{
    ZYQTitleSCView * view = [[self alloc]initWithFrame:frame];
    view.titleArray = array;
    return view;
}

#pragma mark clickEvent
-(void)click:(UITapGestureRecognizer *)tap
{
    //取出被点击label的索引
    NSInteger index = tap.view.tag - 100;
    //让底部的内容scrollView 滚动到对应位置
    CGPoint offset = _contentSV.contentOffset;
    offset.x = index * _contentSV.frame.size.width;
    [_contentSV setContentOffset:offset animated:YES];
}

#pragma mark - scrollViewDelegate
// 滚动结束调用
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //临时变量
    CGFloat height = MSH - _titleHeight;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    //当前位置需要显示控制器的索引
    NSInteger index = offsetX / MSW;
    //让对应的顶部title 标题显示
    UILabel * label = _titleSV.subviews[index];
    CGPoint titleOffset = _titleSV.contentOffset;
    titleOffset.x = label.center.x - MSW * 0.5;
    //左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    //右边超出处理
    CGFloat maxTitleOffsetX = _titleSV.contentSize.width - MSW;
    if (titleOffset.x > maxTitleOffsetX)titleOffset.x =maxTitleOffsetX;
    
    [_titleSV setContentOffset:titleOffset animated:YES];

    //让其他label 回到最初的状态
    for (NSInteger i = 0; i < _titleArray.count; i ++) {
        
        UILabel * otherLabel = _titleSV.subviews[i];
        if (otherLabel != label) {
            
            otherLabel.textColor = _titleColor;
        }
    }
    
    //取出要显示的控制器
    UIViewController *willShowVC = [self nextViewController:self].childViewControllers[index];
    //如果已经显示过了就返回
    if ([willShowVC isViewLoaded]) return;
    //添加控制器的view 到contentScrollview中
    willShowVC.view.frame =CGRectMake(offsetX, 0, MSW, height);
    [scrollView addSubview:willShowVC.view];
}

// 滚动将要完成 减速时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 滚动时调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x /scrollView.frame.size.width;
    if (scale < 0 || scale > _titleSV.subviews.count - 1)return;

    //获取左边label
    NSInteger leftIndex =scale;
    UILabel *leftLabel = _titleSV.subviews[leftIndex];
    //获取右边label
    NSInteger rightIndex =leftIndex + 1;
    UILabel *rightLabel =(rightIndex == _titleSV.subviews.count)? nil : _titleSV.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 字体颜色
    if (leftScale > rightScale) {

        leftLabel.textColor = _selectTitleColor;
        if (scale < _titleArray.count - 1) {
            rightLabel.textColor = _titleColor;
        }
    }else
    {
        leftLabel.textColor = _titleColor;
        rightLabel.textColor = _selectTitleColor;
    }
    
    // 字体大小
    leftLabel  = [self controlLabelColorWithTransform:leftScale Label:leftLabel];
    if (scale < _titleArray.count - 1) {
        
        rightLabel  = [self controlLabelColorWithTransform:rightScale Label:rightLabel];
    }
    
    // 动画改变下划线的位置
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = _line.frame;
        frame.origin.x = leftLabel.frame.origin.x;
        frame.size.width = leftLabel.frame.size.width;
        _line.frame = frame;
    }];
}

#pragma mark - tool
/** 添加控制器 */
-(void)addChildViewController:(UIViewController *)childVC title:(NSString *)vcTitle{
    
    UIViewController * vc = [self nextViewController:self];
    childVC.title = vcTitle;
    [vc addChildViewController:childVC];
}

/** 获取控制器 */
-(UIViewController *)nextViewController:(UIView *)view
{
    id vc = view;
    while (vc) {
        vc = ((UIResponder *)vc).nextResponder;
        if ([vc isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return vc;
}

/** 修改字体大小和颜色 */
-(UILabel *)controlLabelColorWithTransform:(CGFloat)scale Label:(UILabel *)label
{
    if (_isExpand == NO) return label;
    
    //大小缩放比例
    CGFloat transformScale = 1 + scale * 0.2;

    label.transform = CGAffineTransformMakeScale(transformScale, transformScale);

    return label;
}

@end
