//
//  NSDictionary+JSON.m
//  CatPregnent2
//
//  Created by ji long on 2020/1/3.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "NSMutableDictionary+JSON.h"

@implementation NSDictionary(JSON)


+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/**
 防止NSNull崩溃
 */
- (nullable id)objectForKeyNSNULL:(NSString *)key
{
    id obj = [self objectForKey:key];
    if([obj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return obj;
}

-(NSString*)toJsonString{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* strJson= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if(parseError) {
        NSLog(@"json解析失败：%@",parseError);
        return nil;
    }
    
    return strJson;
}

@end

@implementation NSMutableDictionary(JSON)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


-(NSString*)toJsonString{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* strJson= [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if(parseError) {
        NSLog(@"json解析失败：%@",parseError);
        return nil;
    }
    
    return strJson;
}
@end
