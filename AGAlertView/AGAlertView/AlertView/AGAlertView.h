//
//  AGAlertView.h
//  MonkeyKingTV
//
//  Created by qinfengjiao on 16/8/16.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AGAlertActionStyle) {
    AGAlertActionStyleDefault = 0,
    AGAlertActionStyleCancel,
    AGAlertActionStyleNotDismiss
};

@interface AGAlertAction : UIButton

typedef void (^AGAlertActionHandler)(AGAlertAction *action);

// 唯一构造方法
+ (instancetype)actionWithTitle:(NSString *)title style:(AGAlertActionStyle)style handler:(AGAlertActionHandler)handler;
//支持富文本
+ (instancetype)actionWithAttributedTitle:(NSMutableAttributedString *)title style:(AGAlertActionStyle)style handler:(AGAlertActionHandler)handler;

///  @brief 按钮的文字
@property (nonatomic, copy, readonly) NSString *title;
///  @brief 设置按钮样式
@property (nonatomic, assign, readonly) AGAlertActionStyle style;
///  @brief 用来添加点击按钮后的操作
@property (nonatomic, copy, readonly) AGAlertActionHandler handler;
@end


///  @brief 快速创建弹框
@interface AGAlertView : UIView

///  @brief 标题文字
@property (nonatomic, copy, readonly) NSString *titleText;

///  @brief 弹出框上方图片
@property (nonatomic, strong, readonly) UIImage *headerImage;

///  @brief 中间提示信息内容
@property (nonatomic, copy, readonly) NSString *messageText;

///  @brief 富文本中间提示信息内容
@property (nonatomic, copy, readonly) NSMutableAttributedString *attributedMessageText;

///  @brief 提示语的对齐方式，默认左对齐
@property (nonatomic, assign) NSTextAlignment messageTextAligment;

///  @brief 显示右上角关闭按钮
@property (nonatomic, assign) BOOL enableCloseButton;

///  @brief 创建无图弹框
///
///  @param titleText         弹框标题
///  @param messageText       弹框内容
- (instancetype)initWithTitle:(NSString *)titleText messageText:(NSString *)messageText;

///  @brief 创建无图弹框
///
///  @param titleText         弹框标题
///  @param attributedMessageText       弹框内容(支持富文本)
- (instancetype)initWithTitle:(NSString *)titleText attributedMessageText:(NSMutableAttributedString *)attributedMessageText;

///  @brief 创建有图片弹框
///
///  @param headerImage       弹框图片
///  @param messageText       弹框内容
- (instancetype)initWithHeaderImage:(UIImage *)headerImage messageText:(NSString *)messageText;

///  @brief 创建有图片弹框
///
///  @param headerImage       弹框图片
///  @param attributedMessageText       弹框内容(支持富文本)
- (instancetype)initWithHeaderImage:(UIImage *)headerImage attributedMessageText:(NSMutableAttributedString *)attributedMessageText;

///  @brief 添加按钮及点击事件，添加的按钮将在最下文水平排列
- (void)addAction:(AGAlertAction *)action;

///  @brief 在哪个 View 中展示
- (void)showInView:(UIView *)view;

///  @brief 展示并延时消失
- (void)showInView:(UIView *)view disappearAfterDelay:(CGFloat)delay;

///  @brief 销毁弹框
- (void)dismiss;
@end
