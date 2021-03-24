//
//  PurchaseResumeState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchaseResumeState.h"
#import "IAPManager.h"

@implementation PurchaseResumeState

/**
 运行状态
 */
-(void)runState:(NSObject* _Nullable)data{
    [self outputMessage:3 msg:@"恢复大概需要1分钟..."];
    IAPManager *iap =[IAPManager instance];
    iap.delegate=self;
    
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}


/**
 监听恢复结果
 */
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    IAPManager *iap =[IAPManager instance];
    iap.delegate=nil;
    //恢复交易数组
    NSMutableArray<SKPaymentTransaction*> *restoredArray=[NSMutableArray new];
    for(SKPaymentTransaction *tran in transactions){
        switch (tran.transactionState) {
            case SKPaymentTransactionStateRestored:
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];  //关闭交易
                [restoredArray addObject:tran];
                break;

            default:
                break;
        }
    }
    //如果有有恢复数据
    if(restoredArray.count > 0)
    {
        [self restoredTransaction:restoredArray];
    }
}


/**
 交易结束,当交易结束后还要去appstore上验证支付信息是否都正确,只有所有都正确后,我们就可以给用户方法我们的虚拟物品了。
 */
- (void)restoredTransaction:(NSArray<SKPaymentTransaction*> *)transactions
{
    //查找日期最大的交易单号
    SKPaymentTransaction *latestTransaction=nil;
    NSTimeInterval maxTime=0;
    for(int i=0; i< transactions.count; i++)
    {
        SKPaymentTransaction *transaction=[transactions objectAtIndex:i];
        if(transaction.transactionDate.timeIntervalSince1970 > maxTime)
        {
            latestTransaction=transaction;
            maxTime=transaction.transactionDate.timeIntervalSince1970;
        }
    }
    if(latestTransaction)
    {
        //遍历恢复回调函数
        [self outputMessage:3 msg:@"查到订单准备补单"];
        if(self.nextState)
        {
            [self.nextState runState:latestTransaction];
        }
    }else{
        [self outputMessage:-1 msg:@"恢复失败,未找到相应的订单!"];
    }
}

@end
