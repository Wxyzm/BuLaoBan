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
#import "SellOrderDeliverDetail.h"
#import "PackingListView.h"//细码单填写View
#import "DeliveDetails.h"
@interface SaleDetailView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@property (nonatomic, strong) PackingListView *packingListView;     //细码单填写

@end

@implementation SaleDetailView{
    
    UILabel *_nameLab;  //名称
    UILabel *_memoLab;  //备注
    UILabel *_totolLab; //合计
    UILabel *_memolab;
    NSMutableArray *_dataArr;
    NSMutableArray *_labArr; //其余属性
    

}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _labArr = [NSMutableArray arrayWithCapacity:0];
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 16, ScreenWidth-100-32, 28) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(20) textAligment:NSTextAlignmentLeft andtext:@""];
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
    _memolab  = [BaseViewFactory labelWithFrame:CGRectMake(16, 178, ScreenWidth-400-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"备注："];
    [self addSubview:_memolab];
    
    _memoLab  = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@""];
    [self addSubview:_memoLab];
    
    UIView *lineView = [BaseViewFactory viewWithFrame:CGRectMake(0, 220, Width, 10) color:UIColorFromRGB(BackColorValue)];
    [self addSubview:lineView];
    
    UILabel *detaillab  = [BaseViewFactory labelWithFrame:CGRectMake(16, 230, 200, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(16) textAligment:NSTextAlignmentLeft andtext:@"货品明细"];
    [self addSubview:detaillab];
    
    _totolLab = [BaseViewFactory labelWithFrame:CGRectMake(100, 230, Width-116, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentRight andtext:@"合计：0款, 0匹, 0.00米，"];
    [self addSubview:_totolLab];
    [self addSubview:self.ListTab];
    
}

-(void)setModel:(SellOrderDeliverDetail *)model{
    _model = model;
    _nameLab.text = model.customerName;
    _memolab.text = [NSString stringWithFormat:@"备注：%@",model.remark];
    NSString *receivablePrice = [NSString stringWithFormat:@"%.2f",[model.depositPrice floatValue]+[model.receivablePrice floatValue]];
    NSArray *titleArr = @[@"单号：",@"本单应收：",@"日期：",@"本单已收：",@"业务员：",@"本单欠款：",@"类型：",@"结算账户："];
    NSString *money = [NSString stringWithFormat:@"%.2f",[model.receivablePrice floatValue]- [model.receiptPrice floatValue]];
    NSString *kind = [model.type intValue]==0?@"剪样":@"大货";
    NSArray *valueArr = @[model.deliverNo,receivablePrice,model.deliverDate,model.depositPrice,model.sellerName,money,kind,model.companyAccountName];

    for (int i = 0; i<_labArr.count; i++) {
        UILabel *lab = _labArr[i];
        lab.text = [NSString stringWithFormat:@"%@%@",titleArr[i],valueArr[i]];
    }
    
    
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:model.details];
    int a = 0;
    float b = 0.00;
    for (DeliveDetails *tmodel in _dataArr) {
        a +=[tmodel.packageNum intValue];
        b+=[tmodel.num floatValue];
    }
    _totolLab.text = [NSString stringWithFormat:@"合计：%ld款, %d匹, %.2f米，",_dataArr.count,a,b];
    [self.ListTab reloadData];
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
    return _dataArr.count;
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
    cell.deliveDetails = _dataArr[indexPath.row];
    if (cell.deliveDetails.packingList.length>0) {
        //若新增了细码单，则无法输入米数和匹数销货量，且总码单是细码单算出来的（匹数和米数）
        [cell.codeListBtn setTitle:@"查看" forState:UIControlStateNormal];
    }else{
        [cell.codeListBtn setTitle:@"无" forState:UIControlStateNormal];
    }
    
    cell.returnBlock = ^(SaleSamModel * _Nonnull model, NSInteger type) {
        if (type==1){
            //添加细码单
            DeliveDetails *model =  _dataArr[indexPath.row];
            if (model.packingList.length>0) {
                self.packingListView.deliveDetails = model;
                [_packingListView hideEditBtn];
                [self.packingListView showView];
            }
        }
        
    };

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
-(PackingListView *)packingListView{
    
    if (!_packingListView) {
        _packingListView = [[PackingListView alloc]init];
    }
    return _packingListView;
}
@end
