//
//  PurchaseBuyState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchaseBuyState.h"
#import "IAPManager.h"

@implementation PurchaseBuyState


/**
 运行状态
 */
-(void)runState:(NSObject* _Nullable)data{
    NSLog(@"当前状态2:%@",@"PurchaseBuyState");
    if(![data isKindOfClass:SKProduct.class])
    {
        [self outputMessage:-1 msg:@"状态参数不对"];
        return;
    }
    
    IAPManager *iap =[IAPManager instance];
    iap.delegate=self;
    
    SKProduct* product=(SKProduct*)data;
    [self buyProduct:product];
    [self outputMessage:3 msg:@"开始购买"];
}



/**
 购买产品
 */
-(void)buyProduct:(SKProduct *)product
{
    //(SKProduct *)product
    SKMutablePayment * payment = [SKMutablePayment paymentWithProduct: product];
    //applicationUsername 存储u服务器的订单号，这样处理掉单情况的时候 可以一一对应
    //payment.applicationUsername = self.current_OrderNO;
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [self outputMessage:3 msg:@"开始购买..."];
}

/**
 监听购买结果
 */
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    
    for(SKPaymentTransaction *tran in transactions){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                [self stateFinish];
                [self outputMessage:3 msg:@"购买完成"];
                //进入下一个状态
                if(self.nextState)
                {
                    [self.nextState runState:tran];
                }
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                [self outputMessage:2 msg:@"购买中..."];
                break;
            case SKPaymentTransactionStateRestored:
            {
                [self stateFinish];
                [self outputMessage:2 msg:@"已经购买过商品"];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];  //关闭交易
                //进入下一个状态
                if(self.nextState)
                {
                    [self.nextState runState:tran];
                }
            }break;
            case SKPaymentTransactionStateFailed:
            {
                [self stateFinish];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];  //关闭交易
                [self outputMessage:0 msg:@"取消购买"];
                NSLog(@"交易失败:%@ error:%@",tran.payment.applicationUsername,tran.error);
                
            }break;
                
            default:
                break;
        }
    }
}

-(void)stateFinish{
    IAPManager *iap =[IAPManager instance];
    iap.delegate=nil;
}

@end
