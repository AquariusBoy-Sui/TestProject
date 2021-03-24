//
//  PurchasePersonInfoState.m
//  CatPregnent2
//  购买会员成功信息
//  Created by ji long on 2020/8/6.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchasePersonInfoState.h"
#import "PayTransactionModel.h"
#import "PersonBLL.h"


@implementation PurchasePersonInfoState

/**
 运行状态
 */
-(void)runState:(NSObject* _Nullable)data{
    
    NSLog(@"当前状态5:%@",@"PurchaseBuyState");
    
    
    if(![data isKindOfClass:PayTransactionModel.class])
    {
        [self outputMessage:-1 msg:@"保存用户状态参数不对"];
        return;
    }
    
    [self outputMessage:3 msg:@"保存用户购买信息..."];
    
    PayTransactionModel* payTran=(PayTransactionModel*)data;
    PersonBLL *pb=[PersonBLL instance];
    
    if([pb isSign])
    {
        pb.currPerson.transactionId=payTran.transactionId;
        pb.currPerson.transactionExpireDate=payTran.transactionExpireDate;
        
        
        NSDictionary *dict = @{@"catliveQuarter":@"季度VIP",
                               @"Quarter":@"季度VIP",
                               @"catliveAllYear":@"全年VIP",
                               @"AllYear":@"全年VIP",
                               @"catliveHalfYear":@"半年VIP",
                               @"HalfYear":@"半年VIP"
                               };
        NSString* roleName= [dict objectForKey:payTran.productIdentifier];
        if(roleName)
        {
            pb.currPerson.personType=roleName;
        }else{
            pb.currPerson.personType=payTran.productIdentifier;
        }
        
        NSDate* earlier=[pb.currPerson.transactionExpireDate laterDate:[NSDate date]];
        if(earlier!=pb.currPerson.transactionExpireDate)
        {
            pb.currPerson.personType=[NSString stringWithFormat:@"%@ 过期",pb.currPerson.personType];
        }
        //保存数据
        [pb savePerson:pb.currPerson withBlock:^(int errorCode, NSString * _Nonnull msg) {
        [self outputMessage:1 msg:@"保存成功"];
        }];
    }else{
        [self outputMessage:1 msg:@"请登录后再次进行恢复操作"];
    }
    
}


@end
