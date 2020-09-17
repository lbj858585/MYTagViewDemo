//
//  MYPopupMenuView.h
//  doctor
//
//  Created by libj on 2020/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^handlerBlock)(NSInteger index);

@interface MYPopupMenuView : UIView
/// item 文字
@property (nonatomic, copy) NSArray *itemsTitle;
/// item 图片
@property (nonatomic, copy) NSArray *itemsImages;
/// item 里文字的字体
@property (nonatomic, strong, nullable) UIFont *itemTitleFont;
/// item 里文字的颜色
@property (nonatomic, strong, nullable) UIColor *itemTitleColor;
/// 是否展示箭头 默认展示
@property (nonatomic, assign) BOOL showArrow;
/// 向指定的View的底部间距
@property (nonatomic, assign) CGFloat marginY;
/// 每个 item 的统一高度，默认为 44。
@property (nonatomic, assign) CGFloat itemHeight;
/// 弹窗靠边显示时的边距 默认为1
@property (nonatomic, assign) CGFloat menuViewMargin;
/// 有图片时 文字和图片的间距 默认 15
@property (nonatomic, assign) CGFloat titleLeftEdge;

@property (nonatomic, copy) handlerBlock handler;

/// 指向指定的View来显示弹窗
/// @param pointView 箭头指向的View
/// @param handler 选中回调
- (void)showToView:(UIView *)pointView handler:(handlerBlock)handler;
@end


@interface MYPopupMenuViewItemCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImage;
@property (nonatomic, assign) BOOL showIcon;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) CGFloat titleLeftEdge;
@end
NS_ASSUME_NONNULL_END
