//
//  CustomerAddManView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddManView.h"
#import "ManSelectCell.h"
#import "CompanyUsers.h"
#import "Participants.h"

@interface CustomerAddManView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseTableView *ListTab;

@property (nonatomic,strong) UILabel *titleLab;


@end

@implementation CustomerAddManView{
    NSInteger type;
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        self.frame = CGRectMake(ScreenWidth/2-150, ScreenHeight/2-265, 300, 530);
        type = 0;
        [self setUP];
    }
    
    return self;
}

-(void)setUP{
    _titleLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 300, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@""];
    _titleLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self addSubview:_titleLab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.frame = CGRectMake(264, 14, 16, 16);
    
    [self addSubview:self.ListTab];
}

-(void)setSaleManArr:(NSMutableArray *)saleManArr{
    _saleManArr = saleManArr;
    _titleLab.text = @"业务员";
     type = 0;
    [self.ListTab reloadData];
}

-(void)setParManArr:(NSMutableArray *)parManArr{
    _parManArr = parManArr;
    _titleLab.text = @"参与者";
     type = 1;
    [self.ListTab reloadData];
}

-(void)dismiss{
    if ([self.delegate respondsToSelector:@selector(didselectedCloseBtn)]) {
        [self.delegate didselectedCloseBtn];
    }
    
}

#pragma mark ==========  tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (type == 0) {
        return _saleManArr.count;
    }
    return _parManArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"ManSelectCellId";
    ManSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell= (ManSelectCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"ManSelectCell" owner:self options:nil]  lastObject];
    }
    if (type == 0) {
        cell.companyUsers  = _saleManArr[indexPath.row];
    }else{
        cell.participants = _parManArr[indexPath.row];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (type == 0) {
        //1参与者
        CompanyUsers *comUser = _saleManArr[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(didselectedsaleManListWithModel:)]) {
            [self.delegate didselectedsaleManListWithModel:comUser];
        }
    }else{
        //2业务员
        Participants *Partici = _parManArr[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(didselectedparManListWithModel:)]) {
            [self.delegate didselectedparManListWithModel:Partici];
        }
    }
}

#pragma mark ==========  get

-(UITableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 300, 486) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
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
