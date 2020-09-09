//
//  MYTagFlowCell.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTagViewConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface MYTagFlowCell : UICollectionViewCell

/** 是否选中 */
@property (nonatomic, assign) BOOL beSelected;
@property (nonatomic, strong) MYTagViewConfig *config;
- (void)configCellWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
