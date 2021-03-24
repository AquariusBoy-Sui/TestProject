//
//  SHYWeChatShareManager.h
//  CatPregnent2
//
//  Created by MrSui on 2020/6/1.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>


#define WXAppId            @"wxa6fd31898276c836"    //App ID  猫孕日记 微信key
#define WXUniversalLink          @"https://catapp.ayougame.com/public/" //Universal Links

#define WXAppId_Pro            @"wx5054c2fab8b552e1"    //App ID  猫孕日记专业版 微信key
#define WXUniversalLink_Pro          @"https://catapp.ayougame.com/appsite/catbirthdaypower/" //Universal Links


NS_ASSUME_NONNULL_BEGIN

@interface SHYWeChatShareManager : NSObject


+(void)registerApp:(NSString *)appid universalLink:(NSString *)universalLink;


+ (BOOL)isWXAppInstalled;

/**
 分享网页
 @param title 标题
 @param description 描述
 @param thumbImage 缩略图
 @param webpageUrl 链接
 @param type 分享类型 0：聊天界面 1：朋友圈 2：收藏
 */
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(int)type
                    videoEntityID:(NSString *)videoEntityID;
/**
分享网页 猫咪页面
@param title 标题
@param description 描述
@param thumbImage 缩略图
@param webpageUrl 链接
@param type 分享类型 0：聊天界面 1：朋友圈 2：收藏
*/
+ (void)shareToWechatWithtoWebTitle:(NSString *)title
description:(NSString *)description
 thumbImage:(UIImage *)thumbImage
 webpageUrl:(NSString *)webpageUrl
       type:(int)type;

@end

NS_ASSUME_NONNULL_END
