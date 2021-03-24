//
//  IAPTools.m
//  CatPregnent2
//
//  Created by ji long on 2020/3/13.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "IAPManager.h"
#import "AFNetworking-umbrella.h"
#import <StoreKit/StoreKit.h>
//提交服务器传送信息使用,项目
#import "PersonBLL.h"
#import "TransactionEntity+CoreDataClass.h"
#import "CoreDataBLL.h"
#import "NSUUID+ObjectID.h"
#import "PayTransactionBLL.h"
#import "PayTransactionModel.h"
#import "AFHTTPTools.h"

#import "PurchaseState.h"
#import "PurchaseQueryProductState.h"
#import "PurchaseBuyState.h"
#import "PurchaseTransactionState.h"
#import "PurchasePayTransactionState.h"
#import "PurchasePersonInfoState.h"
#import "PurchaseResumeState.h"
#import "VersionBLL.h"

//In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
//In the real environment, use https://buy.itunes.apple.com/verifyReceipt
// Create a POST request with the receipt data.
#if defined(DEBUG)||defined(_DEBUG)
#define    kAppleUrl   @"https://sandbox.itunes.apple.com/verifyReceipt"
#else
#define    kAppleUrl   @"https://buy.itunes.apple.com/verifyReceipt"
#endif

//记录订单的服务器
#define    kServerUrl   @"https://catapp.ayougame.com/CatPregnentService"


@interface IAPManager ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSString*,SKProduct*> *map_Products;        //产品编号与产品对象
@property (nonatomic, strong) PurchaseState *curr_purchate;                                  //当前支付状态
@property (nonatomic, strong) NSMutableArray<PurchaseState*> *stateCache;                     //缓冲状态


@end

static IAPManager *shareIAPManager=nil;

@implementation IAPManager

+(id) instance{
    if(shareIAPManager ==nil)
    {
        shareIAPManager=[[super alloc] init];
        shareIAPManager.map_localProducts=[NSMutableArray new];
        shareIAPManager.map_Products=[NSMutableDictionary new];

    }
    return shareIAPManager;
}

/**
 初始化监听，负责自动购买业务逻辑
 */
- (void)addObserver{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

/**
 更新本地产品信息
 */
-(void)updateLocalProductInfo:(SKProduct *)pro
{
    for(int i=0; i< self.map_localProducts.count; i++)
    {
        NSDictionary *proDict=[self.map_localProducts objectAtIndex:i];
        NSString* productID= [proDict valueForKey:@"goods_ID"];
        if([productID isEqualToString:pro.productIdentifier])
        {
        }
    }
}


//#pragma mark - SKProductsRequestDelegate 在Appstore上购买的用户
//- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
//
//}

#pragma mark - SKPaymentTransactionObserver 在Appstore上购买的用户
/**
 测试
 修改下面的链接地址，然后在safari浏览器打开，就可以测试从App Store发起购买了。其中链接中的bundleId修改为你自己应用的bundleId，比如com.hudongdong.blog，productId修改为你创建的商品的id
 
 itms-services://?action=purchaseIntent&bundleId=com.gugesoft.gamecenter.catbirthday&productIdentifier=AllYear
 
 如果返回值为true，那就是在打开app时直接调用购买确认的弹窗，让用户输入密码或者指纹等确认购买
 如果返回值为false，那就是只打开app，但是并不会直接调用购买的弹窗，相当于只是给了你一个product的订单，你可以后续自己处理这个订单
 */
- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product
{
    NSLog(@"product info");
    NSLog(@"SKProduct 描述信息%@", [product description]);
    NSLog(@"产品标题 %@" , product.localizedTitle);
    NSLog(@"产品描述信息: %@" , product.localizedDescription);
    NSLog(@"价格: %@" , product.price);
    NSLog(@"Product id: %@" , product.productIdentifier);
    return true;
}

#pragma mark - SKPaymentTransactionObserver 监听购买结果
#pragma mark -
/**
 监听购买结果
 */
- (void)paymentQueue:(nonnull SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions {
    
    //如果有代理,直接发送队列到代理中
    if(self.delegate)
    {
        [self.delegate paymentQueue:queue updatedTransactions:transactions];
        return;
    }
    NSLog(@"---------------------------------IAPManager paymentQueue---------------------------------------------------");
    for(SKPaymentTransaction *tran in transactions){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                //[self completeTransaction:tran];
                [self createTransactionState:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品:%@",tran);
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];  //关闭交易
                break;
            case SKPaymentTransactionStateFailed:
            {
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];  //关闭交易
                NSLog(@"交易失败:%@ error:%@",tran.payment.applicationUsername,tran.error);
            }break;

            default:
                break;
        }
    }

}

