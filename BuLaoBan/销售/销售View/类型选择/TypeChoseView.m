//
//  TypeChoseView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import "TypeChoseView.h"

@interface TypeChoseView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIButton      *backButton;
@property (nonatomic, strong) UIView        *sideView;
@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@end

@implementation TypeChoseView
{
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
    UILabel *toplab= [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 300, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT(14) textAligment:NSTextAlignmentCenter andtext:@"类型选择"];
    toplab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self.sideView addSubview:toplab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:16 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.sideView addSubview:closeBtn];
    closeBtn.frame = CGRectMake(264, 14, 16, 16);
    
    [self.sideView addSubview:self.ListTab];
    
}



#pragma mark ========= tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 59, 300, 1) color:UIColorFromRGB(LineColorValue)];
        [cell.contentView addSubview:line];
        cell.textLabel.font = APPFONT14;
        
    }
    NSArray *titleArr = @[@"剪样",@"大货"];
    cell.textLabel.text = titleArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(indexPath.row);
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
        _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth/2-150, 160, 300, 244) color:UIColorFromRGB(WhiteColorValue)];
        
    }
    return _sideView;
}

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 44, 300, 200) style:UITableViewStylePlain];
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
