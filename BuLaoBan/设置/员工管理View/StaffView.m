//
//  StaffView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffView.h"
#import "StaffCell.h"

@interface StaffView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;



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


#pragma mark ====== Tabdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
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
    int a = indexPath.row % 2;
    if (a ==0) {
        cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
    }else{
        cell.contentView.backgroundColor = UIColorFromRGB(BackColorValue);

    }
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

@end
