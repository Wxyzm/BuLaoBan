//
//  PackingListView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import "PackingListView.h"
#import "PackListModel.h"
#import "PacklistCell.h"
#import "PacKListDataManager.h"
#import "IQKeyboardManager.h"
#import "SaleSamModel.h"
#import "DeliveDetails.h"
@interface PackingListView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@end
@implementation PackingListView{
    
    NSInteger _selectedIndex;    //选中显示的数据页
    NSMutableArray *_pageBtnArr; //底部页数按钮
    UILabel *_reelTotLab;        //总计卷号
    UILabel *_meetTotLab;        //总计米数
    PacKListDataManager *_packManager;
    BOOL _isShow;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor =UIColorFromRGB_Alpha(BlackColorValue, 0.3);
        _pageBtnArr = [NSMutableArray arrayWithCapacity:0];
        _packManager = [[PacKListDataManager alloc] init];
        _selectedIndex = 0;
        [self setUP];
    }
    return self;
}
#pragma mark ========= UI

- (void)setUP{
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-200, ScreenHeight/2-255, 400, 510) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    //顶部
    [self setTopView];
    //表
    [_sideView addSubview:self.ListTab];
    //底部统计
    [self setTotView];
    UIButton *addBtn = [BaseViewFactory buttonWithFrame:CGRectMake(16, 414, 90, 30) font:APPFONT13 title:@"新增码单" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    [addBtn addTarget:self action:@selector(newAemptyArr) forControlEvents:UIControlEventTouchUpInside];
    [_sideView addSubview:addBtn];
    
    UIButton *deleteBtn = [BaseViewFactory buttonWithFrame:CGRectMake(106, 414, 90, 30) font:APPFONT13 title:@"移除当前" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(RedColorValue)];
    [deleteBtn addTarget:self action:@selector(deleteArr) forControlEvents:UIControlEventTouchUpInside];
    [_sideView addSubview:deleteBtn];
    
    UIButton *saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(50, 464, 300, 30) font:APPFONT13 title:@"保 存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    [saveBtn addTarget:self action:@selector(saveAllDatas) forControlEvents:UIControlEventTouchUpInside];
    [_sideView addSubview:saveBtn];
    
}
//顶部
- (void)setTopView{
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 400, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"细码单"];
    topLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [_sideView addSubview:topLab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:13 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(357, 0, 43, 43);
    [_sideView addSubview:closeBtn];
}

//统计
- (void)setTotView{
    UIView *totView = [BaseViewFactory viewWithFrame:CGRectMake(0, 364, 400, 40) color:UIColorFromRGB(0xf5f5f5)];
    [_sideView addSubview:totView];
    UILabel *titleLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 0, 80, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"全表统计："];
    [totView addSubview:titleLab];
    _reelTotLab = [BaseViewFactory labelWithFrame:CGRectMake(150, 0, 100, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentCenter andtext:@"匹"];
    [totView addSubview:_reelTotLab];
    _meetTotLab= [BaseViewFactory labelWithFrame:CGRectMake(250, 0, 150, 40) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentCenter andtext:@"米"];
    [totView addSubview:_meetTotLab];
}

#pragma mark =========新增删除一页
/**
 新增一页
 */
-(void)newAemptyArr{
    [_packManager addOnepageNewDatas];
    [self.ListTab reloadData];
    [self refreshBoomBtn];
}
/**
  删除1页
 */
-(void)deleteArr{
    [_packManager deleteOnepageDatasWithIndex:_selectedIndex];
    _selectedIndex = 0;
    [self.ListTab reloadData];
    [self refreshBoomBtn];
}

#pragma mark =========保存数据
- (void)saveAllDatas{
    //获取数据进一个数组
    NSMutableArray *valiarr = [_packManager getValidDatas];
    [_saleSamModel.packingList addObjectsFromArray:valiarr];
    //总米数
    _saleSamModel.MeetTotal = [_packManager getMeetTotal];
    _saleSamModel.piecesTotal = [_packManager getReelTotal];

    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(_saleSamModel);
    }
    [self dismiss];
}

