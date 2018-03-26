//
//  ViewController.m
//  AGAlertView
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "AGAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AGAlertView *alertView = [[AGAlertView alloc] initWithTitle:@"标题" messageText:@"内容"];
//    [alertView addAction:[AGAlertAction actionWithTitle:@"确定" style:AGAlertActionStyleDefault handler:^(AGAlertAction *action) {
//        NSLog(@"点击了确定按钮");
//    }]];
//    [alertView addAction:[AGAlertAction actionWithTitle:@"取消" style:AGAlertActionStyleCancel handler:^(AGAlertAction *action) {
//        NSLog(@"点击了取消按钮");
//    }]];
    [alertView addAction:[AGAlertAction actionWithTitle:@"不消失" style:AGAlertActionStyleNotDismiss handler:^(AGAlertAction *action) {
        NSLog(@"点击按钮不消失");
    }]];
    [alertView showInView:self.view];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
