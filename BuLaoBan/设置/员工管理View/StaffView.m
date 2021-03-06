//
//  StaffView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffView.h"
#import "StaffCell.h"
#import "StaffOperaView.h"   //员工编辑

@interface StaffView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;

/**
 编辑员工
 */
@property (nonatomic, strong)StaffOperaView *OperaView;



@end
@implementation StaffView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    UIView *topView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, self.width, 40) color:UIColorFromRGB(BlueColorValue)];
    [self addSubview:topView];
    NSArray *titleArr = @[@"头像",@"用户名",@"手机号",@"角色",@"操作"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectZero textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:titleArr[i]];
        [topView addSubview:lab];
        switch (i) {
            case 0:{
                lab.frame = CGRectMake(20, 0, 30, 40);
                break;
            }
            case 1:{
                lab.frame = CGRectMake(74, 0, 64, 40);
                break;
            }
            case 2:{
                lab.frame = CGRectMake(210, 0, 118, 40);
                break;
            }
            case 3:{
                lab.frame = CGRectMake(376, 0, 76, 40);
                break;
            }
            case 4:{
                lab.frame = CGRectMake(490, 0, 84, 40);
                break;
            }
            default:
                break;
        }
    }
    [self addSubview:self.ListTab];
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.ListTab reloadData];
}


#pragma mark ====== Tabdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid =@"cellid";
    StaffCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[StaffCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _dataArr[indexPath.row];
    WeakSelf(self);
    cell.SettingBlock = ^(CompanyUsers * _Nonnull model) {
      //员工设置
        weakself.OperaView.model = model;
        [weakself.OperaView showView];
    };
    return cell;
}


#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 40, self.width, ScreenHeight-64-40) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}
- (StaffOperaView *)OperaView{
    if (!_OperaView) {
        _OperaView = [[StaffOperaView alloc]init];
    }
    return _OperaView;
}

@end
