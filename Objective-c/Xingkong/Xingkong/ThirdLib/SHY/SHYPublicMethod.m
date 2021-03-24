//
//  SHYPublicMethod.m
//  CatPregnent2
//
//  Created by MrSui on 2020/6/19.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "SHYPublicMethod.h"
#import <UserNotifications/UserNotifications.h>
#import "NSDate+Local.h"
@implementation SHYPublicMethod

+ (BOOL)getDeviceIsPad
{
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}
+ (void)removeLocalFile:(NSString*)fileName{
    NSFileManager*fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:fileName]) {
        return;
    }
    NSError *error;
    [fileManager removeItemAtPath:fileName error:&error];
    if ([error userInfo]) {
        NSLog(@"removeLocalFile %@",[error userInfo]);
    }else{
        NSLog(@"removeLocalFile %@",fileName);
    }
}
+ (int)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            degress = 90;
        } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
            degress = 270;
        } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
            degress = 0;
        } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
            degress = 180;
        }
    }
    return degress;
}

   /*
       NSString *videoName  =[NSString stringWithFormat:@"video-%@.mp4",[NSUUID uuidObjectID]];
       AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:videoAsset presetName:AVAssetExportPresetHighestQuality];
       session.outputFileType = AVFileTypeMPEG4;

       session.outputURL =[NSURL fileURLWithPath:[kCachesPath stringByAppendingPathComponent:videoName]];
       [session exportAsynchronouslyWithCompletionHandler:^{
           NSLog(@"缓存视频 %@",session.outputURL);
     
           }];
       
*/
/**
  IOS 10的通知   推送消息 支持的音频 <= 5M(现有的系统偶尔会出现播放不出来的BUG)  图片 <= 10M  视频 <= 50M  ，这些后面都要带上格式；
 @param title 消息标题
 @param body 消息内容
 @param promptTone 提示音
 @param soundName 音频
 @param imageName 图片
 @param movieName 视频
 @param identifier 消息标识
 @param date 通知时间
 @param day 通知循环间隔时间
 */

