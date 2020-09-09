//
//  HeaderFiles.h
//  MYTagViewDemo
//
//  Created by libj on 2020/9/9.
//  Copyright © 2020 Libj. All rights reserved.
//

#ifndef HeaderFiles_h
#define HeaderFiles_h

// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND3
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
// 这个头文件一定要放在上面两个宏的后面
#import <Masonry/Masonry.h>

//屏幕相关
#define WIN self.window
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define MY(parameter) ((parameter) * SCREEN_WIDTH / 375.0)
#define MY_MARGIN MY(10)
#define MY_PADDING MY(8)
#define MY_PADDING_LEFT MY(10)
#define MY_PADDING_RIGHT MY(10)
#define MY_PADDING_TOP MY(8)
#define MY_PADDING_BOTTOM MY(8)
#define MY_RADIUS 5

#endif /* HeaderFiles_h */
