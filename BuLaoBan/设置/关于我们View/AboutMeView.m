//
//  AboutMeView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AboutMeView.h"
#import "AbContCell.h"

@interface AboutMeView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;

@end


@implementation AboutMeView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(300, 64, ScreenWidth-400, ScreenHeight-64);
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        [self setup];
    }
    return self;
}

- (void)setup{
    [self addSubview:self.ListTab];
}

#pragma mark ====== tableview

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ScreenWidth-400;
    if (indexPath.row == 0) {
        return 250*width/625;
    }else if (indexPath.row == 1){
        return 150;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = ScreenWidth-400;

    if (indexPath.row ==0) {
        static NSString *topCellid = @"topcellid";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:topCellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:topCellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *faceIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 250*width/625)];
            faceIma.image = [UIImage imageNamed:@"ab_banner"];
            [cell.contentView addSubview:faceIma];
        }
        return cell;
    }else if (indexPath.row == 1){
        static NSString *middCellid = @"middlellid";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:middCellid];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:middCellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self setmiddleCell:cell];
        }
        return cell;
        
    }else if (indexPath.row >1&&indexPath.row <= 5){
        static NSString *conCellid = @"conCellid";
        AbContCell *cell = [tableView dequeueReusableCellWithIdentifier:conCellid];
        if (!cell) {
            cell = [[AbContCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:conCellid];
        }
        NSArray *nameArr = @[@"葛经理",@"孙经理",@"徐经理",@"潘经理"];
        NSArray *phoneArr = @[@"18106866076",@"18106865661",@"13185595355",@"18106860316"];
        [cell setName:nameArr[indexPath.row-2] andphone:phoneArr[indexPath.row -2]];
        return cell;
    }
    static NSString *boomCellid = @"boomCellid";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:boomCellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:boomCellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setlocaCellWithIndex:indexPath.row andCell:cell];
    }
    return cell;
}


#pragma mark ====== 设置cell

- (void)setmiddleCell:(UITableViewCell *)cell{
    NSArray *imaArr = @[@"ab_samplema",@"ab_in",@"ab_buy",@"ab_follow",@"ab_costomer",@"ab_synchronization"];
    NSArray *titleArr = @[@"面料样品管理",@"纺织进销存",@"纺织外贸系统",@"面料生产/跟单管理",@"纺织客户关系管理",@"多设备同步办公"];
    CGFloat width = ScreenWidth-400;
    CGFloat btnWidth = width/3;
    
    for (int i = 0; i<imaArr.count; i++) {
        int a = i/3;
        int b = i%3;
        UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imaArr[i]]];
        [cell.contentView addSubview:ima];
        ima.frame = CGRectMake(30+btnWidth*b, 50*a+12, 26, 26);
        
        UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(66+btnWidth*b, 50*a, btnWidth-66, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
        [cell.contentView addSubview:nameLab];

    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 100, width, 1) color:UIColorFromRGB(LineColorValue)];
    [cell.contentView addSubview:line];
    
    UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(30, 100, width, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@"联系销售，了解详情"];
    [cell.contentView addSubview:nameLab];
    
}

- (void)setlocaCellWithIndex:(NSInteger)index andCell:(UITableViewCell *)cell{
    NSArray *imaArr = @[@"ab_visit",@"ab_adress"];
    NSArray *titleArr = @[@"更多功能请访问布管家网站 ",@"浙江省绍兴市柯桥区财富大厦11楼"];
    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imaArr[index-6]]];
    [cell.contentView addSubview:ima];
    ima.frame = CGRectMake(30,12, 26, 26);
    
    UILabel *nameLab = [BaseViewFactory labelWithFrame:CGRectMake(76, 0, 300, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT15 textAligment:NSTextAlignmentLeft andtext:titleArr[index-6]];
    [cell.contentView addSubview:nameLab];
    if (index ==6) {
        YLButton *urlBtn = [BaseViewFactory ylButtonWithFrame:CGRectMake(270, 0, 150, 50) font:APPFONT15 title:@"www.buguanjia.com" titleColor:UIColorFromRGB(BlueColorValue) backColor:UIColorFromRGB(WhiteColorValue)];
        [urlBtn addTarget:self action:@selector(urlBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:urlBtn];

    }
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(30, 0, ScreenWidth-400-30, 1) color:UIColorFromRGB(LineColorValue)];
    [cell.contentView addSubview:line];
    
}


- (void)urlBtnClick{
    
    NSString *urlstr = [@"https://www.buguanjia.com" stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSURL *URL = [NSURL URLWithString:urlstr];

    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication]openURL:URL options:@{} completionHandler:^(BOOL success) {
            
        }];
    } else {
        [[UIApplication sharedApplication]openURL:URL];
    }
   
}

#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-400, ScreenHeight-64) style:UITableViewStylePlain];
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
