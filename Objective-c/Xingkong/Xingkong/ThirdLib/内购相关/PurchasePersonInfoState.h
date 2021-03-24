//
//  PurchasePersonInfoState.h
//  CatPregnent2
//  保存用户信息到服务器中
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseState.h"
NS_ASSUME_NONNULL_BEGIN

@interface PurchasePersonInfoState : PurchaseState

-(void)runState:(NSObject* _Nullable)data;       //运行状态

@end

NS_ASSUME_NONNULL_END
