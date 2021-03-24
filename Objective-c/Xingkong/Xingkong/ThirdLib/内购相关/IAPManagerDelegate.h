//
//  IAPManagerDelegate.h
//  CatPregnent2
//
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IAPManagerDelegate <NSObject>
@required
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions;
@end

NS_ASSUME_NONNULL_END
