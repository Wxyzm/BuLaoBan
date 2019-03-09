//
//  LinkPrinterView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import "LinkPrinterView.h"
@interface LinkPrinterView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;



@end
@implementation LinkPrinterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    
    [self addSubview:self.ListTab];
}

#pragma mark ====== tableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, self.width, 50) color:UIColorFromRGB(BackColorValue)];
    NSArray *titleArr = @[@"已配对设备（点击名称进行打印）",@"未配对设备（点击名称进行打印）"];
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 300, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:titleArr[section]];
    NSRange range = [titleArr[section] rangeOfString:@"（点击名称进行打印）"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:titleArr[section]];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x9b9b9b) range:range];
    [lab setAttributedText:attStr];
    [headerView addSubview:lab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, self.width, 1) color:UIColorFromRGB(LineColorValue)];
    [headerView addSubview:line];

    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = APPFONT13;
        cell.textLabel.frame = CGRectMake(20, 0, self.width-40, 50);
    }
    cell.textLabel.text = @"打印机AB0001";
    return cell;
}



#pragma mark ====== get

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.width, ScreenHeight-64) style:UITableViewStylePlain];
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
