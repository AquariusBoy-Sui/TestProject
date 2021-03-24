//
//  AFHTTPTools.m
//  CatPregnent2
//
//  Created by ji long on 2020/7/16.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "AFHTTPTools.h"
#import "AFNetworking-umbrella.h"

@implementation AFHTTPTools

+(nullable NSURLSessionDataTask *)Post:(NSString*)url
parameters:(nullable id)parameters
  progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
   success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
   failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain",@"text/plain", nil];
    return [manager POST:url
       parameters:parameters
          headers:nil
         progress:uploadProgress
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                success(task,responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task,error);
          }
     ];
}

@end
