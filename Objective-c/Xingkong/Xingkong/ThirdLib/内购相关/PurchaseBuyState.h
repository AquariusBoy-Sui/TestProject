//
//  PurchaseBuyState.h
//  CatPregnent2
//  购买请求状态
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PurchaseState.h"
#import "IAPManagerDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface PurchaseBuyState : PurchaseState<IAPManagerDelegate>


-(void)runState:(NSObject* _Nullable)data;       //运行状态

// Sent when the transaction array has changed (additions or state changes).  Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions;

@end

NS_ASSUME_NONNULL_END
