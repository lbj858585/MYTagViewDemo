//
//  MYTagViewConfig.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HeaderFiles.h"
NS_ASSUME_NONNULL_BEGIN

@interface MYTagViewConfig : NSObject

+ (MYTagViewConfig *)shareConfig;

/// 是否可以选中 (默认可以)
@property (nonatomic, assign) BOOL selectMark;
/// 是否多选 (NO 单选，YES 多选，默认多选) 
@property (nonatomic, assign) BOOL multipleMark;

@property (nonatomic) UIEdgeInsets  contentInsets;
/// 文件距离item左右的距离
@property (nonatomic, assign) CGFloat       textMargin;
/// item 之间的行间距
@property (nonatomic, assign) CGFloat       lineSpace;
/// 分组头部高度
@property (nonatomic, assign) CGFloat       sectionHeight;
/// item 的高度
@property (nonatomic, assign) CGFloat       itemHeight;
/// item 的宽度,默认不写，自适应宽度，填写则固定宽度
@property (nonatomic, assign) CGFloat       itemWidth;
/// 文字 的最小宽度
@property (nonatomic, assign) CGFloat       textMinWidth;

/// View 顶部距离
@property (nonatomic, assign) CGFloat       itemTopMargin;
/// View 底部距离
@property (nonatomic, assign) CGFloat       itemBottomMargin;

/// item 之间的竖间距
@property (nonatomic, assign) CGFloat       itemSpace;
/// item 圆角
@property (nonatomic, assign) CGFloat       itemCornerRaius;
/// item 未选中背景颜色
@property (nonatomic, strong) UIColor       *itemColor;
/// item 选中背景颜色
@property (nonatomic, strong) UIColor       *itemSelectedColor;
/// 未选中默认颜色
@property (nonatomic, strong) UIColor       *textColor;
/// 选中文字颜色
@property (nonatomic, strong) UIColor       *textSelectedColor;
/// 文字大小
@property (nonatomic, strong) UIFont        *textFont;
/// 背景颜色
@property (nonatomic, strong) UIColor       *backgroundColor;
/// 边框线未选中颜色
@property (nonatomic, strong) UIColor       *borderColor;
/// 边框线选中颜色
@property (nonatomic, strong) UIColor       *borderSelectColor;
/// 边框线粗细
@property (nonatomic, assign) CGFloat       borderWidth;
/// 滚动方向
@property (nonatomic) UICollectionViewScrollDirection scrollDirection; // default is UICollectionViewScrollDirectionVertical
/// 是否分页
@property (nonatomic, assign) BOOL          pagingEnabled;
/// 单页行数
@property (nonatomic, assign) NSInteger     rowCount;
/// 单页列数
@property (nonatomic, assign) NSInteger     columnCount;
/// 是否显示分页控件
@property (nonatomic, assign) BOOL          showPageControl;

@end

NS_ASSUME_NONNULL_END
