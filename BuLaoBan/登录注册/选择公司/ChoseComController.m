//
//  ChoseComController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ChoseComController.h"
#import "CreateComController.h"
#import "ComModel.h"
@interface ChoseComController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;

@end

@implementation ChoseComController{
    NSMutableArray *_dataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择公司";
    [self setBarBackBtnWithImage:nil];
    [self setRightBtnWithTitle:@"新建" andColor:UIColorFromRGB(NAVColorValue)];
    _dataArr = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.ListTab];
    [self changeBtnClick];
}

-(void)respondToRigheButtonClickEvent{
    CreateComController *crVc = [[CreateComController alloc]init];
    [self.navigationController pushViewController:crVc animated:YES];
}

#pragma mark ===== 获取公司列表
- (void)changeBtnClick{
    [[HttpClient sharedHttpClient] requestGET:@"/companys" Withdict:nil WithReturnBlock:^(id returnValue) {
        _dataArr = [ComModel mj_objectArrayWithKeyValuesArray:returnValue[@"companys"]];
        [self.ListTab reloadData];
        [self.ListTab.mj_header endRefreshing];
    } andErrorBlock:^(NSString *msg) {
        [self.ListTab.mj_header endRefreshing];

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
    ComModel *setmodel =  _dataArr[indexPath.row];
    if ([setmodel.sellInventoryReduce intValue]==1 ||[setmodel.foreignCurrency intValue]==1 ||[setmodel.distributionProcess intValue]==1 ||[setmodel.multiUnit intValue]==1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@(不可选)",setmodel.name];
    }else{
        cell.textLabel.text = setmodel.name;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ComModel *setmodel =  _dataArr[indexPath.row];
    if ([setmodel.sellInventoryReduce intValue]==1 ||[setmodel.foreignCurrency intValue]==1 ||[setmodel.distributionProcess intValue]==1 ||[setmodel.multiUnit intValue]==1)
    {
        [self showAlert];
        return;
    }
    User *user = [[UserPL shareManager] getLoginUser];
    user.defutecompanyId = setmodel.companyId;
    user.defutecompanyName =setmodel.name;
    [[UserPL shareManager] setComAttribute:user.defutecompanyId];
    [[UserPL shareManager] setUserData:user];
    [[UserPL shareManager] writeUser];
    [[UserPL shareManager] showHomeViewController];
}



- (void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"公司若开启了库存扣减或多计量单位或配货或外币核算四个功能中的任何一个,则无法登录pad版,是否切换公司？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
   
    [alert addAction:action];
    UIPopoverPresentationController *popPresenter = [alert popoverPresentationController];
    popPresenter.sourceView = self.view;
    popPresenter.sourceRect = self.view.bounds;
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark ====== get
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(changeBtnClick)];
        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}





@end
