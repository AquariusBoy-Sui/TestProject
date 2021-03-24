//
//  PhotoBrowseController.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseController.h"
#import "PhotoBrowseCell.h"
#import "UIView+Layout.h"
#import "PhotoBrowseModel.h"

@interface PhotoBrowseController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

/** collectionView */
@property(nonatomic, strong) UICollectionView *collectionView;

/** 页码 */
@property(nonatomic, strong) UILabel *pageLabel;
/** 关闭按钮 */
@property(nonatomic, strong) UIButton *closeBtn;
/** 模型数组 */
@property(nonatomic, strong) NSMutableArray *photoBrowseModelArr;
/** 当前显示的Index */
@property(nonatomic, assign) NSInteger currentIndex;
/** 当前的image */
@property(nonatomic, strong) UIImage *currentImage;
/** 当前indexPath */
@property(nonatomic, strong) NSIndexPath *currentIndexPath;
/** 进入查看大图的Controller的方式 */
@property(nonatomic, assign) NSInteger way;

@end

static NSString *ID = @"PhotoBrowseCell";

@implementation PhotoBrowseController

- (instancetype)initWithAllPhotosArray:(NSMutableArray *)photosArr currentIndex:(NSInteger)currentIndex way:(NSInteger)way
{
    if (self = [super init])
    {
        self.way = way ;
        
        for (UIImage *image in photosArr)
        {
            PhotoBrowseModel *model = [PhotoBrowseModel photoBrowseModelWith:image];
            [self.photoBrowseModelArr addObject:model];
        }
        self.currentIndex = currentIndex;
    }
    return self;
}
- (instancetype)initWithAllPhotosUrlArray:(NSArray *)photosurl currentIndex:(NSInteger)currentIndex way:(NSInteger )way{
    if (self = [super init])
    {
        self.way = way ;
        
        for (NSString *imageStr in photosurl)
        {
            if (![imageStr isEqualToString:@""]) {
                PhotoBrowseModel *model = [PhotoBrowseModel photoUrlModelWith:imageStr];
                [self.photoBrowseModelArr addObject:model];
            }
            
        }
        self.currentIndex = currentIndex;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageLabel];
    [self.view addSubview:self.closeBtn];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    [self.collectionView setContentOffset:CGPointMake((self.view.tz_width + 20) * self.currentIndex, 0) animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.view.tz_width + 20, self.view.tz_height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.tz_width + 20, self.view.tz_height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor blackColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.contentSize = CGSizeMake(self.photoBrowseModelArr.count * (self.view.tz_width + 20), 0);
        [_collectionView registerClass:[PhotoBrowseCell class] forCellWithReuseIdentifier:ID];
    }
    return _collectionView;
}



- (UILabel *)pageLabel
{
    if (!_pageLabel)
    {
        _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.view.tz_width, 22)];
        _pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex + 1, self.photoBrowseModelArr.count];
        _pageLabel.textColor = [UIColor whiteColor];
        _pageLabel.textAlignment = NSTextAlignmentCenter;
        _pageLabel.font = [UIFont systemFontOfSize:20.0];
        _pageLabel.backgroundColor = [UIColor clearColor];
    }
    return _pageLabel;
}
-(UIButton*)closeBtn{
    if (!_closeBtn) {
        _closeBtn =[[UIButton alloc] initWithFrame:CGRectMake(self.view.tz_width-30, self.view.tz_top, 30, 30)];
        [_closeBtn setImage:[UIImage imageNamed:@"icon_photo_close"] forState:UIControlStateNormal];
        [_closeBtn  addTarget:self action:@selector(closeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _closeBtn;
}
-(void)closeBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (NSMutableArray *)photoBrowseModelArr
{
    if (!_photoBrowseModelArr)
    {
        _photoBrowseModelArr = [NSMutableArray array];
    }
    return _photoBrowseModelArr;
}
#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoBrowseModelArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoBrowseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = self.photoBrowseModelArr[indexPath.row];
    
    __weak typeof(self) weakSelf = self;
    cell.singleTapGestureBlock = ^(){
        
        if (weakSelf.way == 1) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        else {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    if ([cell.model.imageUrl isEqualToString:@""]) {
        self.currentImage = cell.browseView.imageView.image;
    }else{
        self.currentImage = cell.browseView.imageView.image;
    }
    
    self.currentIndexPath = indexPath;
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PhotoBrowseCell class]])
    {
        [(PhotoBrowseCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[PhotoBrowseCell class]])
    {
        [(PhotoBrowseCell *)cell recoverSubviews];
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //设置页码Label
    NSInteger page = scrollView.contentOffset.x / (self.view.tz_width + 20);
    self.pageLabel.text = [NSString stringWithFormat:@"%zd/%zd", page + 1, self.photoBrowseModelArr.count];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
