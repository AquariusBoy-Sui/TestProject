//
//  PurchaseResumeState.h
//  CatPregnent2
//  恢复状态
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseState.h"
#import "IAPManagerDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface PurchaseResumeState : PurchaseState<IAPManagerDelegate>

-(void)runState:(NSObject* _Nullable)data;       //运行状态

//购买恢复回调
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions;

@end

NS_ASSUME_NONNULL_END
