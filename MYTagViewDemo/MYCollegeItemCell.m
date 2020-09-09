//
//  MYCollegeItemCell.m
//  MYTagViewDemo
//
//  Created by libj on 2020/9/9.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYCollegeItemCell.h"
#import "HeaderFiles.h"
@interface MYCollegeItemCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation MYCollegeItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBaseAttribute];
        [self setupSubviews];
        [self setupSubviewsLayout];
    }
    return self;
}

- (void) setBaseAttribute {
    
}

- (void) setupSubviews {
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
}

- (void) setupSubviewsLayout {
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(MY(10));
        make.centerX.equalTo(self);
        make.height.equalTo(@(MY(40)));
        make.width.equalTo(MY(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.offset(0);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(MY(7));
    }];
}

- (void)setIconName:(NSString *)iconName {
    self.iconImageView.image = [UIImage imageNamed:iconName];
}
- (void)setTitleText:(NSString *)titleText {
    self.titleLabel.text = titleText;
}
#pragma mark - lazy
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = MY(40)*0.5;
        _iconImageView.clipsToBounds = YES;
    }
    return _iconImageView;
}
@end
