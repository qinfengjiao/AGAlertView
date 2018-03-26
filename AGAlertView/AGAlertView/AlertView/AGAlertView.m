//
//  AGAlertView.m
//  MonkeyKingTV
//
//  Created by qinfengjiao on 16/8/16.
//  Copyright © 2016年 AppGame. All rights reserved.
//

#import "AGAlertView.h"
#import "UIColor+AGAppearance.h"
#import "UIView+EasyLayout.h"
@interface AGAlertAction ()

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, assign, readwrite) AGAlertActionStyle style;
@property (nonatomic, copy, readwrite) AGAlertActionHandler handler;

@end

@implementation AGAlertAction


+ (instancetype)actionWithTitle:(NSString *)title style:(AGAlertActionStyle)style handler:(AGAlertActionHandler)handler {
    AGAlertAction *button = [AGAlertAction buttonWithType:UIButtonTypeCustom];
    button.style = style;
    button.title = title;
    button.handler = handler;
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.cornerRadius = 2.0f;
    [button setTitle:title forState:UIControlStateNormal];
    if (style == AGAlertActionStyleCancel) {
        [button setTitleColor:[UIColor ag_G5] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor ag_G6];
    }
    else {
        [button setTitleColor:[UIColor ag_G1] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor ag_Y1];
    }
    return button;
}

+ (instancetype)actionWithAttributedTitle:(NSMutableAttributedString *)title style:(AGAlertActionStyle)style handler:(AGAlertActionHandler)handler{
    AGAlertAction *button = [AGAlertAction actionWithTitle:nil style:style handler:handler];
    [button setAttributedTitle:title forState:UIControlStateNormal];
    return button;

}

@end

@interface AGAlertView ()

@property (nonatomic, strong) UIView *contentView;

// 标题
@property (nonatomic, copy, readwrite) NSString *titleText;

// 弹出框上方图片
@property (nonatomic, strong, readwrite) UIImage *headerImage;

// 中间提示信息内容
@property (nonatomic, copy, readwrite) NSString *messageText;

// 富文本中间提示信息内容
@property (nonatomic, copy, readwrite) NSMutableAttributedString *attributedMessageText;

// 上方图片
@property (nonatomic, strong) UIImageView *headerImageView;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;

// 中间提示信息的 Label
@property (nonatomic, strong) UILabel *messageLabel;

// 下方按钮的数组
@property (nonatomic, strong) NSArray *buttonsArray;

// 按钮容器，方便排列
@property (nonatomic, strong) UIView *buttonContainer;

// 右上角关闭按钮
@property (nonatomic, strong) UIButton *closeButton;

@property (strong, nonatomic) UIView *maskView;


@end

@implementation AGAlertView
@synthesize buttonsArray = _buttonsArray;

- (instancetype)init
{
    return nil;
}

// 初始设置
- (void)setup {
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.contentView];
    self.contentView.el_edgesStickToSuperView();

    if (self.messageText || self.attributedMessageText) {
        [self.contentView addSubview:self.messageLabel];
        self.messageLabel.el_leftToSuperView(24).el_rightToSuperView(24);
    }
    // 有图片、无标题、有内容
    if (self.headerImage) {

        [self.contentView addSubview:self.headerImageView];
        self.headerImageView.el_leftToSuperView(0).el_topToSuperView(0).el_rightToSuperView(0);

        self.headerImageView.image = self.headerImage;
        self.messageLabel.el_topToBottom(self.headerImageView, 24);
        self.messageLabel.el_bottomToSuperView(16);
        [self.messageLabel anyBottomConstraint].priority = UILayoutPriorityDefaultHigh;

    } else if (self.titleText) { // 无图片有标题

        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.el_edgesToSuperView(24, 24, EL_INGNORE, 24);
        self.titleLabel.numberOfLines = 0;

        // 有内容
        if (self.messageText || self.attributedMessageText) {
            self.messageLabel.el_topToBottom(self.titleLabel, 20);
        }
    } else { // 无图片、无标题、只有内容
        [self.contentView addSubview:self.messageLabel];
        self.messageLabel.el_edgesToSuperView(24,24,EL_INGNORE,24);
    }

    self.titleLabel.text = self.titleText;

    if (self.messageText) {
        self.messageLabel.text = self.messageText;
    } else if (self.attributedMessageText){
        self.messageLabel.attributedText = self.attributedMessageText;
    }
}