/**
 创建交易状态
 */
-(void)createTransactionState:(SKPaymentTransaction*)trans{
    self.curr_purchate=[PurchaseTransactionState new];  //交易完成
    [self.curr_purchate addNextState:[PurchasePayTransactionState new]];  //交易状态保存
    [self.curr_purchate addNextState:[PurchasePersonInfoState new]];  //交易用户状态
    [self.curr_purchate runState:trans];
}




/**
 购买产品
 */
-(void)payPurchase:(NSString *)productID withBlck:(PurchaseBlock)block{
    if (![SKPaymentQueue canMakePayments]) {
        block(-1,@"请开启手机支付,然后在尝试!");
        return;
    }
    
    //块变量
    PurchaseStateBlock stateBlock=^(int stateCode,NSString* msg){
        block(stateCode,msg);
    };
    
    //开始以查询产品为状态
    PurchaseQueryProductState *purchateQuery=[PurchaseQueryProductState new];            //查询
    purchateQuery.productIdentifier=productID;
    purchateQuery.stateCallback = stateBlock;
    purchateQuery.productDataModel=self.curr_ProductDataModel;              //设置产品数据模型
    
    [purchateQuery addNextState:[PurchaseBuyState new]];                     //购买
    [purchateQuery addNextState:[PurchaseTransactionState new]];             //交易完成
    [purchateQuery addNextState:[PurchasePayTransactionState new]];          //交易状态保存
    [purchateQuery addNextState:[PurchasePersonInfoState new]];              //交易用户状态
    
    self.curr_purchate=purchateQuery;
    [self.curr_purchate runState:productID];

}


/**
 恢复订阅
 */
-(void)resumePurchaseRequest:(PurchaseBlock)blcok{

    //块变量
    PurchaseStateBlock stateBlock=^(int stateCode,NSString* msg){
        blcok(stateCode,msg);
    };
    
    //开始以查询产品为状态
    self.curr_purchate=[PurchaseResumeState new];            //恢复
    self.curr_purchate.stateCallback = stateBlock;           //状态结果回调
    [self.curr_purchate addNextState:[PurchaseTransactionState new]];       //交易完成
    [self.curr_purchate addNextState:[PurchasePayTransactionState new]];    //交易状态保存
    [self.curr_purchate addNextState:[PurchasePersonInfoState new]];        //交易用户状态
    [self.curr_purchate runState:nil];
    
}

/**
 读取全部产品数据
 */
-(void)readProductDataModel{
    @try {
        NSMutableDictionary* mutalb=[[NSMutableDictionary alloc] init];
        [mutalb setValue:@"query" forKey:@"opt"];
        [mutalb setValue:@"temp" forKey:@"data"];
        [mutalb setValue:@"ConfigModel" forKey:@"doc"];
        [BKBLL commonHttpRequestWithParameters:mutalb class:ResponseModel.class POST:@"CatPregnentService" resultBlock:^(ResponseModel *model, NSError *error) {
            if(model.code==1)
            {
                NSLog(@"model:%@",model);
                self.curr_ProductDataModel=[ProductDataModel new];
                NSArray *data=(NSArray*)model.result;
                if(data && data.count > 0)
                {
                    [self.curr_ProductDataModel setDictionary:[data firstObject]];
                    [self queryAllSKProduct:self.curr_ProductDataModel];
                }
                
            }
    
        }];
    }
    @catch (NSException *exception) {
        
    }
}

/**
 查询全部产品模型
 */
-(void)queryAllSKProduct:(ProductDataModel*)pdm{
    
    NSSet *set = [NSSet setWithArray:pdm.productCatPregnentIDs];
    if(kPROFESSIONALPOWER==1)   //专业版
    {
        set= [NSSet setWithArray:pdm.productCatPregnentIDPowers];
    }
    
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
    
}

#pragma mark -
/**
 请求产品数据回调
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *products = response.products;
    
    if(!self.curr_ProductDataModel)
    {
        return;
    }
    NSArray *productNames=self.curr_ProductDataModel.productCatPregnentIDs;
    if(kPROFESSIONALPOWER==1)   //专业版
    {
        productNames=self.curr_ProductDataModel.productCatPregnentIDPowers;
    }
    self.curr_ProductDataModel.cacheProducts=[NSMutableDictionary<NSString*,SKProduct*> new];
    
    for (NSString *pName in productNames) {
        for (SKProduct *pro in products) {
            if([pro.productIdentifier isEqualToString:pName]){
                [self.curr_ProductDataModel.cacheProducts setObject:pro forKey:pName];
            }
        }
    }
    
    
}

@end
