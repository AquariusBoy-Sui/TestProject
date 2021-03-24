//
//  UITextView+configKeyboard.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/19.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "UITextView+configKeyboard.h"

@implementation UITextView (configKeyboard)


-(void)configKeyboard:(nullable id)target action:(SEL)action
{
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    // ↑↓←→
    UIButton *upBtn=[[UIButton alloc] init];
    [upBtn setTitle:@"↑" forState:UIControlStateNormal];
    [upBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bar addSubview:upBtn];
    [upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bar);
        make.left.equalTo(bar).offset(10);
    }];
    UIButton *downBtn=[[UIButton alloc] init];
    [downBtn setTitle:@"↓" forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bar addSubview:downBtn];
    [downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bar);
        make.left.equalTo(upBtn.mas_right).offset(10);
    }];
    UIButton *doneBtn = [[UIButton alloc] init];
    [doneBtn setTitle:@"完成"forState:UIControlStateNormal];
    [doneBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setTitleColor:[UIColor colorWithRed:15.0/255.0 green:98.0/255.0 blue:233.0/255.0 alpha:1] forState:UIControlStateNormal];
    [bar addSubview:doneBtn];
    [doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bar);
        make.right.equalTo(bar).offset(-10);
    }];
    self.inputAccessoryView = bar;
}

/**
 设置文字提示
 */
-(void)setTextTip{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入备注内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    
    // same font
    self.font = [UIFont systemFontOfSize:17.f];
    //CGFloat fontSize= self.font.labelFontSize;
    placeHolderLabel.font = [UIFont systemFontOfSize:17.f];
    [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}


@end
