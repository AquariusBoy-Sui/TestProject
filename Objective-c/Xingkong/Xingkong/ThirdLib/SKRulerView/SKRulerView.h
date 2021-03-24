//
//  SKRulerView.h
//  0002
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKRulerView : UIView

@end


///部分低于范围刻度内显示的cell
@interface LowerThanScaleViewCell : UICollectionViewCell
///范围内小于number的为超范围的，大于等于number的为正常范围的
@property (nonatomic ,assign)NSInteger number;
@property (nonatomic ,strong)UILabel * numberlabel;

@end


///正常刻度内显示的cell
@interface NormalScaleViewCell : UICollectionViewCell

@property (nonatomic ,strong)UILabel * numberlabel;

@end


///部分超出范围显示的cell
@interface PartBeyondScaleViewCell : UICollectionViewCell
///范围内小于等于number的为正常范围的，大于number的为超范围的
@property (nonatomic ,assign)NSInteger number;
@property (nonatomic ,strong)UILabel * numberlabel;
@end

///超出刻度范围显示不同的cell
@interface BeyondScaleViewCell : UICollectionViewCell
@property (nonatomic ,strong)UILabel * numberlabel;
@end


@interface HeaderCell : UICollectionViewCell
@end



@interface FooterCell : UICollectionViewCell
@property (nonatomic ,strong)UILabel * numberlabel;
@end

@interface SKTriangleView : UIView

@end
NS_ASSUME_NONNULL_END
