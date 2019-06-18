//
//  ChangeComController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/18.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ChangeComController.h"

@interface ChangeComController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;

@end

@implementation ChangeComController{
    NSMutableArray *_dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"切换公司";
    [self setBarBackBtnWithImage:nil];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.ListTab];
    [self changeBtnClick];
}
#pragma mark ===== 获取公司列表
- (void)changeBtnClick{
    [[HttpClient sharedHttpClient] requestGET:@"/companys" Withdict:nil WithReturnBlock:^(id returnValue) {
        _dataArr = returnValue[@"companys"];
        [self.ListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
        
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
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
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, ScreenWidth, 1) color:UIColorFromRGB(BackColorValue)];
        [cell.contentView addSubview:line];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = _dataArr[indexPath.row];
    User *user = [[UserPL shareManager] getLoginUser];
    user.defutecompanyId = [dic objectForKey:@"companyId"];
    user.defutecompanyName = [dic objectForKey:@"name"];
    [[UserPL shareManager] setComAttribute:user.defutecompanyId];
    [[UserPL shareManager] setUserData:user];
    [[UserPL shareManager] writeUser];
    [[UserPL shareManager] showHomeViewController];
}


#pragma mark ====== get
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
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
