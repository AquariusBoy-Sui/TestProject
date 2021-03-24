//
//  IAPTools.h
//  CatPregnent2
//  苹果支付工具管理
//  Created by ji long on 2020/3/13.
//  Copyright © 2020 Aiyougame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "IAPManagerDelegate.h"
#import "ProductDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@class PayTransactionModel;


typedef void(^PurchaseBlock)(int stateCode,NSString* msg);   //购买回调


@interface IAPManager : NSObject
+(id) instance;
@property (nonatomic, strong) NSMutableArray<NSDictionary*>* map_localProducts;  //本地产品字典
@property (nonatomic, strong) ProductDataModel* curr_ProductDataModel;              //本地产品模型
@property (nonatomic, weak) id<IAPManagerDelegate> delegate;                     //代理

-(void)addObserver;                                                              //初始化监听
-(void)payPurchase:(NSString *)productID withBlck:(PurchaseBlock)block;          //购买产品
-(void)resumePurchaseRequest:(PurchaseBlock)blcok;                               //恢复订阅

-(void)readProductDataModel;                                                     //读取产品数据
@end

NS_ASSUME_NONNULL_END
