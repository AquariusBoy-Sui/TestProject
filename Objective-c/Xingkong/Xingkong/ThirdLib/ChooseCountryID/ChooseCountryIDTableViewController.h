//
//  ChooseCountryIDTableViewController.h
//  CatPregnent2
//
//  Created by MrSui on 2020/4/28.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+system.h"
NS_ASSUME_NONNULL_BEGIN


@protocol ChooseCountryIDTableViewControllerDelegate <NSObject>

@optional
-(void)returnCountryCode:(NSString *)countryCode;

@end
typedef void(^returnCountryCodeBlock) (NSString *countryCodeStr);
@interface ChooseCountryIDTableViewController : UITableViewController

@property (nonatomic, assign) id<ChooseCountryIDTableViewControllerDelegate> deleagete;
@end

NS_ASSUME_NONNULL_END
