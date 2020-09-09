//
//  TagViewController.h
//  MYTagViewDemo
//
//  Created by libj on 2020/9/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,TagType){
    TagType_radio = 0, // 单选
    TagType_check,     // 多选
    TagType_disable,   // 不可选
    TagType_MaxHeight, // 最大高度
    TagType_Horizontal, //横向
    TagType_header,    //头部
    TagType_item,    //自定义item
    TagType_menu,    //菜单
};
@interface TagViewController : UIViewController
@property (nonatomic, assign) TagType type;
@end

NS_ASSUME_NONNULL_END
