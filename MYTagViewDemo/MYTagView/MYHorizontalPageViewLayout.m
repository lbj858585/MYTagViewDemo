//
//  MYHorizontalPageLayout.m
//  doctor
//
//  Created by libj on 2020/8/7.
//

#import "MYHorizontalPageViewLayout.h"
@interface MYHorizontalPageViewLayout()

@property (strong, nonatomic) NSMutableArray<UICollectionViewLayoutAttributes *>  *layoutAttributes;


@end


@implementation MYHorizontalPageViewLayout

#pragma mark - Layout
// 布局前准备
- (void)prepareLayout {
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    // 获取所有布局
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.layoutAttributes addObject:attr];
    }
    
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger item = indexPath.item;
    // 总页数
    NSInteger pageNumber = item / (self.rowCount * self.columnCount);
    // 该页中item的序号
    NSInteger itemInPage = item % (self.rowCount * self.columnCount);
    // item的所在列、行
    NSInteger col = itemInPage % self.columnCount;
    NSInteger row = itemInPage / self.columnCount;
    if (isinf(self.minimumInteritemSpacing)) {
        self.minimumInteritemSpacing = 10;
    }
    CGFloat x = self.sectionInset.left + (self.itemSize.width + self.minimumInteritemSpacing)*col + pageNumber * self.collectionView.bounds.size.width;
    CGFloat y = self.sectionInset.top + (self.itemSize.height + self.minimumLineSpacing)*row ;
    
    attri.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    
    
    return attri;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    if (itemCount) {
        NSInteger pageNumber = itemCount / (self.rowCount * self.columnCount);
        if (itemCount%(self.rowCount*self.columnCount)) {
            pageNumber += 1;
        }
        if (itemCount > self.columnCount) {
           return CGSizeMake(pageNumber * self.collectionView.bounds.size.width, self.itemSize.height*self.rowCount+(self.minimumLineSpacing*(self.rowCount-1)));
        }else {
            return CGSizeMake(pageNumber * self.collectionView.bounds.size.width, self.itemSize.height);
        }
        
    }
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);

}

#pragma mark - Getter
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)layoutAttributes {
    if (_layoutAttributes == nil) {
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}

// 根据itemSize lineSpacing sectionInsets collectionView frame计算取得
- (NSInteger)rowCount {
    if (_rowCount == 0) {
        
        NSInteger numerator = self.collectionView.bounds.size.height - self.sectionInset.top - self.sectionInset.bottom + self.minimumLineSpacing;
        NSInteger denominator = self.minimumLineSpacing + self.itemSize.height;
        NSInteger count = numerator/denominator;
        _rowCount = count;
        // minimumLineSpacing itemSize.height不是刚好填满 将多出来的补给minimumLineSpacing
        if (numerator % denominator) {
            self.minimumLineSpacing = (self.collectionView.bounds.size.height - self.sectionInset.top-self.sectionInset.bottom - count * self.itemSize.height) / (CGFloat)(count - 1);
        }
    }
    return _rowCount;
}
// 根据itemSize minimumInteritemSpacing sectionInsets collectionView frame计算取得
- (NSInteger)columnCount {
    if (_columnCount == 0) {
        
        NSInteger numerator = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right + self.minimumInteritemSpacing;
        NSInteger denominator = self.minimumInteritemSpacing + self.itemSize.width;
        NSInteger count = numerator/denominator;
        _columnCount = count;
        
        // minimumInteritemSpacing itemSize.width不是刚好填满 将多出来的补给minimumInteritemSpacing
        if (numerator % denominator) {
            self.minimumInteritemSpacing = (self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right - count * self.itemSize.width) / (CGFloat)(count - 1);
        }
    }
    return _columnCount;
}

@end
