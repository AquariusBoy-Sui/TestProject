//
//  PurchaseQueryProductState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchaseQueryProductState.h"

@implementation PurchaseQueryProductState


-(void)runState:(NSObject* _Nullable)data{
    NSLog(@"当前状态1:%@",@"PurchaseQueryProductState");
    
    if(![data isKindOfClass:NSString.class])
    {
        [self outputMessage:-1 msg:@"产品类型不对"];
        return;
    }
    [self outputMessage:3 msg:@"读取苹果服务器商品列表..."];
    self.productIdentifier=(NSString*)data;
    
    //查看缓存数据是否存在产品
    if(self.productDataModel && self.productDataModel.cacheProducts)
    {
        SKProduct *findSKProduct= [self.productDataModel.cacheProducts objectForKey:self.productIdentifier];
        [self.nextState runState:findSKProduct];
        return;
    }
    
    [self queryProduct:self.productIdentifier];
}



/**
 请求产品列表
 */
-(void)queryProduct:(NSString*)productIdentifier
{
    self.productIdentifier=productIdentifier;
    NSArray *product = [[NSArray alloc] initWithObjects:productIdentifier, nil];
    NSSet *set = [NSSet setWithArray:product];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
    });
    
}

/**
 请求产品数据回调
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    
    [self outputMessage:3 msg:@"获取产品名称"];
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        if([pro.productIdentifier isEqualToString:self.productIdentifier]){
            requestProduct = pro;
        }
    }
    if (!requestProduct) {
        //没有需要请求的产品
        [self outputMessage:-1 msg:@"没有需要请求的产品"];
        return;
    }else{
        if(self.nextState)
        {
            [self.nextState runState:requestProduct];
        }else{
            [self outputMessage:1 msg:@"获取产品名称成功"];
        }
    }
    
}

@end
