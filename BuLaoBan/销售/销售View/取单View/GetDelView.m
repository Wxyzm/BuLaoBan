//
//  GetDelView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/17.
//  Copyright © 2019 XX. All rights reserved.
//

#import "GetDelView.h"
#import "GetDelCell.h"
#import "SellOrderDeliver.h"

@interface GetDelView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) UIView        *sideView;
@property (nonatomic, strong) BaseTableView *ListTab;               //列表-
@end

@implementation GetDelView{
    BOOL _isShow;
}

-(instancetype)init{
    self = [super init];
    if (self) {
         self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [self setup];
    }
    return self;
}

- (void)setup{
    [self addSubview:self.backButton];
    [self addSubview:self.sideView];
    UILabel *toplab= [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"取单"];
    toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:toplab];
   
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(564, 14, 16, 16);
    
    [self.sideView addSubview:self.ListTab];
    
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self.ListTab reloadData];
}

#pragma mark ========= tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cellid";
    GetDelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[GetDelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.model = _dataArr[indexPath.row];
    cell.deleteBtn.tag = 1000 + indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SellOrderDeliver *model = _dataArr[indexPath.row];
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(model.deliverId);
    }
    [self dismiss];
}


#pragma mark ========= menthod
- (void)dismiss{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
}

- (void)showInView{
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        
    }];
}

- (void)deleteBtnClick:(UIButton *)btn{
    
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该销售单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        SellOrderDeliver *model = _dataArr[btn.tag - 1000];
        [[HttpClient sharedHttpClient] requestDeleteWithURLStr:[NSString stringWithFormat:@"/sell/%@/deliver",model.deliverId] paramDic:nil WithReturnBlock:^(id returnValue) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"DelListDeleteSuccess" object:nil];
          

            [_dataArr removeObject:model];
            [self.ListTab reloadData];
        } andErrorBlock:^(NSString *msg) {
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:NULL];
    [alert addAction:action];
    [alert addAction:cancelAction];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = app.splitViewController.view;
    popPresenter.sourceRect = app.splitViewController.view.bounds;
    [app.splitViewController presentViewController:alert animated:YES completion:nil];
    
    
    
    
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

-(UIView *)sideView{
    if (!_sideView) {
        _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-300, 160, 600, 448) color:UIColorFromRGB(WhiteColorValue)];
        
    }
    return _sideView;
}

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 600, 404) style:UITableViewStylePlain];
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
