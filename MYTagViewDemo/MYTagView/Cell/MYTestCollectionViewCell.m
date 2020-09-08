//
//  MYTestCollectionViewCell.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTestCollectionViewCell.h"
#import "MYTagViewConfig.h"
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
    
}

- (void) setupSubviewsLayout {
    
}
- (void)setBeSelected:(BOOL)beSelected {
    _beSelected = beSelected;
    if (beSelected) {
        self.contentView.backgroundColor = [MYTagViewConfig shareConfig].itemSelectedColor;
    }else {
       self.contentView.backgroundColor = [MYTagViewConfig shareConfig].itemColor;
    }
}
@end
