//
//  ImageManager.m
//  CachesImageView
//
//  Created by jilong on 2020/4/5.
//  Copyright © 2020 jilong. All rights reserved.
//

#import "ImageManager.h"
#import "UIImage+Caches.h"
#import "BKBLL.h"
#import "ResponseModel.h"
#import "AFAppDotNetAPIClient.h"


//图片服务器地址
#import "NetworkHeader.h"
#import "UIImage+Base64.h"

#define kImageServerAPI @"ImageServices"
#define kImageKeyCachesDictUserDefault @"ImageKeyCachesDict_v_202"

@interface ImageManager()
@property (strong, nonatomic) NSMutableDictionary *imageKeyCachesDict;  //图片缓存字典,负责保存未提交服务器的数据
@property (strong, nonatomic) dispatch_queue_t serialUploadQueue;       //穿行提交队列
@property (strong, nonatomic) dispatch_semaphore_t semaphoreImageUpdata;//单次提交信号量

@end


@implementation ImageManager
static ImageManager* shareImageManager;

//提交信号量,同时提交串行队列
static dispatch_semaphore_t semaphoreImageUpdata;

+(ImageManager*)shareImageManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareImageManager=[ImageManager new];
        shareImageManager.semaphoreImageUpdata = dispatch_semaphore_create(1);  //单次提交信号量
        shareImageManager.serialUploadQueue= dispatch_queue_create("com.catPreganet.imageUpload", DISPATCH_QUEUE_SERIAL);
        
        NSDictionary *dict=[[NSUserDefaults standardUserDefaults] objectForKey:kImageKeyCachesDictUserDefault];
        shareImageManager.imageKeyCachesDict =[NSMutableDictionary dictionaryWithDictionary:dict];
        if(!shareImageManager.imageKeyCachesDict){
            shareImageManager.imageKeyCachesDict=[NSMutableDictionary new];
        }
        
    });
    return shareImageManager;
}

//提交服务器图片指定名称,必须有accessibilityIdentifier 设置name;返回URL路径
-(void)updateImage:(UIImage*)imgs withBlock:(FunCall(int state,NSString* msg,NSString* url))block
{
    //检查网络是否通畅
//    if(![[CoreDataBLL instance] networkAccess])
//    {
//        block(-1,@"网络连接失败,请检查网络状态!",nil);
//        return;
//    }
    
    //是否登录
    PersonBLL *pb=[PersonBLL instance];
    if(![pb isSign]){
        block(-2,@"请先登录后,再保存猫咪数据!",nil);
        return;
    }
    
    NSLog(@"imgs.accessibilityIdentifier:%@",imgs.accessibilityIdentifier);
    NSAssert(imgs.accessibilityIdentifier,@"image.accessibilityIdentifier not null!");
    NSString *imageName=imgs.accessibilityIdentifier;
    //保存本地
    [imgs saveCachesImage:imageName];
    
    NSString *imageBase64=[UIImage encodeToBase64String:imgs];
    NSMutableDictionary* mutalb=[[NSMutableDictionary alloc] init];
    [mutalb setValue:imageName forKey:@"imagename"];
    [mutalb setValue:@"upload" forKey:@"opt"];
    [mutalb setValue:imageBase64 forKey:@"data"];
    
    [BKBLL commonHttpRequestWithParameters:mutalb class:ResponseModel.class POST:kImageServerAPI resultBlock:^(ResponseModel *model, NSError * _Nonnull error){
        
        if(model && model.code==1)
        {
            //返回图片服务器地址
            NSString *imageUrl=[NSString stringWithFormat:@"%@images/%@",AFAppDotNetAPIBaseURLString,imageName];
            block(1,nil,imageUrl);
        }else{
            block(model.code,model.msg,nil);
        }
        
    }];

}

/**
保存图片,必须有accessibilityIdentifier;返回URL路径
 */
