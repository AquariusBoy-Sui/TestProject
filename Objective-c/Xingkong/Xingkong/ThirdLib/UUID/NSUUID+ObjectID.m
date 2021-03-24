//
//  NSUUID+ObjectID.m
//  CatPregnent2
//
//  Created by jerry  on 2019/12/1.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import "NSUUID+ObjectID.h"

@implementation NSUUID(ObjectID)

+(NSString*)uuidObjectID
{
    NSString *replacedStr = [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-"withString:@""];
    NSString *uuid = [replacedStr substringToIndex:16];
    NSDate *datenow = [NSDate date];
    NSString *timeSp3 = [NSString stringWithFormat:@"%x%@", (unsigned int)[datenow timeIntervalSince1970],uuid];
    return timeSp3;
}


+(NSString*)deviceUUID
{
    return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}

/**
 创建猫孕编号
 */
+(NSString*)buildCatPregentID{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyMMddHHmmsss";
    return [dateFormatter stringFromDate:[NSDate date]];
}


@end
