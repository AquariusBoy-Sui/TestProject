//
//  SKRulerViewConfiguration.m
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SKRulerViewConfiguration.h"





@implementation SKRulerViewConfiguration

+ (SKRulerViewConfiguration *)shareConfiguration{

    static SKRulerViewConfiguration * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SKRulerViewConfiguration alloc] init];
        [manager defaultConfiguration];
        
    });
    return manager;
    
}


#pragma mark ===============默认配置===============
- (void)defaultConfiguration{

    
    /*
     ///标线属性设置
     @property (nonatomic ,assign)CGFloat longScale_h;///长刻度标线高度
     @property (nonatomic ,assign)CGFloat longScale_w;///长刻度标线宽度
     @property (nonatomic ,strong)UIColor * longScale_c;///长刻度标线颜色
     @property (nonatomic ,assign)CGFloat shortScale_h;///短刻度高度
     @property (nonatomic ,assign)CGFloat shortScale_w;///短刻度宽度
     @property (nonatomic ,strong)UIColor * shortScale_c;///短刻度标线颜色
     @property (nonatomic ,assign)CGFloat semiScale_h;///半刻度标线高度
     @property (nonatomic ,assign)CGFloat semiScale_w;///半刻度标线宽度
     @property (nonatomic ,strong)UIColor * semiScale_c;///半刻度标线颜色
     @property (nonatomic ,strong)UIColor * beyondCScale_c;///超出范围的刻度标线
     
     ///刻度值属性
     @property(nonatomic, assign)CGFloat step;///间隔值 每两条刻度线相隔多少值
     @property (nonatomic, assign)CGFloat rulerGap;///小刻度单位距离 px
     @property (nonatomic, assign)CGFloat rulerFont;///刻度文字 字体注：字体与字体绘制高度一定匹配，高度不够字体大会错乱
     @property (nonatomic, assign)CGFloat rulerTitle_H;/// 刻度文字 绘制高度<默认 30>
     @property (nonatomic, assign)CGFloat rulerTitle_Padding;/// 刻度文字 与 分割线间距
     @property(nonatomic, strong)UIColor *rulerTitle_Color;/// 标尺 文本颜色
     
     ///标尺中间三角形属性
     @property(nonatomic, strong)UIColor *triangle_Color;/// 标尺指示三角形
     @property(nonatomic, assign)CGFloat triangle_w;/// 标尺指示三角形宽度
     @property(nonatomic, assign)CGFloat triangle_h;/// 标尺指示三角形高度
     
     ///标尺属性
     @property(nonatomic, strong)UIColor *rulerView_BGColor;///标尺背景颜色
     @property(nonatomic, assign) CGFloat maxValue;/// 最大值
     @property(nonatomic, assign) CGFloat minValue;/// 最小值
     @property(nonatomic, copy) NSString *unit;/// 单位

     
     */
    //标线属性

    self.longScale_h = 20.0;
    self.longScale_w = 2.0;
    self.longScale_c = [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0];
    self.shortScale_h = 10.0;
    self.shortScale_w = 1.0;
    self.shortScale_c = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
    self.semiScale_h = 15.0;
    self.semiScale_w = 1.0;
    self.semiScale_c = [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
    self.beyondCScale_c = [UIColor redColor];
    //刻度相关
    self.step = 0.1;
    self.rulerGap = 6.0;
    self.rulerFont = 12;
    self.rulerTitle_Padding = 10;
    self.rulerTitle_Color = [UIColor colorWithWhite:0.0 alpha:0.8];
    //指示三角形属性
    self.triangle_Color = getColor(@"fee8bf");
    self.triangle_w = 8.0;
    self.triangle_h = 40.0;
    //标尺属性
    self.rulerView_BGColor = [UIColor yellowColor];
    self.maxValue = 30;
    self.minValue = 0.0;
    self.ruler_h = 80.0;
    self.maxThresholdValue = 29.9;
    self.minThresholdValue = 5.5;
    
    
}

@end