#pragma mark - 设置按钮位置
- (void)setupButtons {
    if (self.buttonsArray.count == 0) {
        [self.buttonContainer removeFromSuperview];
        if (self.titleText && !self.messageText && !self.attributedMessageText) {
            self.titleLabel.el_bottomToSuperView(16);
        }else {
            self.messageLabel.el_bottomToSuperView(16);
        }
    } else {
        [self.contentView addSubview:self.buttonContainer];

        // 有内容
        if (self.messageText || self.attributedMessageText) {
            self.buttonContainer.el_topToBottom(self.messageLabel,30).el_leftToSuperView(24).el_bottomToSuperView(16).el_rightToSuperView(24).el_toHeight(30);
            // 无内容有标题
        } else {
            self.buttonContainer.el_topToBottom(self.titleLabel, 20).el_leftToSuperView(24).el_bottomToSuperView(16).el_rightToSuperView(24).el_toHeight(30);
        }
        for (UIView *view in self.buttonContainer.subviews) {
            [view removeFromSuperview];
        }

        for (AGAlertAction *button in self.buttonsArray) {
            [self.buttonContainer addSubview: button];
            button.el_topToSuperView(0).el_bottomToSuperView(0);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        [self.buttonsArray el_distributeViewsAlongAxisYFlexibleWidthWithMargin:0 spacing:16];
    }
}

#pragma mark - 构造方法
- (instancetype)initWithTitle:(NSString *)titleText messageText:(NSString *)messageText attributedMessageText: (NSMutableAttributedString *)attributedMessageText headerImage:(UIImage *)headerImage {
    self = [super init];
    if (self) {
        _titleText = titleText;
        _messageText = messageText;
        _attributedMessageText = attributedMessageText;
        _headerImage = headerImage;
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)titleText messageText:(NSString *)messageText {
    return [self initWithTitle:titleText messageText:messageText attributedMessageText:nil headerImage:nil];
}

- (instancetype)initWithTitle:(NSString *)titleText attributedMessageText:(NSMutableAttributedString *)attributedMessageText {
    return [self initWithTitle:titleText messageText:nil attributedMessageText:attributedMessageText headerImage:nil];
}

- (instancetype)initWithHeaderImage:(UIImage *)headerImage messageText:(NSString *)messageText {
    return [self initWithTitle:nil messageText:messageText attributedMessageText:nil headerImage:headerImage];
}

- (instancetype)initWithHeaderImage:(UIImage *)headerImage attributedMessageText:(NSMutableAttributedString *)attributedMessageText {
    return [self initWithTitle:nil messageText:nil attributedMessageText:attributedMessageText headerImage:headerImage];
}

// public method
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    // 如果底部没有按钮，手动调用 setupButtons
    if (!_buttonsArray) {
        [self setupButtons];
    }
    
    // 显示关闭按钮
    if (_enableCloseButton == true) {
        
        [self.contentView addSubview:self.closeButton];
        [self.closeButton setImage:[UIImage imageNamed:@"live_detail_close"] forState:UIControlStateNormal];
        self.closeButton.userInteractionEnabled = true;
        [self.closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
     self.closeButton.el_topToSuperView(0).el_rightToSuperView(0).el_toHeight(24).el_toWidth(24);
    }
    [view addSubview:self.maskView];
    [view addSubview:self];
    self.el_centreToSuperView(CGPointZero).el_toWidth(295);
}

- (void)showInView:(UIView *)view disappearAfterDelay:(CGFloat)delay {
    
    // 如果自动消失，则隐藏关闭按钮
    self.enableCloseButton = false;
    [self showInView:view];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

- (void)addAction:(AGAlertAction *)action {
    NSAssert([action isKindOfClass:[AGAlertAction class]], @"Must be of type AGAlertAction");
    NSMutableArray *arr = [self.buttonsArray mutableCopy];
    [arr addObject:action];
    if (self.buttonsArray.count<2) {
        self.buttonsArray = arr.copy;
    }
}

- (void)dismiss {
    if (self.superview) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
    }
}

#pragma mark - getters & lazy load

- (UIImageView *)headerImageView {
	if (_headerImageView == nil) {
        _headerImageView = [[UIImageView alloc] init];
	}
	return _headerImageView;
}

- (UILabel *)titleLabel {
	if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor ag_G1];
	}
	return _titleLabel;
}

- (UILabel *)messageLabel {
	if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor ag_G5];
        _messageLabel.numberOfLines = 0;
	}
	return _messageLabel;
}

- (NSArray *)buttonsArray {
	if (_buttonsArray == nil) {
        _buttonsArray = [[NSArray alloc] init];
	}
	return _buttonsArray;
}

- (UIView *)buttonContainer {
	if (_buttonContainer == nil) {
        _buttonContainer = [[UIView alloc] init];
        _buttonContainer.backgroundColor = [UIColor clearColor];
	}
	return _buttonContainer;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [[UIButton alloc]init];
        _closeButton.backgroundColor = [UIColor clearColor];
    }
    return _closeButton;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _maskView;
}

// setters

- (void)setButtonsArray:(NSArray *)buttonsArray {
    _buttonsArray = buttonsArray;
    [self setupButtons];
}

- (void)setMessageTextAligment:(NSTextAlignment)messageTextAligment {
    _messageTextAligment = messageTextAligment;
    self.messageLabel.textAlignment = messageTextAligment;
}

// private method

- (void)buttonClick:(AGAlertAction *)sender {
    if (sender.style != AGAlertActionStyleNotDismiss) {
        [self dismiss];
    }
    if (sender.handler) {
        sender.handler(sender);
    }
}

// override

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.layer.cornerRadius = 8;
    self.contentView.clipsToBounds = YES;
    
    self.layer.shadowOffset = CGSizeMake(0, 6);
    self.layer.shadowRadius = 10.0f;
    self.layer.shadowOpacity = 0.35;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    // 强制设置本身为 clearColor
    [super setBackgroundColor:[UIColor clearColor]];
    
    self.contentView.backgroundColor = backgroundColor;
}

@end


