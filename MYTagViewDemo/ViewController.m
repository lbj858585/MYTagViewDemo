//
//  ViewController.m
//  MYTagViewDemo
//
//  Created by libj on 2020/9/8.
//  Copyright © 2020 Libj. All rights reserved.
//

#import "ViewController.h"
#import "TagViewController.h"
#import "Masonry.h"
#import "MenuController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *titles;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBaseAttribute];
    [self setupSubviews];
    [self setupSubviewsLayout];
}

- (void) setBaseAttribute {
    self.title = @"MYTagView";
    self.titles = @[@"单选",@"多选",@"不可选",@"最高限制",@"横向",@"带分组头部",@"自定义item",@"分页",@"菜单弹窗"];
}

- (void) setupSubviews {
    [self.view addSubview:self.tableView];
}

- (void) setupSubviewsLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        MenuController *vc = [MenuController new];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    TagViewController *vc = [TagViewController new];
    vc.type = indexPath.row;
    vc.title = self.titles[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44;
    }
    return _tableView;
}
@end
