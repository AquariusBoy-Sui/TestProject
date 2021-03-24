//
//  NSString+SubString.m
//  CatPregnent2
//
//  Created by ji long on 2020/8/21.
//  Copyright © 2020 Binky Lee. All rights reserved.
//

#import "NSString+SubString.h"

@implementation NSString (SubString)



/**
 是否为中文汉字
 */
-(BOOL)isHaveChineseInString:(NSString *)string{
    for(NSInteger i = 0; i < [string length]; i++){
        int a = [string characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}


-(NSString*)subString{
    int subLenght=10;
    //判断是否含有中文
    if([self isHaveChineseInString:self])
    {
        subLenght=6;
    }
    if(self.length > subLenght)
    {
        NSString *subString=[NSString stringWithFormat:@"%@...",[self substringToIndex:subLenght-1]];
        return subString;
    }
    return self;
}

@end
