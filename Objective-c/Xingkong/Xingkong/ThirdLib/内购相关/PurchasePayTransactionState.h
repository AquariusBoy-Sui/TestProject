//
//  PurchasePayTransactionState.h
//  CatPregnent2
//  将交易完成数据保存到服务器中
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseState.h"

NS_ASSUME_NONNULL_BEGIN

@interface PurchasePayTransactionState : PurchaseState

-(void)runState:(NSObject* _Nullable)data;       //运行状态

@end

NS_ASSUME_NONNULL_END
