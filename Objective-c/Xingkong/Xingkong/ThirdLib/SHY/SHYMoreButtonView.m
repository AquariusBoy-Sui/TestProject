//
//  SHYMoreButtonView.m
//  CatPregnent2
//
//  Created by MrSui on 2020/6/11.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "SHYMoreButtonView.h"
#define ScaleX   SCREEN_WIDTH/375
#import "UIColor+system.h"

@interface SHYMoreButtonView()

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray *btnsArray;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation SHYMoreButtonView


#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.btnNormalImage=@"";
        self.btnSelectImage=@"";
        //尹闯于2020.6.17 早10点45修改此处
        //更改标题颜色为getlabelcolor
        self.btnTitleNormalColor=[UIColor getlabelColor];
        self.btnTitleSelectColor=[UIColor greenColor];
        
        self.lineColor=[UIColor redColor];
        
        self.fontSize=15;
        self.btnsArray = [NSMutableArray array];
    }
    return self;
}
#pragma mark - initSubViews
- (void)initSubViews:(NSArray *)btnNameArray andIsCenter:(BOOL)isCenter
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat buttonWidth = 0;
    CGFloat btnX = 0;
    CGFloat edg = 0;
    if (isCenter) {
        buttonWidth = SCREEN_WIDTH / btnNameArray.count;
    }else{
        btnX = 20*ScaleX;
        edg = 20*ScaleX;
    }
    
    for (int i = 0; i < btnNameArray.count; i++) {
        
        CGFloat btnWidth;
        if (isCenter) {
            btnWidth = buttonWidth;
        }else{
            btnWidth =[self getWidthWithStr:btnNameArray[i] andFont:[UIFont systemFontOfSize:15]];
        }
        UIButton *btn = [self  buttonWithTitle:btnNameArray[i] titleColor:_btnTitleNormalColor titleFont:[UIFont systemFontOfSize:_fontSize] image:[UIImage imageNamed:_btnNormalImage] selectedImage:[UIImage imageNamed:_btnSelectImage]];
        
        [btn setTitleColor:_btnTitleSelectColor forState:UIControlStateSelected];
        btn.frame = CGRectMake(btnX, 0, btnWidth, self.lx_height);
        btn.tag = i;
        [btn addTarget:self action:@selector(clickedBtnsAction:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
        [_btnsArray addObject:btn];
        btnX += (btnWidth + edg);
    }
    
    self.contentSize = CGSizeMake(btnX + 20*ScaleX, self.lx_height);

    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = _lineColor;
    _lineView.frame = CGRectMake(0, self.lx_height/2+_fontSize/2+5, 0, 1);
    [self addSubview:_lineView];
    
    [self changeSelectedBtn:[_btnsArray objectAtIndex:0]];
}
#pragma mark - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    self.selectedBtn = _btnsArray[selectedIndex];
    
    for (UIButton *btn in _btnsArray) {
        btn.selected = NO;
    }
    
    self.selectedBtn.selected = YES;
    
    CGFloat btnWidth = [self getWidthWithStr:_selectedBtn.titleLabel.text
                                       andFont:[UIFont systemFontOfSize:15]];
    [self changeLineViewFrameWithBtnWidth:btnWidth];
}

#pragma mark - action
- (void)clickedBtnsAction:(UIButton *)btn
{

    [self changeSelectedBtn:btn];
    self.clickedBtnsBlock(btn.tag,btn.titleLabel.text);
}

- (void)changeSelectedBtn:(UIButton *)btn
{
    for (UIButton *btn in _btnsArray) {
        btn.selected = NO;
    }
    
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    
    CGFloat btnWidth = [self getWidthWithStr:_selectedBtn.titleLabel.text andFont:[UIFont systemFontOfSize:15]];
    [self changeLineViewFrameWithBtnWidth:btnWidth];
}

- (void)changeLineViewFrameWithBtnWidth:(CGFloat)btnWidth
{
    CGRect frame = self.lineView.frame;
    frame.size.width = btnWidth;
    self.lineView.frame = frame;
    self.lineView.center = CGPointMake(self.selectedBtn.center.x, self.lineView.center.y);
}


- (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}

- (float)getWidthWithStr:(NSString *)str andFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 9999, font.lineHeight)];
    label.text = str;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}
@end
