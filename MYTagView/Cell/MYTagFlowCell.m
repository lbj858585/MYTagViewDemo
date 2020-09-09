//
//  MYTagFlowCell.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTagFlowCell.h"
#import "MYTagViewConfig.h"
#define JKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface MYTagFlowCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation MYTagFlowCell

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
        _titleLabel.backgroundColor = [MYTagViewConfig shareConfig].itemColor;
        _titleLabel.textColor = [MYTagViewConfig shareConfig].textColor;
        _titleLabel.font = [MYTagViewConfig shareConfig].textFont;
        _titleLabel.layer.cornerRadius = [MYTagViewConfig shareConfig].itemCornerRaius;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.layer.borderColor = [MYTagViewConfig shareConfig].borderColor.CGColor;
        _titleLabel.layer.borderWidth = [MYTagViewConfig shareConfig].borderWidth;
    }
    return _titleLabel;
}
@end
