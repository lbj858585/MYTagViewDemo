//
//  TagViewController.m
//  MYTagViewDemo
//
//  Created by libj on 2020/9/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "TagViewController.h"
#import "MYTagFlowView.h"
#import "Masonry.h"
@interface TagViewController ()<MYTagFlowViewDelegate>
@property (nonatomic, strong) MYTagFlowView *recordView;
@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseAttribute];
    [self setupSubviews];
    [self setupSubviewsLayout];
    [self initData];
}

- (void) setBaseAttribute {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void) setupSubviews {
    self.recordView = [[MYTagFlowView alloc] initWithFrame:CGRectZero titles:@[] sectionTitles:@[@"规格"] selectedHandler:^(NSIndexPath *indexPath, NSString *title,NSMutableArray *selectArray) {
        NSLog(@"%@",selectArray);
    }];
    self.recordView.delegate = self;
    self.recordView.selectMark = NO;
    self.recordView.multipleMark = YES;
    [self.view addSubview:self.recordView];
}

- (void) setupSubviewsLayout {
    
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.view).offset(88);
    }];
}

- (void)initData {
    NSArray *array = @[@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试",@"测试"];
    NSMutableArray *rowArray = [NSMutableArray array];
    for (NSString *str in array) {
        MYTagFlowViewModel *model = [MYTagFlowViewModel new];
        model.title = str;
        [rowArray addObject:model];
    }
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObjectsFromArray:rowArray];
    [self.recordView reloadAllWithTitles:sectionArray];
}
@end
