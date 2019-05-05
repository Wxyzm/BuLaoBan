//
//  PrinterModelView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import "PrinterModelView.h"
#import "SettingCell.h"

@interface PrinterModelView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;



@end
@implementation PrinterModelView{
    
     UISwitch *_mprintSwitch;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    _mprintSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth-400-72, 10, 52, 31)];

     [self addSubview:self.ListTab];
}

#pragma mark ====== tableviewdelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==1) {
        return 40;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *titltArr = @[@"快速打印",@"跳过打印预览，直接打印",@"打印模版设置",@"面料标签",@"销售单"];
    if (indexPath.row ==3||indexPath.row == 4) {
        static NSString *SettingCellid = @"SettingCell";
        SettingCell *cell= [tableView dequeueReusableCellWithIdentifier:SettingCellid];
        if (!cell) {
            cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingCellid];
        }
        cell.nameLab.text = titltArr[indexPath.row];
        cell.nameLab.font = APPFONT13;
        cell.nameLab.frame = CGRectMake(15, 0, 200, 50);
        cell.lineView.frame = CGRectMake(0, 49, self.width, 1);
        cell.rightIma.frame = CGRectMake(self.width-24, 19, 8, 13);
       
        return cell;
    }
    
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row==0) {
        cell.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [cell.contentView addSubview:_mprintSwitch];

    }else{
        cell.contentView.backgroundColor = UIColorFromRGB(BackColorValue);
    }
    if (indexPath.row==1) {
        cell.textLabel.frame = CGRectMake(20, 0, self.width-40, 40);
        cell.textLabel.font = APPFONT12;
        cell.textLabel.textColor = UIColorFromRGB(0x9b9b9b);
    }else{
        cell.textLabel.frame = CGRectMake(20, 0, self.width-40, 50);
        cell.textLabel.font = APPFONT13;
        cell.textLabel.textColor = UIColorFromRGB(BlackColorValue);

    }
    cell.textLabel.text = titltArr[indexPath.row];
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
