//
//  MYTagViiewConfig.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTagViewConfig.h"

@implementation MYTagViewConfig

+ (MYTagViewConfig *)shareConfig {
    static MYTagViewConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc]init];
    });
    return config;
}

// default

- (instancetype)init {
    self = [super init];
    if (self) {
        self.selectMark = YES;
        self.multipleMark = YES;
        self.lineSpace = 10;
        self.itemHeight = MY(30);
        self.itemSpace = 10;
        self.itemCornerRaius = MY(30)*0.5;
        self.itemColor = [UIColor clearColor];
        self.itemSelectedColor = [UIColor redColor];
        self.textMargin = 40;
        self.textColor = [UIColor redColor];
        self.textSelectedColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor whiteColor];
        self.sectionHeight = 0;
        self.itemTopMargin = 10;
        self.contentInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        self.itemBottomMargin = 0;
        self.borderWidth = 1;
        self.borderColor = [UIColor redColor];
        self.borderSelectColor = [UIColor redColor];
        self.textMinWidth = MY(35);
        self.rowCount = 2;
        self.columnCount = 5;
//        self.itemWidth = (SCREEN_WIDTH-5*10)/4;
    }
    return self;
}

@end
