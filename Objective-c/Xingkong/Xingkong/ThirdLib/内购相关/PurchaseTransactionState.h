//
//  PurchaseTransactionState.h
//  CatPregnent2
//  购买交易完成状态,验证支付模型数据,保存订单数据
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseState.h"

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseTransactionState : PurchaseState
@property (nonatomic, copy) NSString* latestReceipt;                              //最新票据


-(void)runState:(NSObject* _Nullable)data;       //运行状态

@end

NS_ASSUME_NONNULL_END
