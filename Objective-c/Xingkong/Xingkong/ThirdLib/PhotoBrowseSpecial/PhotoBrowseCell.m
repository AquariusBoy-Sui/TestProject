//
//  PhotoBrowseCell.m
//  BGH-family
//
//  Created by Sunny on 17/2/24.
//  Copyright © 2017年 Zontonec. All rights reserved.
//

#import "PhotoBrowseCell.h"
#import "UIView+Layout.h"
#import "PhotoBrowseModel.h"
//#import "UIImageView+WebCache.h"

@implementation PhotoBrowseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor blackColor];
        self.browseView = [[PhotoBrowseView alloc] initWithFrame:self.bounds];
        
        __weak typeof(self) weakSelf = self;
        self.browseView.singleTapGestureBlock = ^(){
            if (weakSelf.singleTapGestureBlock) {
                weakSelf.singleTapGestureBlock();
            }
        };
        
        [self addSubview:self.browseView];
    }
    return self;
}

- (void)setModel:(PhotoBrowseModel *)model
{
    self.browseView.model = model;
}

- (void)recoverSubviews
{
    [self.browseView recoverSubviews];
}


@end


@interface PhotoBrowseView() <UIScrollViewDelegate>

@end

@implementation PhotoBrowseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.frame = CGRectMake(10, 0, self.tz_width - 20, self.tz_height);
        self.scrollView.bouncesZoom = YES;
        self.scrollView.maximumZoomScale = 2.5;
        self.scrollView.minimumZoomScale = 1.0;
        self.scrollView.multipleTouchEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.scrollView.delaysContentTouches = NO;
        self.scrollView.canCancelContentTouches = YES;
        self.scrollView.alwaysBounceVertical = NO;
        [self addSubview:self.scrollView];
        
        self.imageContainerView = [[UIView alloc] init];
        self.imageContainerView.clipsToBounds = YES;
        self.imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [self.scrollView addSubview:self.imageContainerView];
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.backgroundColor = [UIColor blackColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        [self.imageContainerView addSubview:self.imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self addGestureRecognizer:tap2];
    }
    return self;
}

- (void)setModel:(PhotoBrowseModel *)model
{
    _model = model;
    if (_model.imageUrl != nil) {
        [self.active startAnimating];
        [self.imageView  sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:@"img_video_loading"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [self.active stopAnimating];
        }];
        return;
    }
    [self.imageView setImage:_model.image];
}
- (UIActivityIndicatorView *)active
{
    if (!_active)
    {
        self.active = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.active.color=[UIColor whiteColor];
        
        [self addSubview:self.active];
        [_active mas_makeConstraints:^(MASConstraintMaker *make) {
               make.centerX.centerY.equalTo(self);
        }];
    }
    return _active;
}
- (void)recoverSubviews
{
    [self.scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
}

- (void)resizeSubviews
{
    self.imageContainerView.tz_origin = CGPointZero;
    self.imageContainerView.tz_width = self.scrollView.tz_width;
    
    UIImage *image = self.imageView.image;
    if (image.size.height / image.size.width > self.tz_height / self.scrollView.tz_width)
    {
        self.imageContainerView.tz_height = floor(image.size.height / (image.size.width / self.scrollView.tz_width));
    }
    else
    {
        CGFloat height = image.size.height / image.size.width * self.scrollView.tz_width;
        if (height < 1 || isnan(height)) height = self.tz_height;
        height = floor(height);
        self.imageContainerView.tz_height = height;
        self.imageContainerView.tz_centerY = self.tz_height / 2;
    }
    if (self.imageContainerView.tz_height > self.tz_height && self.imageContainerView.tz_height - self.tz_height <= 1)
    {
        self.imageContainerView.tz_height = self.tz_height;
    }
    CGFloat contentSizeH = MAX(self.imageContainerView.tz_height, self.tz_height);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.tz_width, contentSizeH);
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    self.scrollView.alwaysBounceVertical = self.imageContainerView.tz_height <= self.tz_height ? NO : YES;
    self.imageView.frame = _imageContainerView.bounds;
    
    [self refreshScrollViewContentSize];
}

#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap
{
    if (self.scrollView.zoomScale > 1.0)
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.scrollView setZoomScale:1.0 animated:YES];
    }
    else
    {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = self.scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [self.scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap
{
    if (self.singleTapGestureBlock)
    {
        self.singleTapGestureBlock();
    }
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self refreshImageContainerViewCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [self refreshScrollViewContentSize];
}

#pragma mark - Private

- (void)refreshImageContainerViewCenter
{
    CGFloat offsetX = (self.scrollView.tz_width > self.scrollView.contentSize.width) ? ((self.scrollView.tz_width - self.scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (self.scrollView.tz_height > self.scrollView.contentSize.height) ? ((self.scrollView.tz_height - self.scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX, self.scrollView.contentSize.height * 0.5 + offsetY);
}

- (void)refreshScrollViewContentSize
{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

@end
