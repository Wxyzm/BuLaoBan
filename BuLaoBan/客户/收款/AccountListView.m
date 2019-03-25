//
//  AccountListView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import "AccountListView.h"
#import "AccountListCell.h"
#import "Accounts.h"
@interface AccountListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) BaseTableView *listTab;



@end


@implementation AccountListView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    
    UILabel *toplab= [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"选择账户"];
    toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self addSubview:toplab];
    UIButton *addBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"Acc_add"];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    addBtn.frame = CGRectMake(20, 14, 16, 16);
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    [self addSubview:self.listTab];
}

#pragma mark -- set
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.listTab reloadData];
    
}


#pragma mark -- 按钮点击

- (void)addBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(1,[Accounts new]);
    }
    
    
}

- (void)closeBtnClick{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(0,[Accounts new]);
    }
    
    
}

#pragma mark -- tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cellid";
    AccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[AccountListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.account = _dataArr[indexPath.row];
    WeakSelf(self);
    cell.returnBlock = ^(Accounts * _Nonnull account)
    {
        if (weakself.returnBlock)
        {
            weakself.returnBlock(2,account);
        }
   
    };
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self);
    if (weakself.returnBlock)
    {
        weakself.returnBlock(3,_dataArr[indexPath.row]);
    }
}


#pragma mark -- get

-(UITableView *)listTab{
    if (!_listTab) {
        _listTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 600, 266) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
        _listTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        
           }
    return _listTab;
    
}

@end
