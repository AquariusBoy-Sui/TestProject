//
//  SHYPublicMethod.h
//  CatPregnent2
//
//  Created by MrSui on 2020/6/19.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHYPublicMethod : NSObject

+ (int)degressFromVideoFileWithAsset:(AVAsset *)asset;//获取视频角度
+ (void)removeLocalFile:(NSString*)fileName;//删除本地缓存目录文件
+ (BOOL)getDeviceIsPad;//判断是否Pad
+(void)pushNotificationTitle:(NSString *)title
                          Body:(NSString *)body
                    promptTone:(NSString *)promptTone
                     soundName:(NSString *)soundName
                     imageName:(NSString *)imageName
                     movieName:(NSString *)movieName
                    Identifier:(NSString *)identifier
                      timeDate:(NSDate *)date
                    timePeriod:(NSInteger)Type;

+(void)cancleNotificationIdentifier:(NSString *)identifier;    //取消未通知的标示
+(void)removeNotificationIdentifier:(NSString *)identifier;    //删除已经通知的标示


//增加本地消息通知
+(void)addLocalPushNotificationTitle:(NSString *)title
                                Body:(NSString *)body
                           soundName:(NSString * __nullable)soundName
                           imageName:(NSString *)imageName
                          Identifier:(NSString *)identifier
                            timeDate:(NSDate *)date;

//删除本地消息通知
+(void)removeLocalNotification:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
