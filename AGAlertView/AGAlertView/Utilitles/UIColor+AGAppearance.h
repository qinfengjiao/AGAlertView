//
//  UIColor+AGAppearance.h
//  AGAlertView
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AGAppearance)
+ (UIColor *)ag_B1;
+ (UIColor *)ag_B2;
+ (UIColor *)ag_B3;

+ (UIColor *)ag_G0;

///  @brief 用于重要的文字信息、内容标题信息。
+ (UIColor *)ag_G1;

///  @brief 用于用户信息、二级文字
+ (UIColor *)ag_G2;

///  @brief 用于次要和候选文字
+ (UIColor *)ag_G3;

///  @brief 背景颜色
+ (UIColor *)ag_G4;

///  @brief 用于弹框内容文字颜色
+ (UIColor *)ag_G5;
///  @brief 用于分割线
+ (UIColor *)ag_G6;
+ (UIColor *)ag_G7;

+ (UIColor *)ag_P1;
+ (UIColor *)ag_P2;

+ (UIColor *)ag_R1;

///  @brief 白色
+ (UIColor *)ag_W1;

///  @brief 用于凸显的按钮和 icon
+ (UIColor *)ag_Y1;
///  @brief 蟠桃界面
+ (UIColor *)ag_Y2;
+ (UIColor*)ag_Y3;
+ (UIColor*)ag_Y4;
///  @brief 用于重要的连接文字和错误提示文字颜色
+ (UIColor*)ag_O1;
@end
