//
//  UIColor+AGAppearance.m
//  AGAlertView
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "UIColor+AGAppearance.h"

@implementation UIColor (AGAppearance)
+ (UIColor *)HEX:(NSInteger)hex{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1];
}
+ (UIColor*)ag_B1{
    return [UIColor HEX:0x0095fe];
}
+ (UIColor*)ag_B2{
    return [UIColor HEX:0x787878];
}
+ (UIColor*)ag_B3{
    return [UIColor HEX:0xa0a1a5];
}


+ (UIColor*)ag_G0{
    return [UIColor HEX:0x2a3070];
}
+ (UIColor*)ag_G1{
    return [UIColor HEX:0x1b1b1b];
}
+ (UIColor*)ag_G2{
    return [UIColor HEX:0x787878];
}
+ (UIColor*)ag_G3{
    return [UIColor HEX:0xa0a1a5];
}
+ (UIColor*)ag_G4{
    return [UIColor HEX:0xf5f5f5];
}
+ (UIColor*)ag_G5{
    return [UIColor HEX:0x545454];
}
+ (UIColor*)ag_G6{
    return [UIColor HEX:0xdfdfdf];
}
+ (UIColor*)ag_G7{
    return [UIColor HEX:0xe2e6f3];
}

+ (UIColor*)ag_P1{
    return [UIColor HEX:0xfe9494];
}
+ (UIColor*)ag_P2{
    return [UIColor HEX:0x9aa9e4];
}

+ (UIColor*)ag_R1{
    return [UIColor HEX:0xfe4d67];
}

+ (UIColor*)ag_W1{
    return [UIColor HEX:0xffffff];
}

+ (UIColor*)ag_Y1{
    
    return [UIColor HEX:0xfed100];
}

+ (UIColor*)ag_Y2{
    return [UIColor HEX:0xfec200];
}

+ (UIColor*)ag_Y3{
    return [UIColor HEX:0xfead00];
}

+ (UIColor*)ag_Y4{
    return [UIColor HEX:0xfeef35];
}

+ (UIColor*)ag_O1{
    return [UIColor HEX:0xff5a26];
}

@end
