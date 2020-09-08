//
//  MYTagFlowViewModel.h
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYTagFlowViewModel : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) BOOL select;
@end

NS_ASSUME_NONNULL_END
