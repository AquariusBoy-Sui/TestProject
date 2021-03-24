//
//  SKRulerViewConfiguration.h
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define SKShareConfiguration [SKRulerViewConfiguration shareConfiguration]

@interface SKRulerViewConfiguration : NSObject

///=========标线属性设置=========
///长刻度标线高度
@property (nonatomic ,assign)CGFloat longScale_h;
///长刻度标线宽度
@property (nonatomic ,assign)CGFloat longScale_w;
///长刻度标线颜色
@property (nonatomic ,strong)UIColor * longScale_c;
///短刻度高度
@property (nonatomic ,assign)CGFloat shortScale_h;
///短刻度宽度
@property (nonatomic ,assign)CGFloat shortScale_w;
///短刻度标线颜色
@property (nonatomic ,strong)UIColor * shortScale_c;
///半刻度标线高度
@property (nonatomic ,assign)CGFloat semiScale_h;
///半刻度标线宽度
@property (nonatomic ,assign)CGFloat semiScale_w;
///半刻度标线颜色
@property (nonatomic ,strong)UIColor * semiScale_c;
///超出范围的刻度标线
@property (nonatomic ,strong)UIColor * beyondCScale_c;

///=============刻度属性============

///间隔值 每两条刻度线相隔多少值
@property(nonatomic, assign)CGFloat step;
///小刻度单位距离 px
@property (nonatomic, assign)CGFloat rulerGap;
///刻度文字大小
@property (nonatomic, assign)CGFloat rulerFont;
/// 刻度文字 与 分割线间距
@property (nonatomic, assign)CGFloat rulerTitle_Padding;
/// 标尺 文本颜色
@property(nonatomic, strong)UIColor *rulerTitle_Color;

///==============标尺中间三角形属性===========
/// 标尺指示三角形
@property(nonatomic, strong)UIColor *triangle_Color;
/// 标尺指示三角形宽度
@property(nonatomic, assign)CGFloat triangle_w;
/// 标尺指示三角形高度
@property(nonatomic, assign)CGFloat triangle_h;

///==============标尺属性===========
///标尺背景颜色
@property(nonatomic, strong)UIColor *rulerView_BGColor;
/// 最大值
@property(nonatomic, assign) CGFloat maxValue;
/// 最小值
@property(nonatomic, assign) CGFloat minValue;
/// 标尺高度
@property(nonatomic, assign) CGFloat ruler_h;
/// 单位
@property(nonatomic, copy) NSString *unit;
/// 超出范围阀值
@property(nonatomic, assign) CGFloat maxThresholdValue;
/// 低于范围阀值
@property(nonatomic, assign) CGFloat minThresholdValue;

+ (SKRulerViewConfiguration *)shareConfiguration;

@end

NS_ASSUME_NONNULL_END
