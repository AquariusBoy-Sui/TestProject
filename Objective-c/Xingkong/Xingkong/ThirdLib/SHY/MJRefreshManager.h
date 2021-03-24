//
//  MJRefreshManager.h
//  CatPregnent2
//
//  Created by MrSui on 2020/5/29.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>
NS_ASSUME_NONNULL_BEGIN

@interface MJRefreshManager : NSObject
/**
*   Header Header默认
*/
+ (MJRefreshNormalHeader *)defaultHeader:(MJRefreshComponentAction)refreshingBlock;
/**
*   Header 正在更新数据请等待...
 */
+ (MJRefreshNormalHeader *)defaultRefreshingHeader:(MJRefreshComponentAction)refreshingBlock ;
/**
*   Footer 默认
*/
+ (MJRefreshAutoNormalFooter *)defaultFooter:(MJRefreshComponentAction)refreshingBlock;
/**
*   Footer 没有更多数据
*/
+ (MJRefreshAutoNormalFooter *)defaultNoMoreDataFooter:(MJRefreshComponentAction)refreshingBlock;//没有更多数据

@end

NS_ASSUME_NONNULL_END
