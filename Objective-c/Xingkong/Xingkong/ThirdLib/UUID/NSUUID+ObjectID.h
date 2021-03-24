//
//  NSUUID+ObjectID.h
//  CatPregnent2
//  根据UUID生成mongoID中 objectID
//  Created by jerry  on 2019/12/1.
//  Copyright © 2019 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUUID(ObjectID)
+(NSString*)uuidObjectID;      //获取类似MangoDBID
+(NSString*)deviceUUID;         //获取设备ID
+(NSString*)buildCatPregentID;  //生成猫孕编号
@end

NS_ASSUME_NONNULL_END
