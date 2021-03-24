//
//  PayReceiptValidator.swift
//  ClockPro
//
//  Created by MrSui on 2020/10/21.
//
import UIKit
import Alamofire
import SwiftyStoreKit

class PayReceiptValidator: ReceiptValidator {
    func validate(receiptData: Data, completion: @escaping (VerifyReceiptResult) -> Void) {
      
        
    }
    
    
    public enum VerifyReceiptURLType: String {
        // 服务器地址这里使用了 Python 建立的服务器
        // 线上环境
        // ···case productionAppSotre = "https://sandbox.itunes.apple.com/verifyReceipt"
        case production = "http://192.168.1.157:5000/"
        // 测试环境
        case sandbox = "https://sandbox.itunes.apple.com/verifyReceipt"
    }
    
    public init(service: VerifyReceiptURLType = .production) {
        self.service = service
    }
    
    private let service: VerifyReceiptURLType
    

}
