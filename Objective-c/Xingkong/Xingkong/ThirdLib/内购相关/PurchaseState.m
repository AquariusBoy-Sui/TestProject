//
//  PurchaseState.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/5.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "PurchaseState.h"

@implementation PurchaseState



-(void)runState:(NSObject*)data{
    NSLog(@"当前状态:%@",self.stateName);
}

/**
 输出状态及消息
 */
-(void)outputMessage:(int)stateCode msg:(NSString*) msg{
    if(self.stateCallback)
    {
        self.stateCallback(stateCode,msg);
    }else{
        NSLog(@"PurchaseState:%d msg:%@",stateCode,msg);
    }
}


/**
 向当前状态的末尾增加状态
 */
-(void)addNextState:(PurchaseState*)nextState{
    PurchaseState *last=self;
    //查找最后一个状态
    while (last.nextState) {
        last=last.nextState;
    }
    last.nextState=nextState;
    nextState.stateCallback=self.stateCallback;
    
    //起点状态
    //nextState.firstState=self;
}


@end
