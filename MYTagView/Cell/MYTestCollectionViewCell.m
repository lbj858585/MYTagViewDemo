//
//  MYTestCollectionViewCell.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTestCollectionViewCell.h"
#import "MYTagViewConfig.h"
@interface MYTestCollectionViewCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation MYTestCollectionViewCell
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
    [self.contentView addSubview:self.titleLabel];
}

- (void) setupSubviewsLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setConfig:(MYTagViewConfig *)config {
    _config = config;
    self.titleLabel.backgroundColor = config.itemColor;
    self.titleLabel.textColor = config.textColor;
    self.titleLabel.font = config.textFont;
    self.titleLabel.layer.cornerRadius = config.itemCornerRaius;
    self.titleLabel.layer.borderColor = config.borderColor.CGColor;
    self.titleLabel.layer.borderWidth = config.borderWidth;
}
- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setBeSelected:(BOOL)beSelected {
    _beSelected = beSelected;
    if (beSelected) {
        self.titleLabel.backgroundColor = self.config.itemSelectedColor;
        self.titleLabel.textColor = self.config.textSelectedColor;
    }else {
       self.titleLabel.backgroundColor = self.config.itemColor;
        self.titleLabel.textColor = self.config.textColor;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
