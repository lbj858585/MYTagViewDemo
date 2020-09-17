//
//  MenuController.m
//  MYTagViewDemo
//
//  Created by libj on 2020/9/15.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MenuController.h"
#import "MYPopupMenuView.h"
@interface MenuController ()

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseAttribute];
    [self setupSubviews];
    [self setupSubviewsLayout];
}

- (void) setBaseAttribute {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"弹出菜单";
}

- (void) setupSubviews {
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(100);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    UIButton *button2 = [UIButton new];
    button2.backgroundColor = [UIColor redColor];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(200);
        make.top.offset(100);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    UIButton *button3 = [UIButton new];
    button3.backgroundColor = [UIColor redColor];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.top.offset(800);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    
    UIButton *button4 = [UIButton new];
    button4.backgroundColor = [UIColor redColor];
    [self.view addSubview:button4];
    [button4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(370);
        make.top.offset(100);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
    
    UIButton *button5 = [UIButton new];
    button5.backgroundColor = [UIColor redColor];
    [self.view addSubview:button5];
    [button5 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(50);
        make.height.equalTo(20);
    }];
}

- (void) setupSubviewsLayout {

}

- (void)buttonClick:(id)sender {
    MYPopupMenuView *menu = [MYPopupMenuView new];
    menu.itemsTitle = @[@"全部会诊订单",@"我发起的会诊订单",@"我服务的会诊订单",@"我发起的会诊订单",@"我发起的会诊订单",@"我发起的会诊订单"];
    [menu showToView:sender handler:^(NSInteger index) {
        
    }];
}

@end
