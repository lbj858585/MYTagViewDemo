//
//  MYTagFlowHeaderView.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYTagFlowHeaderView : UICollectionReusableView
@property (nonatomic, assign) BOOL haveDeleteBtn;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) NSIndexPath *indexPath;

//@property (nonatomic, weak) id <XDAutoresizeLabelFlowHeaderDelegate>delegate;
@property (nonatomic, copy) void (^deleteActionBlock)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
