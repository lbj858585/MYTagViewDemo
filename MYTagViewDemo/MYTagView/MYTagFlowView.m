//
//  MYTagFlowView.m
//  test
//
//  Created by libj on 2020/6/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "MYTagFlowView.h"
#import "MYTagFlowViewLayout.h"
#import "MYHorizontalPageViewLayout.h"
#import "MYTagViewConfig.h"
#import "MYTagFlowHeaderView.h"
#import "MYTagFlowCell.h"
#import <Masonry.h>
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"flowHeaderID";

@interface MYTagFlowView () <UICollectionViewDataSource, UICollectionViewDelegate, MYTagFlowViewLayoutDataSource>

@property (nonatomic, strong) UICollectionView   *collectionView;
@property (nonatomic, strong) NSMutableArray     *data;
@property (nonatomic, strong) NSArray            *sectionData;
@property (nonatomic, assign) NSInteger numberCount;
@property (nonatomic, copy)   selectedHandler  handler;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSMutableArray *selectArray;
@end

@implementation MYTagFlowView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles sectionTitles:(NSArray *)secTitles selectedHandler:(selectedHandler)handler {
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (!titles) {
           self.data = @[@[]].mutableCopy;
        }else if (!titles.count || ![titles[0] isKindOfClass:[NSArray class]]) {
            self.data = @[titles].mutableCopy;
        }else {
           self.data = [titles mutableCopy];
        }
        
        self.sectionData = secTitles;
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame config:(MYTagViewConfig *)config titles:(NSArray *)titles sectionTitles:(NSArray *)secTitles selectedHandler:(selectedHandler)handler {
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        if (!titles) {
           self.data = @[@[]].mutableCopy;
        }else if (!titles.count || ![titles[0] isKindOfClass:[NSArray class]]) {
            self.data = @[titles].mutableCopy;
        }else {
           self.data = [titles mutableCopy];
        }
        self.config = config;
        self.sectionData = secTitles;
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    if (_config == nil) {
        self.config = [MYTagViewConfig shareConfig];
    }
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(SCREEN_WIDTH);
        make.top.equalTo(self).offset(self.config.itemTopMargin);
        make.bottom.offset(-self.config.itemBottomMargin).priorityHigh();
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.centerX.equalTo(self);
        make.height.equalTo(10);
    }];
}

- (void)reloadAllWithTitles:(NSArray *)titles {
    if (!titles.count || ![titles[0] isKindOfClass:[NSArray class]]) {
        self.data = @[titles].mutableCopy;
    }else {
        self.data = [titles mutableCopy];
    }
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    
    if (height>self.maxHeight && self.maxHeight>0) {
        height = self.maxHeight;
    }
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger pageNumber = itemCount / (self.config.rowCount * self.config.columnCount);
    if (itemCount%(self.config.rowCount*self.config.columnCount)) {
        pageNumber += 1;
    }
    self.pageControl.numberOfPages = self.config.showPageControl?pageNumber:1;
    NSLog(@"height - %f,maxHeight - %f",height,self.maxHeight);
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
        make.bottom.offset(-self.config.itemBottomMargin).priorityHigh();
    }];
    if(pageNumber == 1 && self.config.showPageControl) {
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
           make.bottom.offset(-5).priorityHigh();
        }];
    }
}


- (void)setSelectMark:(BOOL)selectMark {
    _selectMark = selectMark;
}

