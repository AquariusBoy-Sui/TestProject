//
//  NSString+AES.h
//  CatPregnent2
//
//  Created by ji long on 2019/12/31.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES)

+(NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key;
+(NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
