//
//  MJRefreshManager.m
//  CatPregnent2
//
//  Created by MrSui on 2020/5/29.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "MJRefreshManager.h"
#import "UIColor+system.h"
@implementation MJRefreshManager

+ (MJRefreshNormalHeader *)defaultHeader:(MJRefreshComponentAction)refreshingBlock {
//    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    header.loadingView.activityIndicatorViewStyle=[self getIndicatorViewStyle];
    // 往下拉的时候文字
//    [header setTitle:@"下拉刷新" forState:MJRefreshStateWillRefresh];
//    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    [header setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    [header.stateLabel setTextColor:[UIColor getGrayLabelColor]];
    
    header.lastUpdatedTimeLabel.font =[UIFont systemFontOfSize:14];
    [header.lastUpdatedTimeLabel setTextColor:[UIColor getGrayLabelColor]];
    return header;
}

+ (MJRefreshNormalHeader *)defaultRefreshingHeader:(MJRefreshComponentAction)refreshingBlock {

    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    header.loadingView.activityIndicatorViewStyle=[self getIndicatorViewStyle];
    [header setTitle:@"正在更新数据请等待..." forState:MJRefreshStateRefreshing];
    header.stateLabel.font = [UIFont systemFontOfSize:14];
    [header.stateLabel setTextColor:[UIColor getGrayLabelColor]];
    [header.lastUpdatedTimeLabel setHidden:YES];
    return header;
}
+ (MJRefreshAutoNormalFooter *)defaultFooter:(MJRefreshComponentAction)refreshingBlock {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    footer.loadingView.activityIndicatorViewStyle=[self getIndicatorViewStyle];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];

    return footer;
}

+ (MJRefreshAutoNormalFooter *)defaultNoMoreDataFooter:(MJRefreshComponentAction)refreshingBlock{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:refreshingBlock];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    footer.loadingView.activityIndicatorViewStyle=[self getIndicatorViewStyle];
    [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
    return footer;
}

+(UIActivityIndicatorViewStyle) getIndicatorViewStyle{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {  //深色模式
            return UIActivityIndicatorViewStyleWhite;
        }
        if (mode == UIUserInterfaceStyleLight) { //浅色模式
            return UIActivityIndicatorViewStyleGray;
        }
        if(mode == UIUserInterfaceStyleUnspecified) { //浅色模式
            return UIActivityIndicatorViewStyleWhite;
        }
    }
    return UIActivityIndicatorViewStyleWhiteLarge;
}

@end