- (void)setDelegate:(id<MYTagFlowViewDelegate>)delegate {
    _delegate = delegate;
    
    if ([self.delegate respondsToSelector:@selector(customCollectionViewCellClassForTagFlowView:)] && [self.delegate customCollectionViewCellClassForTagFlowView:self]) {
        [self.collectionView registerClass:[self.delegate customCollectionViewCellClassForTagFlowView:self] forCellWithReuseIdentifier:cellId];
    }
    
    if ([self.delegate respondsToSelector:@selector(customCollectionElementKindSectionHeaderClassForTagFlowView:)] && [self.delegate respondsToSelector:@selector(setupCustomSectionHeader:forIndex:tagFlowView:)]) {
        [self.collectionView registerClass:[self.delegate customCollectionElementKindSectionHeaderClassForTagFlowView:self] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
}
#pragma mark - collectionview 代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *array = self.data[section];
    return array.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.config.sectionHeight) {
        if (kind == UICollectionElementKindSectionHeader) {
            MYTagFlowHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
            
            if ([self.delegate respondsToSelector:@selector(customCollectionElementKindSectionHeaderClassForTagFlowView:)] &&[self.delegate respondsToSelector:@selector(setupCustomSectionHeader:forIndex:tagFlowView:)]) {
                [self.delegate setupCustomSectionHeader:header forIndex:indexPath tagFlowView:self];
                return header;
            }
            header.indexPath = indexPath;
            header.haveDeleteBtn = indexPath.section == 0 ? YES : NO;

            if (self.sectionData.count) {
                header.titleString = self.sectionData[indexPath.section];
            }
            header.deleteActionBlock = ^(NSIndexPath *indexPath) {
                if (self.deleteHandler) {
                    self.deleteHandler(indexPath);
                }
            };
            return header;
        }
    }
    
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYTagFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if ([cell isKindOfClass:[MYTagFlowCell class]]) {
        cell.config = self.config;
    }
    if ([self.delegate respondsToSelector:@selector(setupCustomCell:forIndex:tagFlowView:)] &&
        [self.delegate respondsToSelector:@selector(customCollectionViewCellClassForTagFlowView:)] && [self.delegate customCollectionViewCellClassForTagFlowView:self]) {
        [self.delegate setupCustomCell:cell forIndex:indexPath tagFlowView:self];
        return cell;
    }
    if (self.data.count) {
        NSArray *array = self.data[indexPath.section];
        MYTagFlowViewModel *model = array[indexPath.item];
        cell.beSelected = model.select;
        [cell configCellWithTitle:model.title];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:oldIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath oldIndexPath:_selectIndexPath];
        //记录当前选中的位置
        _selectIndexPath = indexPath;
    }else {

        if (self.selectMark && self.multipleMark == NO) {
            MYTagFlowCell *oldCell = (MYTagFlowCell *)[collectionView cellForItemAtIndexPath:_selectIndexPath];
            oldCell.beSelected = NO;
            //当前选择的打勾
            MYTagFlowCell *cell = (MYTagFlowCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.beSelected = YES;
        }else if (self.selectMark && self.multipleMark) {
            MYTagFlowCell *cell = (MYTagFlowCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.beSelected = !cell.beSelected;
            NSArray *array = self.data[indexPath.section];
            MYTagFlowViewModel *model = array[indexPath.item];
            model.select = cell.beSelected;
        }
        if (self.handler && self.selectMark) {
            NSString *title = @"";
            NSArray *array = self.data[indexPath.section];
            MYTagFlowViewModel *model = array[indexPath.item];
            title = model.title;
            if (self.multipleMark && model.select) {
                [self.selectArray addObject:model];
            }else if (self.multipleMark&& model.select == NO) {
                [self.selectArray removeObject:model];
            }else {
                if (indexPath != _selectIndexPath) {
                    self.selectArray[0] = model;
                }
            }
            self.handler(indexPath, title,self.selectArray);
        }
        
        //记录当前选中的位置
        _selectIndexPath = indexPath;
    }
}

#pragma mark - MSSAutoresizeLabelFlowLayout 代理方法
- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.itemWidth) {
        return @"  ";
    }
    NSArray *array = self.data[indexPath.section];
    MYTagFlowViewModel *model = array[indexPath.item];
    return model.title;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.pageControl.isHidden) {
        if (!self.data.count) return; 
        int index = [self currentIndex];
        self.pageControl.currentPage = index;
    }
}

- (int)currentIndex {
    int index = 0;
    if (self.config.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = self.collectionView.contentOffset.x/ SCREEN_WIDTH;
    }
    return MAX(0, index);
}
#pragma mark - lazy
-(UICollectionView *)collectionView{
    
    if ( !_collectionView) {
        if (self.config.pagingEnabled && self.config.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            MYHorizontalPageViewLayout *layout = [[MYHorizontalPageViewLayout alloc] init];
            layout.sectionInset = self.config.contentInsets;
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = 0;
//            layout.rowCount = 2;
            layout.rowCount = self.config.rowCount;
            CGFloat width = self.config.itemWidth;
            CGFloat height = self.config.itemHeight;
            CGSize size = CGSizeMake(width,height);
            layout.itemSize = size;
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }else {
            MYTagFlowViewLayout *layout = [[MYTagFlowViewLayout alloc] init];
            layout.dataSource = self;
            if (!self.config) {
                self.config = [[MYTagViewConfig alloc] init];
            }
            layout.config = self.config;
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MYTagFlowCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = self.config.backgroundColor;
        _collectionView.pagingEnabled = self.config.pagingEnabled;
        _collectionView.scrollsToTop = NO;
    }
    return _collectionView;
}

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.hidden = !self.config.showPageControl;
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}
@end
