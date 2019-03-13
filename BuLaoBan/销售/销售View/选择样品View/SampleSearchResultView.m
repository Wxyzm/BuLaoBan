//
//  SampleSearchResultView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SampleSearchResultView.h"
#import "SampleSearchResultCell.h"

@interface SampleSearchResultView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@end

@implementation SampleSearchResultView{
    
    BOOL _isShow;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 114, ScreenWidth-100-220 , ScreenHeight-114);
        self.backgroundColor = [UIColor clearColor];
        _dataArr = [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [self addSubview:self.backButton];
    [self addSubview:self.ListTab];
}

#pragma mark ========= tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid  = @"cellid";
    SampleSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SampleSearchResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.samModel = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Sample *model = _dataArr[indexPath.row];
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(model);
    }
}



-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    CGFloat a = dataArr.count*60;
    if (a>self.height-70) {
        a = self.height-70;
    }
        _ListTab.frame = CGRectMake(self.width-300, 5, 300, a);
    [self.ListTab reloadData];
}
#pragma mark ========= public method

- (void)showinView:(UIView *)view{
    [view addSubview:self];
     _isShow = YES;
}
- (void)dismiss{
    if (!_isShow) return;
    _isShow = NO;
    [self removeFromSuperview];
}
#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}


-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(self.width-300, 5, 300, self.height) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.sectionIndexBackgroundColor = [UIColor clearColor];
        
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}

@end