#pragma mark =========设置底部按钮
- (void)refreshBoomBtn{
    for (int i = 0; i<_packManager.dataArr.count; i++) {
        if (_pageBtnArr.count<=i) {
            YLButton *btn = [YLButton buttonWithbackgroundColor:UIColorFromRGB(WhiteColorValue) titlecolor:UIColorFromRGB(BlackColorValue) cornerRadius:2 andtarget:nil action:nil titleFont:APPFONT14 title:@""];
            [_pageBtnArr addObject:btn];
            [_sideView addSubview:btn];
        }
    }
    for (YLButton *btn in _pageBtnArr) {
        btn.hidden = YES;
    }
    for (int i = 0; i<_packManager.dataArr.count; i++) {
        YLButton *btn = _pageBtnArr[i];
        btn.tag = 1000 +i;
        [btn addTarget:self action:@selector(pageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.hidden = NO;
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        if (_selectedIndex ==i) {
            [btn setTitleColor:UIColorFromRGB(WhiteColorValue) forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColorFromRGB(BlueColorValue)];
        }else{
            [btn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
            [btn setBackgroundColor:UIColorFromRGB(BackColorValue)];
        }
        btn.frame = CGRectMake(206+40*i, 414, 30, 30);
    }
}

//点击选页按钮
- (void)pageBtnClick:(YLButton *)selectbtn{
    _selectedIndex = selectbtn.tag - 1000;
    for (int i = 0; i<_pageBtnArr.count; i++) {
        YLButton *btn = _pageBtnArr[i];
        [btn setTitleColor:UIColorFromRGB(BlackColorValue) forState:UIControlStateNormal];
        [btn setBackgroundColor:UIColorFromRGB(BackColorValue)];
    }
    [selectbtn setTitleColor:UIColorFromRGB(WhiteColorValue) forState:UIControlStateNormal];
    [selectbtn setBackgroundColor:UIColorFromRGB(BlueColorValue)];
    [self.ListTab reloadData];
}
#pragma - mark =========== 初始化数据

-(void)setSaleSamModel:(SaleSamModel *)saleSamModel{
    _saleSamModel = saleSamModel;
    [_packManager.dataArr removeAllObjects];
    if (saleSamModel.packingList.count<=0) {
        [_packManager addOnepageNewDatas];
    }else{
        [_packManager sortWithdatasArr:saleSamModel.packingList];
    }
    [self setToolLabText];
    [self refreshBoomBtn];
    [self.ListTab reloadData];
}

-(void)setDeliveDetails:(DeliveDetails *)deliveDetails{
    _deliveDetails = deliveDetails;
    [_packManager.dataArr removeAllObjects];
    NSDictionary *dic = [HttpClient valueWithJsonString:deliveDetails.packingList];
    if (!dic) {
        return;
    }
    NSArray *deArr = [dic objectForKey:@"rowTr"];
    if (deArr.count<=0) {
        [_packManager addOnepageNewDatas];
    }else{
        NSMutableArray *theDataArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<deArr.count; i++) {
            NSArray *strArr = deArr[i];
            if (strArr.count==10) {
                PackListModel *model = [[PackListModel alloc]init];
                model.dyelot = strArr[2];
                model.reel = strArr[1];
                model.meet = strArr[4];
                model.noInput = YES;
                [theDataArr addObject:model];
                PackListModel *model1 = [[PackListModel alloc]init];
                model1.dyelot = strArr[7];
                model1.reel = strArr[6];
                model1.meet = strArr[9];
                model1.noInput = YES;
                [theDataArr addObject:model1];
                
            }else if (strArr.count==8){
                PackListModel *model = [[PackListModel alloc]init];
                model.dyelot = strArr[1];
                model.reel = strArr[0];
                model.meet = strArr[3];
                model.noInput = YES;
                [theDataArr addObject:model];
                PackListModel *model1 = [[PackListModel alloc]init];
                model1.dyelot = strArr[5];
                model1.reel = strArr[4];
                model1.meet = strArr[7];
                model1.noInput = YES;
                [theDataArr addObject:model1];
            }
          
        }
        [_packManager sortWithdatasArr:theDataArr];

    }
    [self setToolLabText];
    [self refreshBoomBtn];
    [self.ListTab reloadData];
    
}


#pragma - mark =========== 当键盘退出 对数据从新排序
- (void)keyboardWillHide:(NSNotification *)notification
{
    //对数据从新排序展示
    [_packManager sortWithArr];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.ListTab reloadData];
        [self setToolLabText];
    });
}
//设置统计显示
- (void)setToolLabText{
    NSInteger reelT = [_packManager getReelTotal];
    CGFloat meetT = [_packManager getMeetTotal];
    _reelTotLab.text = [NSString stringWithFormat:@"%ld匹",reelT];
    _meetTotLab.text = [NSString stringWithFormat:@"%.2f米",meetT];
}


#pragma - mark public method
- (void)showView
{
    _sideView.frame =CGRectMake(ScreenWidth/2-200, ScreenHeight, 400, 510);
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth/2-200, ScreenHeight/2-255, 400, 510);
    }];
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth/2-200, ScreenHeight, 400, 510);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
}
#pragma - mark tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_packManager.dataArr.count>_selectedIndex) {
        NSMutableArray *dataArr = _packManager.dataArr[_selectedIndex];
        return dataArr.count+1;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cellid";
    PacklistCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[PacklistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (indexPath.row ==0) {
        cell.dyelotTxt.text = @"缸号";
        cell.reelTxt.text = @"卷号";
        cell.meetTxt.text = @"米数";
        cell.userInteractionEnabled = NO;
    }else{
        cell.userInteractionEnabled = YES;
        NSMutableArray *dataArr = _packManager.dataArr[_selectedIndex];
        cell.packModel = dataArr[indexPath.row-1];
    }
    cell.InsertBlock = ^(PackListModel * _Nonnull oldModel) {
        [_packManager insertOndDataaftermodel:oldModel];
        [self.ListTab reloadData];
        [self refreshBoomBtn];
        NSMutableArray *dataArr = _packManager.dataArr[_selectedIndex];
        NSInteger row = [dataArr indexOfObject:oldModel];
        if (row+1<=dataArr.count) {
            NSIndexPath *seindexPath=[NSIndexPath indexPathForRow:row+1 inSection:0];
            PacklistCell *secell =(PacklistCell *)[tableView cellForRowAtIndexPath:seindexPath];
            [secell.meetTxt becomeFirstResponder];
        }
    };
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}
#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
    }
    return _backButton;
}
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 400, 320) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.sectionIndexBackgroundColor = [UIColor clearColor];
        [_ListTab flashScrollIndicators];
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}
@end