+(void)pushNotificationTitle:(NSString *)title
                          Body:(NSString *)body
                    promptTone:(NSString *)promptTone
                     soundName:(NSString *)soundName
                     imageName:(NSString *)imageName
                     movieName:(NSString *)movieName
                    Identifier:(NSString *)identifier
                    timeDate:(NSDate *)date
                    timePeriod:(NSInteger)Type{
     //获取通知中心用来激活新建的通知
    UNUserNotificationCenter * center  = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc]init];
    content.title=title;
    content.body = body;
    //通知的提示音
    if ([promptTone containsString:@"."]) {
        UNNotificationSound *sound = [UNNotificationSound soundNamed:promptTone];
        content.sound = sound;
    }
    __block UNNotificationAttachment *imageAtt;
    __block UNNotificationAttachment *movieAtt;
    __block UNNotificationAttachment *soundAtt;
    
    NSMutableArray * array = [NSMutableArray array];
    if ([imageName containsString:@"."]) {
        
        [SHYPublicMethod addNotificationAttachmentContent:content attachmentName:imageName options:nil withCompletion:^(NSError *error, UNNotificationAttachment *notificationAtt) {
            imageAtt = [notificationAtt copy];
            [array addObject:imageAtt];
        }];
    }
    
    if ([soundName containsString:@"."]) {
        [SHYPublicMethod addNotificationAttachmentContent:content attachmentName:soundName options:nil withCompletion:^(NSError *error, UNNotificationAttachment *notificationAtt) {
            soundAtt = [notificationAtt copy];
            [array addObject:soundAtt];
        }];
        
    }
    if ([movieName containsString:@"."]) {
        // 在这里截取视频的第10s为视频的缩略图 ：UNNotificationAttachmentOptionsThumbnailTimeKey
        [SHYPublicMethod addNotificationAttachmentContent:content attachmentName:movieName options:@{@"UNNotificationAttachmentOptionsThumbnailTimeKey":@10} withCompletion:^(NSError *error, UNNotificationAttachment *notificationAtt) {
            movieAtt = [notificationAtt copy];
            [array addObject:movieAtt];
        }];
    }
    content.attachments = array;
    //添加通知下拉动作按钮
    NSMutableArray * actionMutableArray = [NSMutableArray array];
    UNNotificationAction * actionA = [UNNotificationAction actionWithIdentifier:@"identifierNeedUnlock" title:@"进入应用" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction * actionB = [UNNotificationAction actionWithIdentifier:@"identifierRed" title:@"忽略" options:UNNotificationActionOptionDestructive];
    [actionMutableArray addObjectsFromArray:@[actionA,actionB]];
    
    if (actionMutableArray.count > 1) {
        
        UNNotificationCategory * category = [UNNotificationCategory categoryWithIdentifier:@"categoryNoOperationAction" actions:actionMutableArray intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
        [center setNotificationCategories:[NSSet setWithObjects:category, nil]];
        content.categoryIdentifier = @"categoryNoOperationAction";
    }
    
    //UNTimeIntervalNotificationTrigger   延时推送
    //UNCalendarNotificationTrigger       定时推送
    //UNLocationNotificationTrigger       位置变化推送
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    if (Type == 0) {
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *components = [calendar components:unitFlags fromDate:date];
 
        UNNotificationTrigger * trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        //将建立的通知请求添加到通知中心
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Sui______首次消息通知 identifier:%@ error:%@",identifier,error);
                return;
            }
            NSLog(@"Sui______首次消息通知 identifier:%@ %ld-%ld-%ld %ld:%ld:%ld ",identifier,components.year,components.month,components.day,components.hour,components.minute,components.minute);
        }];
    }else if (Type == 1) {

        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  ;
        NSDateComponents *components = [calendar components:unitFlags fromDate:date];
        components.hour=8;
        components.minute=00;
        components.second=00;
        UNNotificationTrigger * trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        //将建立的通知请求添加到通知中心
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Sui______首次猫孕通知 identifier:%@ error:%@",identifier,error);
                return;
            }
            NSLog(@"Sui______首次猫孕通知 identifier:%@ %ld-%ld-%ld %ld:%ld:%ld ",identifier,components.year,components.month,components.day,components.hour,components.minute,components.minute);
        }];
    }else if (Type == 2) {
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *components = [calendar components:unitFlags fromDate:date];
        UNNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        //将建立的通知请求添加到通知中心
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Sui______更新通知 identifier:%@ error:%@",identifier,error);
                return;
            }
            NSLog(@"Sui______更新通知 identifier:%@ %ld-%ld-%ld %ld:%ld:%ld ",identifier,components.year,components.month,components.day,components.hour,components.minute,components.minute);
        }];
    }else{
        // 延时推送
        UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error) {
                NSLog(@"Sui______延时推送 identifier:%@ error:%@",identifier,error);
                return;
            }
            NSLog(@"Sui______延时推送 identifier:%@",identifier);
        }];
    }
}
+(void)cancleNotificationIdentifier:(NSString *)identifier
{
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[identifier]];
    NSLog(@"Sui______取消通知 identifier:%@",identifier);
}
+(void)removeNotificationIdentifier:(NSString *)identifier
{
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc]init];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *identifier0 = @"deliveredSendAndRemove";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier0 content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[identifier0]];
    });

    
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    NSLog(@"Sui______删除通知 identifier:%@",identifier);
}
+(void)addNotificationAttachmentContent:(UNMutableNotificationContent *)content attachmentName:(NSString *)attachmentName  options:(NSDictionary *)options withCompletion:(void(^)(NSError * error , UNNotificationAttachment * notificationAtt))completion{

    NSArray * arr = [attachmentName componentsSeparatedByString:@"."];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //获取文件名(也就是取得路径的最后一个路径)
    NSString *fileName = [attachmentName lastPathComponent];
    NSArray * fileNameArr = [fileName componentsSeparatedByString:@"."];
    fileName=[NSString stringWithFormat:@"000%@.%@",fileNameArr[0],fileNameArr[1]];
    //计算出全路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
    NSError * error;
    
//    if ([fileManager fileExistsAtPath:filePath]) {
//        UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:[NSString stringWithFormat:@"notificationAtt_%@",arr[1]] URL:[NSURL fileURLWithPath:filePath] options:options error:&error];
//        if (error) {
//            NSLog(@"attachment error %@", error);
//        }
//        completion(error,attachment);
//        //获取通知下拉放大图片
//        content.launchImageName = filePath;
//    }
//    else {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:attachmentName]];
            // 将图片文件数据写入沙盒中
        BOOL isSave= [data writeToFile:filePath atomically:YES];
        if(isSave){
            UNNotificationAttachment * attachment = [UNNotificationAttachment attachmentWithIdentifier:[NSString stringWithFormat:@"notificationAtt_%@",arr[1]] URL:[NSURL fileURLWithPath:filePath] options:options error:&error];
            if (error) {
                NSLog(@"attachment error %@", error);
            }
            completion(error,attachment);
            //获取通知下拉放大图片
            content.launchImageName = filePath;
        }
//    }

}



#pragma mark -
/**
 增加本地消息通知
 */
+(void)addLocalPushNotificationTitle:(NSString *)title
                                Body:(NSString *)body
                           soundName:(NSString * __nullable)soundName
                           imageName:(NSString *)imageName
                          Identifier:(NSString *)identifier
                            timeDate:(NSDate *)date{
    //测试10秒后显示消息推送
    //date=[NSDate dateWithTimeIntervalSinceNow:10];
    //获取通知中心用来激活新建的通知
    UNUserNotificationCenter * center  = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    content.title=title;
    content.body = body;
    //通知的提示音
    if (soundName) {
        UNNotificationSound *sound = [UNNotificationSound soundNamed:soundName];
        content.sound = sound;
    }
//    content.launchImageName = imageName;
    NSCalendar *calendar = [NSCalendar currentCalendar];//定义一个NSCalendar对象
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    UNNotificationTrigger * trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    //将建立的通知请求添加到通知中心
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Sui______首次消息通知 identifier:%@ error:%@",identifier,error);
            return;
        }
        NSLog(@"Sui______首次消息通知 identifier:%@ %ld-%ld-%ld %ld:%ld:%ld ",identifier,components.year,components.month,components.day,components.hour,components.minute,components.minute);
    }];
}


/**
 删除本地消息通知
 */
+(void)removeLocalNotification:(NSString *)identifier
{
    //获取通知中心用来激活新建的通知
    UNUserNotificationCenter * center  = [UNUserNotificationCenter currentNotificationCenter];
    [center removeDeliveredNotificationsWithIdentifiers:@[identifier]];
    [center removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

@end