-(NSString*)saveImage:(UIImage*)imgs{
    //img.accessibilityIdentifier;
    //return ;
    NSLog(@"imgs.accessibilityIdentifier:%@",imgs.accessibilityIdentifier);
    NSAssert(imgs.accessibilityIdentifier,@"image.accessibilityIdentifier not null!");
    NSString *imageName=imgs.accessibilityIdentifier;
    //保存本地
    [imgs saveCachesImage:imageName];
    
    //发送到服务端图片
    [self postServerImage:imgs];
    
    //返回图片服务器地址
    NSString *imageUrl=[NSString stringWithFormat:@"%@images/%@",AFAppDotNetAPIBaseURLString,imageName];
    return imageUrl;
}


/**
 发送图片到服务器
 */
-(void)postServerImage:(UIImage*)image{
    //多线程执行
    dispatch_async(self.serialUploadQueue, ^{
        //等待信号量释放
        dispatch_semaphore_wait(self.semaphoreImageUpdata, DISPATCH_TIME_FOREVER);
        [self post:image];
    });
}

/**
 post 服务器, 返回后不做修改
 */
-(void)post:(UIImage*)image{
    
    NSAssert(image.accessibilityIdentifier,@"image.accessibilityIdentifier not null!");
    
    NSString *imageBase64=[UIImage encodeToBase64String:image];
    NSString *imageName=image.accessibilityIdentifier;
    
    NSMutableDictionary* mutalb=[[NSMutableDictionary alloc] init];
    [mutalb setValue:imageName forKey:@"imagename"];
    [mutalb setValue:@"upload" forKey:@"opt"];
    [mutalb setValue:imageBase64 forKey:@"data"];
    [BKBLL commonHttpRequestWithParameters:mutalb class:ResponseModel.class POST:kImageServerAPI resultBlock:^(ResponseModel *model, NSError * _Nonnull error){
        
        dispatch_semaphore_signal(self.semaphoreImageUpdata);
        
        //提交图片失败,等待下段时间运行
        if(model==nil || model.code!=1){
            [self.imageKeyCachesDict setValue:imageName  forKey:imageName];
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setValue:self.imageKeyCachesDict forKey:kImageKeyCachesDictUserDefault];
            [defaults synchronize];
        }else{
            //如果存在缓冲字典
            if([self.imageKeyCachesDict valueForKey:image.accessibilityIdentifier])
            {
                [self.imageKeyCachesDict removeObjectForKey:image.accessibilityIdentifier];
                NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
                [defaults setValue:self.imageKeyCachesDict forKey:kImageKeyCachesDictUserDefault];
                [defaults synchronize];
            }
            NSLog(@"model%@",model);
        }
    }];
    
}

/**
 启动恢复提交数据 TODO:删除时候有bug
 */
-(void)resume{

    if([self.imageKeyCachesDict count] == 0){
        return;
    }
    //恢复为提交的图片
    [self.imageKeyCachesDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *imgeKey=key;
        //获取Library/Caches 文件夹
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //计算出全路径
        NSString *filePath = [cachesPath stringByAppendingPathComponent:imgeKey];
        NSLog(@"filePath:%@",filePath);
        //取出图片
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        UIImage *image=[UIImage imageWithData:data];
        [image setAccessibilityIdentifier:imgeKey];
        //恢复提交图片
        NSLog(@"恢复提交图片 resume---------:%@",imgeKey);
        if(image==nil)
        {
            [self.imageKeyCachesDict removeObjectForKey:imgeKey];
        }else{
            [self postServerImage:image];
        }
        
        
    }];
}

/**
 删除本地沙盒缓存照片,网络存储桶由服务端接收到删除的记录后，服务器管理删除
 */
-(void)removeImage:(NSString*)deleImage{
    //删除本地沙盒缓存照片
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    //获取文件名(也就是取得路径的最后一个路径)
    NSString *fileName = [deleImage lastPathComponent];
    
    //计算出全路径
    NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL fileExits = [manager fileExistsAtPath:filePath];
    if (fileExits) {
        [manager removeItemAtPath:filePath error:nil];
    }
}


@end
