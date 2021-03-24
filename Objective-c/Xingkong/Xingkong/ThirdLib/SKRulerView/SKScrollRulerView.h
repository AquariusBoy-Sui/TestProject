//
//  SKScrollRulerView.h
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SKScrollRulerView;
@protocol SKScrollRulerViewDelegate <NSObject>

/**
 游标卡尺滑动，对应value回调
 @param rulerView 滑动视图
 @param value 当前滑动的值
 */
- (void)sbScrollRulerView:(SKScrollRulerView *)rulerView valueChange:(float)value;
@end

@interface SKScrollRulerView : UIView


///刻度盘
@property (nonatomic ,strong)UICollectionView * collectionView;
/// 代理
@property(nonatomic, weak) id<SKScrollRulerViewDelegate> delegate;

/**
 带上下阀值的刻度尺

 @param frame 位置
 @param minValue 最小值，整型，暂不支持浮点型
 @param maxValue 最大值，整型，暂不支持浮点型
 @param step 每个小刻度间隔值
 @param rulerGap 每个小刻度相隔像素
 @param maxThresholdValue 上限阀值，超过该值刻度尺颜色变化
 @param minThresholdValue 下限阀值，超过该值刻度尺颜色变化
 @return 刻度尺
 */
- (instancetype)initWithFrame:(CGRect)frame theMinValue:(NSInteger)minValue theMaxValue:(NSInteger)maxValue theStep:(CGFloat)step theRulerGap:(CGFloat)rulerGap theMaxThresholdValue:(CGFloat)maxThresholdValue theMinThresholdValue:(CGFloat)minThresholdValue;

/**
 设定默认位置

 @param defaultValue 默认值
 @param animated 是否开启动画
 */
- (void)setDefaultValue:(float)defaultValue animated:(BOOL)animated;

@end

