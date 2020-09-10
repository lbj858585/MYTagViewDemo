# MYTagViewDemo
简单的标签选择，支持自动布局，横向滚动，最大高度，功能菜单分页，自定义选项框
#### MYTagView 使用
在需要使用的地方  `#import <MYTagView.h>`

初始化
```
- (MYTagFlowView *)recordView {
    if (!_recordView) {
        
        _recordView = [[MYTagFlowView alloc] initWithFrame:CGRectZero config:self.config titles:@[] sectionTitles:@[@"规格"] selectedHandler:^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull title, NSMutableArray * _Nonnull selectArray) {
            
        }];
    }
    return _recordView;
}
```
刷新数据
```
[self.recordView reloadAllWithTitles:sectionArray];
```
使用 MYTagViewConfig 实现不同的效果
```
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
@property (nonatomic, assign) BOOL pagingEnabled;
/// 单页行数
@property (nonatomic, assign) NSInteger rowCount;
/// 单页列数
@property (nonatomic, assign) NSInteger columnCount;
/// 是否显示分页控件
@property (nonatomic, assign) BOOL showPageControl;
```

效果图
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/1.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/2.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/3.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/4.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/5.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/6.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/7.gif)
![Alt text](https://github.com/lbj858585/MYTagViewDemo/blob/master/images/8.gif)
#### 安装 
1. CocoaPods安装：
```
pod 'MYTagView' 
```
2. 下载ZIP包,将MYTagView资源文件拖到工程中。
