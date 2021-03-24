//
//  SHYWeChatShareManager.m
//  CatPregnent2
//
//  Created by MrSui on 2020/6/1.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "SHYWeChatShareManager.h"


@interface SHYWeChatShareManager ()

@end

@implementation SHYWeChatShareManager

+(void)registerApp:(NSString *)appid universalLink:(NSString *)universalLink{
//    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
//            NSLog(@"Sui______ wxlog:%@", log);
//    }];
    if([WXApi registerApp:appid universalLink:universalLink]){
        NSLog(@"Sui______ 微信初始化成功");
        //自检函数
//        [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult* result) {
//            NSLog(@"Sui______ %@, %u, %@, %@", @(step), result.success, result.errorInfo, result.suggestion);
//        }];
    }
}

+ (BOOL)isWXAppInstalled
{
    return [WXApi isWXAppInstalled];
}



//分享网页链接
+ (void)shareToWechatWithWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(int)type
                    videoEntityID:(NSString *)videoEntityID
{
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = type;//0.好友列表 1.朋友圈 2.收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title;//标题
    urlMessage.description = description;//描述内容
    [urlMessage setThumbImage:thumbImage];//设置图片
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = webpageUrl;//URL链接
    
    //微信小程序
    WXMiniProgramObject *whatobject = [WXMiniProgramObject object];
    whatobject.webpageUrl = @"http://www.qq.com";
    whatobject.userName = @"gh_53c956f0c276";
    whatobject.path =[NSString stringWithFormat:@"pages/index/index?message=%@",videoEntityID];
    whatobject.hdImageData = UIImageJPEGRepresentation(thumbImage, 0.5);
    whatobject.withShareTicket = false;
    whatobject.miniProgramType = WXMiniProgramTypePreview;
    
    //完成发送对象实例
    urlMessage.mediaObject = whatobject;
    sendReq.message = urlMessage;
    
    //发送请求
     [WXApi sendReq:sendReq completion:^(BOOL success) {
         NSLog(@"SHYWeChatShareManager 唤起微信:%@", success ? @"成功" : @"失败");
     }];
}

//分享猫咪网页链接
+ (void)shareToWechatWithtoWebTitle:(NSString *)title
                      description:(NSString *)description
                       thumbImage:(UIImage *)thumbImage
                       webpageUrl:(NSString *)webpageUrl
                             type:(int)type
{
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = type;//0.好友列表 1.朋友圈 2.收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title;//标题
    urlMessage.description = description;//描述内容
    [urlMessage setThumbImage:thumbImage];//设置图片
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webpageUrl;
    urlMessage.mediaObject = ext;
    urlMessage.mediaTagName = @"ISOFTEN_TAG_JUMP_SHOWRANK";
    
    //完成发送对象实例
    urlMessage.mediaObject = ext;
    sendReq.message = urlMessage;
    
    //发送请求
     [WXApi sendReq:sendReq completion:^(BOOL success) {
         NSLog(@"SHYWeChatShareManager 唤起微信:%@", success ? @"成功" : @"失败");
         
     }];
}

@end

