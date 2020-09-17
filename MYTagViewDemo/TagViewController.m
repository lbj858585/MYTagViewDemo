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
#import "MYTestCollectionViewCell.h"
#import "MYCollegeItemCell.h"
@interface TagViewController ()<MYTagFlowViewDelegate>
@property (nonatomic, strong) MYTagFlowView *recordView;
@property (nonatomic, strong) MYTagViewConfig *config;
@property (nonatomic, strong) NSMutableArray *sectionArray;
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
    [self.view addSubview:self.recordView];
}
- (void)setType:(TagType)type {
    _type = type;
    self.config = [MYTagViewConfig new];
    if (type == TagType_radio) {
         self.config.selectMark = YES;
       self.config.multipleMark = NO;
    }else if (type == TagType_check) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MYTagFlowViewModel *model = [MYTagFlowViewModel new];
            model.title = @"蜜汁";
            [self.recordView insertWithModel:model atSection:0 atIndex:23 animated:YES];
        });
        
    }else if (type == TagType_disable) {
        self.config.selectMark = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MYTagFlowViewModel *model = [MYTagFlowViewModel new];
            model.title = @"蜜汁";
            
            MYTagFlowViewModel *model2 = [MYTagFlowViewModel new];
            model2.title = @"蜜汁2";
            
            NSMutableIndexSet *set = [[NSMutableIndexSet alloc] init];
            [set addIndex:1];
            [set addIndex:5];
            [self.recordView insertWithModels:@[model,model2] atSection:0 atIndexes:set animated:YES];
        });
    }else if (type == TagType_MaxHeight) {
        self.recordView.maxHeight = 200;
    }else if (type == TagType_Horizontal) {
        self.config.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }else if (type == TagType_header) {
        self.config.sectionHeight = 40;

    }else if (type == TagType_item) {
        self.config.itemCornerRaius = 5;
        self.config.itemSelectedColor = [UIColor blueColor];
        self.recordView.delegate = self;
    }else if (type == TagType_menu) {
        self.config.itemHeight = MY(70);
        self.config.itemTopMargin = 0;
        self.config.pagingEnabled = YES;
        self.config.rowCount = 2;
        self.config.columnCount = 5;
        self.config.itemBottomMargin = MY(20);
        self.config.showPageControl = YES;
        CGFloat width = (SCREEN_WIDTH-((self.config.columnCount+1)*MY_PADDING_RIGHT))/self.config.columnCount;
        self.config.itemWidth = width;
        self.config.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.config.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.config.pagingEnabled = YES;
        self.recordView.delegate = self;
    }

}
- (void) setupSubviewsLayout {
    [self.recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.view).offset(88);
    }];
}

- (void)initData {
    
    if (self.type == TagType_menu) {
        NSArray *array = @[@"测试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测",@"测试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测",@"测试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测"];
        NSMutableArray *rowArray = [NSMutableArray array];
        for (NSString *str in array) {
            MYTagFlowViewModel *model = [MYTagFlowViewModel new];
            model.title = str;
            model.icon = @"11";
            [rowArray addObject:model];
        }
        NSMutableArray *sectionArray = [NSMutableArray array];
        [sectionArray addObject:rowArray];
        self.sectionArray = sectionArray;
        [self.recordView reloadAllWithTitles:sectionArray];
        return;
    }
    NSArray *array = @[@"测试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测",@"测试测试测试测试",@"测试测试",@"测测试试",@"测试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测",@"测试测试测试测试",@"测试测试",@"测测试试",@"测试测试",@"测试测试测试",@"测试测",@"测试测试测",@"测试测试测试测试",@"测试测试",@"测测试试"];
    NSMutableArray *rowArray = [NSMutableArray array];
    for (NSString *str in array) {
        MYTagFlowViewModel *model = [MYTagFlowViewModel new];
        model.title = str;
        [rowArray addObject:model];
    }
    NSMutableArray *sectionArray = [NSMutableArray array];
    [sectionArray addObject:rowArray];
    self.sectionArray = sectionArray;
    [self.recordView reloadAllWithTitles:sectionArray];
}


/** 如果你需要自定义cell样式，请在实现此代理方法返回你的自定义cell的class。 */
- (Class)customCollectionViewCellClassForTagFlowView:(MYTagFlowView *)view {
    if (self.type == TagType_menu) {
        return [MYCollegeItemCell class];
    }
    return  [MYTestCollectionViewCell class];
}

/** 如果你自定义了cell样式，请在实现此代理方法为你的cell填充数据以及其它一系列设置 */
- (void)setupCustomCell:(UICollectionViewCell *)baseCell forIndex:(NSIndexPath *)indexPath tagFlowView:(MYTagFlowView *)view {
   
    if (self.type == TagType_menu) {
       MYCollegeItemCell *cell = (MYCollegeItemCell *)baseCell;
       NSArray *array = self.sectionArray[indexPath.section];
       MYTagFlowViewModel *model = array[indexPath.item];
        cell.titleText = model.title;
        cell.iconName = model.icon;
    }else{
        MYTestCollectionViewCell *cell = (MYTestCollectionViewCell *)baseCell;
        NSArray *array = self.sectionArray[indexPath.section];
        MYTagFlowViewModel *model = array[indexPath.item];
        cell.config = self.config;
        cell.beSelected = model.select;
        [cell configCellWithTitle:model.title];
    }
    
    
}
#pragma mark - lazy
- (MYTagFlowView *)recordView {
    if (!_recordView) {
        
        _recordView = [[MYTagFlowView alloc] initWithFrame:CGRectZero config:self.config titles:@[] sectionTitles:@[@"规格"] selectedHandler:^(NSIndexPath * _Nonnull indexPath, NSString * _Nonnull title, NSMutableArray * _Nonnull selectArray) {
            
        }];
    }
    return _recordView;
}
@end
