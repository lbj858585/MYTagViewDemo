//
//  MYTagFlowViewLayout.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYTagViewConfig.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MYTagFlowViewLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MYTagFlowViewLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id <MYTagFlowViewLayoutDataSource> dataSource;
@property (nonatomic, strong) MYTagViewConfig *config;
@end

NS_ASSUME_NONNULL_END
