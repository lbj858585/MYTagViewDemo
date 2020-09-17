//
//  MYPopupMenuView.m
//  doctor
//
//  Created by libj on 2020/4/10.
//

#import "MYPopupMenuView.h"

@interface MYPopupMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIControl *mskView; //遮罩
@property (nonatomic, strong) UIView *cntView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, assign) CGPoint toPoint;
@property (nonatomic, assign) CGFloat height;
@end
@implementation MYPopupMenuView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBaseAttribute];
        
    }
    return self;
}

- (void) setBaseAttribute {
    self.itemHeight = 44;
    self.itemTitleFont = [UIFont systemFontOfSize:MY(14)];
    self.itemTitleColor = [UIColor whiteColor];
    self.showArrow = YES;
    self.titleLeftEdge = 15;
    self.menuViewMargin = 1;
}

- (void) setupSubviews {
    [self addSubview:self.mskView];
    [self addSubview:self.cntView];
    [self.cntView addSubview:self.bgImageView];
    [self.cntView addSubview:self.tableView];
}

- (void) setupSubviewsLayout {
    
    [self.mskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    CGFloat currentW = [self calculateMaxWidth];
    CGFloat currentX = self.toPoint.x - currentW/2;
    // 窗口靠左
    if (self.toPoint.x <= currentW/2 + self.menuViewMargin) {
        currentX = self.menuViewMargin;
    }
    //  窗口靠右
    if (SCREEN_WIDTH - self.toPoint.x <= currentW/2 + self.menuViewMargin) {
        currentX = SCREEN_WIDTH - currentW - self.menuViewMargin;
    }
    
    [self.cntView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(currentX);
        make.width.equalTo(currentW);
        make.height.equalTo(self.height);
        make.top.offset(NavigationBar_StatusBar_Height+self.marginY);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cntView);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cntView);
    }];
}

- (void)showWithAnimationWithHandler:(handlerBlock)handler {
    self.handler = handler;
    [self setupSubviews];
    [self setupSubviewsLayout];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.mskView.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.mskView.alpha = 1;
        self.cntView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showToView:(UIView *)pointView handler:(handlerBlock)handler {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect pointViewRect = [pointView.superview convertRect:pointView.frame toView:keyWindow];
    
    CGFloat height = 0;
    CGFloat maskTop = 0;
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    if (self.itemsTitle.count>5) {
        height = self.itemHeight * 5;
    }else {
        height = self.itemHeight * self.itemsTitle.count;
        self.tableView.scrollEnabled = NO;
    }
    self.height = height;

    if (height + CGRectGetMaxY(pointViewRect)+10<SCREEN_HEIGHT) {
        NSLog(@"朝下");
        maskTop = CGRectGetMaxY(pointViewRect)+self.marginY; //顶部Y值
        CGPoint toPoint = CGPointMake(CGRectGetMidX(pointViewRect), maskTop);
        self.toPoint = toPoint;
        // 起点
        [linePath moveToPoint:toPoint];
        // 其他点
        [linePath addLineToPoint:CGPointMake(toPoint.x-8, maskTop+10)];
        [linePath addLineToPoint:CGPointMake(toPoint.x+8, maskTop+10)];
        [linePath closePath];
        // 重设顶部距离
        maskTop += 10;
    }else {
        NSLog(@"朝上");
        maskTop = CGRectGetMinY(pointViewRect)-10-self.marginY; //顶部Y值
        CGPoint toPoint = CGPointMake(CGRectGetMidX(pointViewRect), maskTop);
        self.toPoint = toPoint;
        // 起点
        [linePath moveToPoint:CGPointMake(toPoint.x-8, maskTop)];
        // 其他点
        [linePath addLineToPoint:CGPointMake(toPoint.x+8, maskTop)];
        [linePath addLineToPoint:CGPointMake(toPoint.x, maskTop+10)];
        [linePath closePath];
        // 重设顶部距离
        maskTop -= height; //顶部Y值
    }
   
    [self showWithAnimationWithHandler:handler];
    [self.mskView layoutIfNeeded];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor blackColor].CGColor;
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = [UIColor blackColor].CGColor; // 默认为blackColor
    if (self.showArrow) {
        [self.mskView.layer addSublayer:lineLayer];
    }
   
    self.bgImageView.image = nil;
    [self.cntView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maskTop);
    }];
}

