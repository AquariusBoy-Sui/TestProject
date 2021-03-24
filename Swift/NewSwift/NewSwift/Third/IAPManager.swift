//
//  IAPManager.swift
//  SuiDemo
//
//  Created by MrSui on 2020/11/3.
//

import Foundation
import StoreKit
import Combine


//--------------购买回调-------------

typealias IAPResultBlock = (_ isComplute:Bool)->Void // 购买结果回调
typealias IAPRestoreBlock = (_ isComplute:Bool)->Void // 恢复购买结果回调

class IAPManager: NSObject {
    
    
    let purchasePublisher = PassthroughSubject<(String, Bool), Never>()
    
    static let shared = IAPManager()
    var totalRestoredPurchases = 0
    private override init() {
        super.init()
    }
    
    
    var iapResultBlock:IAPResultBlock?
    var iapRestoreBlock:IAPRestoreBlock?
    
    // 产品ID 数组
    func returnProductIDs() -> Set<String> {
        return ["clock1"]
    }
    // 是否可以购买
    func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    // 根据产品ID 数组 请求产品列表
    func getProducts() {
        let productIDs = Set(returnProductIDs())
        let request = SKProductsRequest(productIdentifiers: Set(productIDs))
        request.delegate = self
        request.start()
    }
    // 弹出错误信息
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("-------弹出错误信息----------",error)
        purchasePublisher.send(("Purchase request failed ",true))
    }
    // 反馈信息结束
    func requestDidFinish(_ request: SKRequest) {
        print("----------反馈信息结束--------------")
    }
    // 获取价格 和 币种符合
    func getPriceFormatted(for product: SKProduct) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)!
    }
    // 恢复商品购买
    func restorePurchases(clock:IAPRestoreBlock?) {
        totalRestoredPurchases = 0
        SKPaymentQueue.default().restoreCompletedTransactions()
        self.iapRestoreBlock = clock
        if(self.iapRestoreBlock != nil){
            // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
            self.iapRestoreBlock!(true)
        }
    }
    // 恢复购买成功
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if totalRestoredPurchases != 0 {
            purchasePublisher.send(("IAP: Purchases successfull restored!",true))
            print("IAP: Purchases successfull restored!",true)
        } else {
            purchasePublisher.send(("IAP: No purchases to restore!",true))
            print("IAP: No purchases to restore!",true)
        }
        if(self.iapRestoreBlock != nil){
            // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
            self.iapRestoreBlock!(false)
        }
    }
    // 恢复购买错误
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        if let error = error as? SKError {
            if error.code != .paymentCancelled {
                purchasePublisher.send(("IAP Restore Error: " + error.localizedDescription,false))
                print("IAP Restore Error: " + error.localizedDescription,false)
            } else {
                purchasePublisher.send(("IAP Error: " + error.localizedDescription,false))
                print("IAP Error: " + error.localizedDescription,false)
            }
        }
    }
}

extension IAPManager: SKPaymentTransactionObserver {
    
    //产品购买
    public  func purchaseProduct(ProductID : String ,clock:IAPResultBlock?){
        
        if  ProductsDB.shared.products.count == 0 {
            return
        }
        let product = ProductsDB.shared.queryByProductID(ProductID: ProductID)!
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
        self.iapResultBlock = clock
        
        if(self.iapResultBlock != nil){
            // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
            self.iapResultBlock!(true)
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        transactions.forEach { (transaction) in
            switch transaction.transactionState {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                purchasePublisher.send(("Purchased ",true))
                print("购买完成 : \(totalRestoredPurchases)")
                if(self.iapResultBlock != nil){
                    // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
                    self.iapResultBlock!(false)
                }
            case .restored:
                totalRestoredPurchases += 1
                SKPaymentQueue.default().finishTransaction(transaction)
                purchasePublisher.send(("Restored ",true))
                print("购买数量 : \(totalRestoredPurchases)")
            case .failed:
                if let error = transaction.error as? SKError {
                    purchasePublisher.send(("Payment Error \(error.code) ",false))
                    print("购买失败 \(error.code)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
                
                if(self.iapResultBlock != nil){
                    // 这里会回调A类里面的getValueClosure方法,这里的参数就是getValueClosure方法的参数
                    self.iapResultBlock!(false)
                }
            case .deferred:
                print("Ask Mom ...")
                purchasePublisher.send(("Payment Diferred ",false))
            case .purchasing:
                print("购买中")
                purchasePublisher.send(("Payment in Process ",false))
            default:
                print("购买 default")
            }
        }
    }
    
    //    启动内购服务
    func startObserving() {
        SKPaymentQueue.default().add(self)
        getProducts()
    }
    //    停止内购服务
    func stopObserving() {
        SKPaymentQueue.default().remove(self)
    }
    
    
}
extension IAPManager: SKProductsRequestDelegate, SKRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let badProducts = response.invalidProductIdentifiers
        let goodProducts = response.products
        if goodProducts.count > 0 {
            ProductsDB.shared.products = response.products
            
            for product in ProductsDB.shared.products {
                
                print("SKProduct",product.description)
                print("产品 ID :" ,product.productIdentifier)
                print("产品标题 :",product.localizedTitle);
                print("产品描述 :" ,product.localizedDescription)
                print("产品价格 :" ,getPriceFormatted(for: product))
            }
        }
        print("无效产品 products ",badProducts)
    }
}


final class ProductsDB: ObservableObject, Identifiable {
    static let shared = ProductsDB()
    // 产品列表
    var products:[SKProduct] = []
    {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    // 产品购买
    func queryByProductID(ProductID:String) -> SKProduct?{
        return products.first { item -> Bool in
            return item.productIdentifier == ProductID
        }
    }
    
}



