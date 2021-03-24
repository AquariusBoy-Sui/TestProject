//
//  PurchasePayTransactionState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchasePayTransactionState.h"
#import "PayTransactionModel.h"
#import "PayTransactionBLL.h"

@implementation PurchasePayTransactionState

/**
 运行状态
 */
-(void)runState:(NSObject* _Nullable)data{
    NSLog(@"当前状态4:%@",@"PurchasePayTransactionState");
    if(![data isKindOfClass:PayTransactionModel.class])
    {
        [self outputMessage:-1 msg:@"状态类型不对"];
        return;
    }
    [self outputMessage:3 msg:@"保存交易订单..."];
    PayTransactionModel* pm=(PayTransactionModel*)data;
    PayTransactionBLL *ptBLL=[PayTransactionBLL instance];
    
   
    //保存到服务器中
    [ptBLL addPayOrder:pm withBlock:^(int errorCode, NSString * _Nonnull msg,PayTransactionModel* payTran) {
        
        if(errorCode==1)
        {
            if(self.nextState)
            {
                [self.nextState runState:pm];
            }else
            {
                [self outputMessage:1 msg:@"保存交易订单成功"];
            }
        }else{
            [self outputMessage:errorCode msg:msg];   //流程状态失败
        }
    }];
    
}


@end