#pragma mark - 计算最大宽度
- (CGFloat)calculateMaxWidth {
    CGFloat maxWidth = 0.f, titleLeftEdge = 0.f, imageWidth = 0.f, imageHeight = self.itemHeight-26;
    
    for (int i = 0;i<self.itemsTitle.count;i++) {
        NSString *title = self.itemsTitle[i];
        imageWidth = 0.f;
        titleLeftEdge = 0.f;
        if (self.itemsImages.count) {
            titleLeftEdge = self.titleLeftEdge;
            imageWidth = imageHeight;
        }
        CGFloat titleWidth;
        titleWidth = [title sizeWithAttributes:@{NSFontAttributeName : self.itemTitleFont}].width;
        NSLog(@"----%f",titleWidth);
        CGFloat contentWidth = 16*2 + imageWidth + titleLeftEdge + titleWidth;
        if (contentWidth > maxWidth) {
            maxWidth = ceil(contentWidth); // 获取最大宽度时需使用进一取法, 否则Cell中没有图片时会可能导致标题显示不完整.
        }
    }
    
    return maxWidth;
}
- (void) mskViewClickAction:(UIControl *)sender {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.mskView.alpha = 0;
        self.cntView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYPopupMenuViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MYPopupMenuViewItemCell class])];
    
    if(!cell) {
        cell = [[MYPopupMenuViewItemCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([MYPopupMenuViewItemCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row < self.itemsImages.count) {
         cell.iconImage.image = [UIImage imageNamed:self.itemsImages[indexPath.row]];
    }
    cell.titleLabel.text = self.itemsTitle[indexPath.row];
    cell.titleLabel.font = self.itemTitleFont;
    cell.titleLabel.textColor = self.itemTitleColor;
    cell.titleLeftEdge = self.titleLeftEdge;
    cell.backgroundColor = [UIColor clearColor];
    cell.showIcon = self.itemsImages.count?YES:NO;
    cell.lineView.hidden = (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1)?YES:NO;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.handler(indexPath.row);
    [self mskViewClickAction:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemHeight;
}
#pragma mark - lazy
- (UIControl *)mskView {
    if(!_mskView){
        _mskView = [[UIControl alloc] init];
        _mskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        [_mskView addTarget:self action:@selector(mskViewClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mskView;
}

- (UIView *)cntView {
    if( !_cntView){
        _cntView = [[UIView alloc] init];
        _cntView.alpha = 0;
        _cntView.backgroundColor = [UIColor clearColor];
    }
    return _cntView;
}
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [UIImageView new];
        _bgImageView.image = [[UIImage imageNamed:@"icon_pop"] resizableImageWithCapInsets:UIEdgeInsetsMake(17, 10, 10, 20) resizingMode:UIImageResizingModeStretch];;
    }
    return _bgImageView;
}
- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorColor = [UIColor colorWithRed:89/250.0 green:89/250.0 blue:89/250.0 alpha:1.0];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
        _tableView.layer.cornerRadius = 3;
        _tableView.clipsToBounds = YES;
        _tableView.backgroundColor = [UIColor blackColor];
    }
    return _tableView;
}

@end


@implementation MYPopupMenuViewItemCell

#pragma mark - Cell生命周期
/** 0 init 带参数初始化  */
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if(self){
        [self setBaseAttribute];
        [self setupSubviews];
        [self setupSubviewsLayout];
    }
    return self;
}

- (void) setBaseAttribute {
    
}

- (void) setupSubviews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.lineView];
}

- (void) setupSubviewsLayout {
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.top.offset(13);
        make.bottom.offset(-13);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset(15);
        make.right.offset(-16);
        make.top.bottom.offset(0);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.right.bottom.offset(0);
        make.height.equalTo(0.5);
    }];
    
    [self.iconImage setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setShowIcon:(BOOL)showIcon {
    _showIcon = showIcon;
    if (!showIcon) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
        }];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }else{
        [self.iconImage layoutIfNeeded];
        [self.iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.iconImage.frame.size.height);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImage.mas_right).offset(self.titleLeftEdge);
        }];
    }
    
}
#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}
- (UIImageView *)iconImage  {
    if (!_iconImage) {
        _iconImage = [UIImageView new];
    }
    return _iconImage;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:89/250.0 green:89/250.0 blue:89/250.0 alpha:1.0];
    }
    return _lineView;
}
@end
