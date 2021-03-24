//
//  PurchaseTransactionState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchaseTransactionState.h"
#import "VersionBLL.h"
#import "AFHTTPTools.h"
#import "PayTransactionModel.h"

#if defined(DEBUG)||defined(_DEBUG)
#define    kAppleUrl   @"https://sandbox.itunes.apple.com/verifyReceipt"
#else
#define    kAppleUrl   @"https://buy.itunes.apple.com/verifyReceipt"
#endif

@implementation PurchaseTransactionState


/**
 运行状态
 */
-(void)runState:(NSObject* _Nullable)data{
    NSLog(@"当前状态3:%@",@"PurchaseTransactionState");

    if(![data isKindOfClass:SKPaymentTransaction.class])
    {
        [self outputMessage:-1 msg:@"交易订单格式不对"];
        return;
    }
    
    [self outputMessage:3 msg:@"验证交易订单..."];
    SKPaymentTransaction* product=(SKPaymentTransaction*)data;
    [self verifyTransaction:product];
}


/**
 验证支付模型数据,核心代码
 */
-(void)verifyTransaction:(SKPaymentTransaction *)transaction
{
    //判断网络是否通畅
    if(![[CoreDataBLL instance] networkAccess])
    {
        [self outputMessage:-1 msg:@"网络连接失败,请检查网络状态!"];
        return;
    }
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:recepitURL];
    self.latestReceipt=[receipt base64EncodedStringWithOptions:0];                    //获取最新票据
    NSDictionary *requestContents = @{
        @"receipt-data": self.latestReceipt,
        @"password": kIapKey          //网站申请,初始化传入
    };
    
    //发送苹果后台服务器,验证订单请求
    [AFHTTPTools Post:kAppleUrl parameters:requestContents progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self outputMessage:3 msg:@"处理交易订单完成"];
        
        //结束订单交易
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        
        //创建购买交易订单
        PayTransactionModel *payTrans=[PayTransactionModel new];
        payTrans.entityID=transaction.transactionIdentifier;                    //订单ID订单编号
        payTrans.applicationUsername=transaction.payment.applicationUsername;   //应用程序用户名
        payTrans.transactionDate=transaction.transactionDate;                   //订单日期
        payTrans.productIdentifier=transaction.payment.productIdentifier;       //产品名称
        payTrans.status=[responseObject[@"status"] integerValue];               //状态 0:成功验证 1:失败
        
        //票据基本信息
        NSDictionary *receipt=responseObject[@"receipt"];
        if(receipt)
        {
            payTrans.bundleId=[receipt objectForKey:@"bundle_id"];
            payTrans.applicationVersion=[receipt objectForKey:@"application_version"];
        }
        //最新收据信息
        id latest_receipt_infos=responseObject[@"latest_receipt_info"];
        payTrans.latestReceiptInfos=latest_receipt_infos;
        //数组排序
        payTrans.latestReceiptInfos=[self sortExpiresDateMs:payTrans.latestReceiptInfos];
        
        //最新票据
        NSDictionary *lastetReceipt=payTrans.latestReceiptInfos[0];
        
        //订单ID
        payTrans.transactionId=[lastetReceipt objectForKey:@"transaction_id"];
        
        //查找票据中过期日期
        payTrans.transactionExpireDate=[self findTransactionExpireDate:lastetReceipt];
        
        //是否促销
        payTrans.isTrialPeriod= [[lastetReceipt objectForKey:@"is_trial_period"] integerValue];
        payTrans.isInIntroOfferPeriod= [[lastetReceipt objectForKey:@"is_in_intro_offer_period"] integerValue];
        
        NSString* purchase_date=[lastetReceipt objectForKey:@"purchase_date"];
        NSString* expires_date=[lastetReceipt objectForKey:@"expires_date"];
        //会员周期
        payTrans.remarks=[NSString stringWithFormat:@"会员周期:%@ - %@",purchase_date,expires_date];
        
        if([payTrans.transactionId isEqualToString:payTrans.entityID])
        {
            payTrans.payType=@"订阅";
        }else{
            payTrans.payType=@"恢复";
        }
        
        
        //控制大小，保留最新的20条记录
        unsigned long minLength= MIN(20, payTrans.latestReceiptInfos.count);
        NSRange rangeA = NSMakeRange(0,minLength);
        payTrans.latestReceiptInfos= [payTrans.latestReceiptInfos subarrayWithRange:rangeA];
        
        //block(1,nil,payTrans);
        if(self.nextState)
        {
            [self.nextState runState:payTrans];
        }
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self outputMessage:-2 msg:@"网络访问错误,恢复失败,请检查网络后再试！"];
    }];
}

/**
 根据过期时间排序,降序排列
 */
-(NSArray*)sortExpiresDateMs:(NSArray* )latestReceiptInfos{
    NSArray *tempArr = [latestReceiptInfos sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
       if([[obj1 objectForKey:@"expires_date_ms"] longLongValue] < [[obj2 objectForKey:@"expires_date_ms"] longLongValue]){
            return NSOrderedDescending;
       }
       if([[obj1 objectForKey:@"expires_date_ms"] longLongValue] > [[obj2 objectForKey:@"expires_date_ms"] longLongValue]){
            return NSOrderedAscending;
       }
       return NSOrderedSame;
     }];
    return tempArr;
}

/**
 打印数组名称
 */
-(void)print:(NSArray* )latestReceiptInfos
{
    for (int i=0; i< [latestReceiptInfos count]; i++) {
        NSDictionary *receiptInfos=[latestReceiptInfos objectAtIndex:i];
        //过期日期
        NSString *expiresDateStr= [receiptInfos objectForKey:@"expires_date"];
        NSLog(@"%d:%@",i,expiresDateStr);
    }
}

/**
 获取latestReceiptInfo中的最晚日期
 */
-(NSDate*)findTransactionExpireDate:(NSDictionary* )receiptInfos
{
    //过期日期
    NSString *expiresDateStr= [receiptInfos objectForKey:@"expires_date"];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss VV";
    NSDate* transactionExpireDate=[dateFormatter dateFromString:expiresDateStr];
    return transactionExpireDate;
    
}


@end
