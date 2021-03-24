//
//  NSDictionary+JSON.h
//  CatPregnent2
//
//  Created by ji long on 2020/1/3.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary(JSON)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

-(NSString*)toJsonString;

- (nullable id)objectForKeyNSNULL:(NSString *)key;  //获取对象，NSNULL不崩溃
@end

@interface NSMutableDictionary(JSON)

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

-(NSString*)toJsonString;

@end

NS_ASSUME_NONNULL_END
