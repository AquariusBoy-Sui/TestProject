//
//  PurchaseQueryProductState.h
//  CatPregnent2
//  查询苹果服务器商品列表状态
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PurchaseState.h"
NS_ASSUME_NONNULL_BEGIN

@interface PurchaseQueryProductState : PurchaseState<SKProductsRequestDelegate>


-(void)runState:(NSObject* _Nullable)data;       //运行状态

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response API_AVAILABLE(ios(3.0), macos(10.7), watchos(6.2));
@end

NS_ASSUME_NONNULL_END
