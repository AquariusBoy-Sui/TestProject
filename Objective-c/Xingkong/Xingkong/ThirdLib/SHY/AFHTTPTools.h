//
//  AFHTTPTools.h
//  CatPregnent2
//
//  Created by ji long on 2020/7/16.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPTools : NSObject

/**
 - (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
   progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
 */
+(nullable NSURLSessionDataTask *)Post:(NSString*)url
 parameters:(nullable id)parameters
   progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
