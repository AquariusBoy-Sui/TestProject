//
//  SHYAlertView.h
//  CatPregnent2
//
//  Created by MrSui on 2020/5/29.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <MBProgressHUD.h>

#import "CoreDataBLL.h"
#import "PersonBLL.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController(SHYAlertView)

/**
 显示进度条带文字
 */
-(void)showUploadHUD:(NSString *)text;

/**
*  弹出消息框 自动隐藏
*
*  @param text 消息内容
*  @param delay   显示时间
*/
- (void)showAlertViewWithText:(NSString *)text delayHid:(NSTimeInterval)delay;
/**
*  弹出默认菊花框
*/
- (void)showHUD;
/**
*  隐藏默认菊花框
*/
- (void)hideHUD;
/**
*  弹出默认 圆形进度条
*/
- (void)showUploadHUD;
/**
*  弹出默认 圆形进度条
*  @param progress   上传进度
*/
-(void)setUploadHUDProgress:(float)progress;

/**
*  弹出信息
*  @messages   消息内容
*/
-(void)showAlert:(NSString *)messages;
/**
*  提示框 带  确定 取消
*  @messages   消息内容
*  @handler   回调
*/

- (void)showAlert:(NSString *)messages handler:(void (^ __nullable)(UIAlertAction *action))handler;
/**
*  提示框 确定按钮
*  @messages   消息内容
*  @handler   回调
*/

- (void)showTop:(NSString *)messages handler:(void (^ __nullable)(UIAlertAction *action))handler;

/**
*  网络状态 登录状态 提示
*/
-(BOOL)showNetworkStatusAndLoginStatus;

@end

NS_ASSUME_NONNULL_END
