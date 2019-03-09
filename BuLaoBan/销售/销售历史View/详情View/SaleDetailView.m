//
//  SaleDetailView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "SaleDetailView.h"
#import "SaleListTopView.h"
#import "SaleListCell.h"

@interface SaleDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表


@end

@implementation SaleDetailView{
    
    UILabel *_nameLab;  //名称
    UILabel *_memoLab;  //备注
    UILabel *_totolLab; //合计

    NSMutableArray *_labArr; //其余属性

}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _labArr = [NSMutableArray arrayWithCapacity:0];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 16, ScreenWidth-100-32, 28) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(20) textAligment:NSTextAlignmentLeft andtext:@"吉布纺织"];
    [self addSubview:_nameLab];
    
    NSArray *titleArr = @[@"单号：",@"本单应收：",@"日期：",@"本单已收：",@"业务员：",@"本单欠款：",@"类型：",@"结算账户："];
    CGFloat Width = ScreenWidth -400;
    for (int i = 0; i<titleArr.count; i++) {
        int a = i/2;
        int b = i%2;
        
        UILabel *lab  = [BaseViewFactory labelWithFrame:CGRectMake(16+(Width-32)/2*b, 58 +30*a, (Width-32)/2, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
        [self addSubview:lab];
        [_labArr addObject:lab];
        
    }
    UILabel *memolab  = [BaseViewFactory labelWithFrame:CGRectMake(16, 178, 45, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"备注："];
    [self addSubview:memolab];
    
    _memoLab  = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@""];
    [self addSubview:_memoLab];
    
    UIView *lineView = [BaseViewFactory viewWithFrame:CGRectMake(0, 220, Width, 10) color:UIColorFromRGB(BackColorValue)];
    [self addSubview:lineView];
    
    UILabel *detaillab  = [BaseViewFactory labelWithFrame:CGRectMake(16, 230, 200, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(16) textAligment:NSTextAlignmentLeft andtext:@"货品明细"];
    [self addSubview:detaillab];
    
    _totolLab = [BaseViewFactory labelWithFrame:CGRectMake(100, 230, Width-116, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentRight andtext:@"合计：2款, 4匹, 100.00米，"];
    [self addSubview:_totolLab];
    [self addSubview:self.ListTab];
    
}
#pragma mark ====== tableview

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    SaleListTopView *topView = [[SaleListTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 40)];
    return topView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"GoodsListCell";
    SaleListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SaleListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}


#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 280, ScreenWidth-100, ScreenHeight-64-280) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            
        }
    }
    return _ListTab;
    
}

@end
