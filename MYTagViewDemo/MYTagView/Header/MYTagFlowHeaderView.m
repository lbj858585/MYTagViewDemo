//
//  MYTagFlowHeaderView.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTagFlowHeaderView.h"
#import <Masonry.h>

@interface MYTagFlowHeaderView ()
@property (nonatomic, strong) UIImageView *leftIV;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation MYTagFlowHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createInterface];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setConstraints];
}

#pragma mark - 内部逻辑实现
- (void)deleteButtonClicked:(UIButton *)btn {
//    if ([self.delegate respondsToSelector:@selector(XDAutoresizeLabelFlowHeaderDeleteAction)]) {
//        [self.delegate XDAutoresizeLabelFlowHeaderDeleteAction];
//    }
    if (self.deleteActionBlock) {
        self.deleteActionBlock(self.indexPath);
    }
}


#pragma mark - 代理协议
#pragma mark - 数据请求 / 数据处理
- (void)setHaveDeleteBtn:(BOOL)haveDeleteBtn {
    _haveDeleteBtn = haveDeleteBtn;
    if (haveDeleteBtn) {
        self.deleteBtn.hidden = false;
    }else {
        self.deleteBtn.hidden = true;
    }
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    _title.text = titleString;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.title.textColor = titleColor;
}
#pragma mark - 视图布局
- (void)createInterface {
    // 图片
    self.leftIV = [[UIImageView alloc] init];
    [self addSubview:self.leftIV];
    
    // 标题
    self.title = [UILabel new];
    [self addSubview:self.title];
    
    // 右上角 删除按钮
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.deleteBtn];
}

- (void)setConstraints {
    [self.leftIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(6);
        make.centerY.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MY_PADDING_LEFT);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-80);
    }];
}


@end
