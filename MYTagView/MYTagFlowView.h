//
//  MYTagFlowView.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTagFlowViewModel.h"
#import "MYTagViewConfig.h"
NS_ASSUME_NONNULL_BEGIN
@class MYTagFlowView;
typedef void(^selectedHandler)(NSIndexPath *indexPath,NSString *title,NSMutableArray *selectArray);
typedef void (^deleteActionHandler)(NSIndexPath *indexPath);

@protocol MYTagFlowViewDelegate <NSObject>
@optional

/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForTagFlowView:(MYTagFlowView *)view;

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)baseCell forIndex:(NSIndexPath *)indexPath tagFlowView:(MYTagFlowView *)view;

/** 如果你需要自定义sectionHeader样式，请在实现此代理方法返回你的自定义sectionHeader的class。 */
- (Class)customCollectionElementKindSectionHeaderClassForTagFlowView:(MYTagFlowView *)view;

/** 如果你自定义了sectionHeader样式，请在实现此代理方法为你的sectionHeader填充数据以及其它一系列设置 */
- (void)setupCustomSectionHeader:(UICollectionReusableView *)sectionHeader forIndex:(NSIndexPath *)index tagFlowView:(MYTagFlowView *)view;

/** cell 点击回调*/
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath oldIndexPath:(NSIndexPath *)oldIndexPath;

@end


@interface MYTagFlowView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                       titles:(NSArray *)titles
                sectionTitles:(NSArray *)secTitles
              selectedHandler:(selectedHandler)handler;

- (instancetype)initWithFrame:(CGRect)frame
                       config:(MYTagViewConfig *)config
                       titles:(NSArray *)titles
                sectionTitles:(NSArray *)secTitles
              selectedHandler:(selectedHandler)handler;

- (void)insertWithModel:(MYTagFlowViewModel *)model
                   atSection:(NSUInteger)section
                     atIndex:(NSUInteger)index
                    animated:(BOOL)animated;

- (void)insertWithModels:(NSArray *)models
                    atSection:(NSUInteger)section
                    atIndexes:(NSIndexSet*)indexes
                     animated:(BOOL)animated;

- (void)deleteAtSection:(NSUInteger)section
                atIndex:(NSUInteger)index
                  animated:(BOOL)animated;

- (void)deleteAtSection:(NSUInteger)section
              atIndexes:(NSIndexSet*)indexes
               animated:(BOOL)animated;

- (void)reloadAllWithTitles:(NSArray *)titles;

@property (nonatomic, copy) deleteActionHandler deleteHandler;//删除block
@property (nonatomic, weak) id<MYTagFlowViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;     // 选中的item
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong, readonly) UICollectionView   *collectionView;
@property (nonatomic, strong) MYTagViewConfig *config;

@end

NS_ASSUME_NONNULL_END
