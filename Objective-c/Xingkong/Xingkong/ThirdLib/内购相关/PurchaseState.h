//
//  PurchaseState.h
//  CatPregnent2
//  购买状态基类
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "ProductDataModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^PurchaseStateBlock)(int stateCode,NSString* msg);

@interface PurchaseState : NSObject

@property (nonatomic, strong,readonly) NSString* stateName;         //状态名称
@property (nonatomic, strong) NSString* productIdentifier;          //产品编号
@property (nonatomic, strong) ProductDataModel* productDataModel;   //产品数据模型
@property (nonatomic, strong) PurchaseStateBlock stateCallback;     //状态块回调
@property (nonatomic, strong) PurchaseState* nextState;             //下一个状态

-(void)runState:(NSObject* _Nullable)data;       //运行状态

-(void)outputMessage:(int)stateCode msg:(NSString*) msg;  //输出状态及消息

-(void)addNextState:(PurchaseState*)nextState;
@end

NS_ASSUME_NONNULL_END
