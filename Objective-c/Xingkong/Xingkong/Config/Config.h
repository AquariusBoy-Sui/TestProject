//
//  Config.h
//  TianjinBoHai
//
//  Created by Binky Lee on 15/1/16.
//  Copyright (c) 2015年 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define WS(weakSelf) __weak __typeof(&*self) weakSelf = self


//定义函数指针回调宏
#define FunCall(...) void(^)(__VA_ARGS__)

// 定义这个常量,以支持在 Masonry 语法中自动将基本类型转换为 object 类型:
#define MAS_SHORTHAND_GLOBALS

// string change to number
#define SCTN(x) ({ NSNumber * nums = @([x integerValue]);nums;})
#define NCTS(X) ([NSString stringWithFormat:@"%@", X ?: @""])

#define SCALE(X) (ceil(X * [UIScreen mainScreen].bounds.size.width/320.0))

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {\
isPhoneX = NO;\
}\
(isPhoneX);})

#define DEF_NAVI_HEIGHT IPHONE_X ? 88.0 : 44.0
/**
 *数字金额格式化
 */
#define     IntNumberFormatter(number) ({NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];     [formatter setPositiveFormat:@"###,###"]; NSString *string = [formatter stringFromNumber:number]; string;})
#define     FloatNumberFormatter(number) ({NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];     [formatter setPositiveFormat:@"#####0.00"]; NSString *string = [formatter stringFromNumber:number]; string;})


@interface Config : NSObject
UIColor* getColor(NSString * hexColor);
@end
