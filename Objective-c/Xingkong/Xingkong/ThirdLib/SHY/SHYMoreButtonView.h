//
//  SHYMoreButtonView.h
//  CatPregnent2
//
//  Created by MrSui on 2020/6/11.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface SHYMoreButtonView : UIScrollView


@property (strong,nonatomic)  NSString *btnNormalImage;
@property (strong,nonatomic)  NSString *btnSelectImage;
@property (strong,nonatomic)  UIColor *btnTitleNormalColor;
@property (strong,nonatomic)  UIColor *btnTitleSelectColor;

@property (strong,nonatomic)  UIColor *lineColor;

@property (assign,nonatomic)  NSInteger fontSize;

/*
 btnNameArray   多按钮的名称
 isCenter       按钮是否需要均分View的宽度
 
 此方法主要用于按钮数组固定的情况，默认选择第一个
 */
- (instancetype)initWithFrame:(CGRect)frame;
- (void)initSubViews:(NSArray *)btnNameArray andIsCenter:(BOOL)isCenter;
//当前的选中的位置
@property (nonatomic, assign) NSInteger selectedIndex;
//点击按钮的回调
@property (nonatomic, copy) void (^clickedBtnsBlock)(NSInteger index,NSString *btnStr);

@end

NS_ASSUME_NONNULL_END
