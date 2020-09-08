//
//  MYHorizontalPageViewLayout.h
//  doctor
//
//  Created by libj on 2020/8/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYHorizontalPageViewLayout : UICollectionViewFlowLayout

/// 单页行数
@property (assign, nonatomic) NSInteger  rowCount;
/// 单页列数
@property (assign, nonatomic) NSInteger  columnCount;

@end

NS_ASSUME_NONNULL_END
