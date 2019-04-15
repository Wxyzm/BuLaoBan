//
//  SaleStatisticController.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/2.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SaleStatisticController.h"
#import "SaleSTopView.h"
#import "SaleSSeller.h"
#import "SaleSSample.h"
#import "SaleSCustomer.h"
#import "SaleSGoodsCell.h"
#import "SaleSGoodsTopCell.h"
#import "SaleSCustomerCell.h"
#import "SaleSCustomerListCell.h"
#import "Statics.h"
#import "DatePickerView.h"
#import "PGDatePickManager.h"
#import "PGDatePickerHeader.h"
#import "CustomerSelecteView.h"
#import "ComCustomer.h"
#import "CompanyUsers.h"
@interface SaleStatisticController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@property (nonatomic,strong) SaleSTopView *topView;
@property (nonatomic, strong) DatePickerView *datepicker;     //时间选择
@property (nonatomic, strong) CustomerSelecteView *customerSelecteView;


@end

@implementation SaleStatisticController{
    
    NSInteger _index;
    NSString *_starTime;      //l开始时间
    NSString *_endTime;       //结束时间
    NSMutableArray *_dataArr1;
    NSMutableArray *_dataArr2;
    NSMutableArray *_dataArr3;
    ComCustomer *_comCusModel;
    ComCustomer *_companyUser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"销售统计表";
    [self setBarBackBtnWithImage:nil];
    [self initDatas];
    [self initUI];
    [self statisticsList];
    [self getSalestatistics];
}

- (void)initDatas{
    _index = 0;
    _dataArr1 = [NSMutableArray arrayWithCapacity:0];
    _dataArr2 = [NSMutableArray arrayWithCapacity:0];
    _dataArr3 = [NSMutableArray arrayWithCapacity:0];
    _starTime = @"";
    _endTime = @"";
}


- (void)initUI{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.ListTab];
    
    WeakSelf(self);
    self.customerSelecteView.returnBlock = ^(ComCustomer * _Nonnull comCusModel) {
        if (weakself.customerSelecteView.SelectYype ==1) {
            _companyUser = comCusModel;
            [weakself.topView setTitle:comCusModel.name withTag:9];
            return ;
        }
        _comCusModel = comCusModel;
        [weakself.topView setTitle:comCusModel.name withTag:8];
    };
    self.datepicker.returnBlock = ^(NSInteger dateType, NSString *dateStr) {
        [weakself selectedDate:dateStr andtag:dateType];

    };
    
    self.topView.returnBlock = ^(NSInteger tag) {
        _index = tag;
        switch (tag) {
            case 0:
            {
                //按货品
                [weakself statisticsList];
                break;
            }
            case 1:
            {
                 //按客户
                [weakself statisticscustomerList];
                break;
            }
            case 2:
            {
                 //按业务员
                 [weakself statisticssellerList];
                break;
            }
            case 3:
            {
                //今天
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
                [formatter setTimeZone:timeZone];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *dataStr= [formatter stringFromDate:[NSDate date]];
                _starTime = dataStr;
                [weakself.topView setTitle:dataStr withTag:6];
                [weakself.topView setTitle:@"" withTag:7];

                break;
            }
            case 4:
            {
                 //昨天
                NSDate * date = [NSDate date];//当前时间
                NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
                [formatter setTimeZone:timeZone];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *dataStr= [formatter stringFromDate:lastDay];
                _starTime = dataStr;
                [weakself.topView setTitle:dataStr withTag:6];
                [weakself.topView setTitle:@"" withTag:7];
                break;
            }
            case 5:
            {
                //本月
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
                [formatter setTimeZone:timeZone];
                [formatter setDateFormat:@"yyyy-MM"];
                NSString *dataStr=[NSString stringWithFormat:@"%@-01", [formatter stringFromDate:[NSDate date]]];
                _starTime = dataStr;
                [weakself.topView setTitle:dataStr withTag:6];
                [weakself.topView setTitle:@"" withTag:7];
                break;
            }
            case 6:
            {
                //开始日期
                weakself.datepicker.dateType = 1;
                [weakself.datepicker showViewWithFrame:CGRectMake(320, 180, 10, 10)];

                break;
            }
            case 7:
            {
                //结束日期
                weakself.datepicker.dateType = 2;
                [weakself.datepicker showViewWithFrame:CGRectMake(450, 180, 10, 10)];
                break;
            }
            case 8:
            {
                //选择客户
                [weakself loadCustomerListWithTag:0];
                break;
            }
            case 9:
            {
                //选择销售
                [weakself loadcompanysUsersList];
                break;
            }
            case 10:
            {
                //查询
                if (_index==0) {
                    [weakself statisticsList];
                }else if (_index==1){
                    [weakself statisticscustomerList];
                }else{
                    [weakself statisticssellerList];
                }
                break;
            }
            case 11:
            {
                //重置
                _starTime = @"";
                _endTime = @"";
                _comCusModel = nil;
                _companyUser = nil;
                break;
            }
            default:
                break;
        }
       
        
    };
}


#pragma mark ====== 属性选择日期
/**
 日期选择
 
 @param dateStr 日期
 @param tag 类型  1：开始时间   2：结束时间
 */
- (void)selectedDate:(NSString *)dateStr andtag:(NSInteger)tag{
    switch (tag) {
        case 1:{
            if (dateStr.length<=0) {
                //清除l开始日期
                _starTime = @"";
            }else{
                _starTime = dateStr;
            }
            [self.topView setTitle:dateStr withTag:6];

            break;
        }
        case 2:{
            if (dateStr.length<=0) {
                //清除结束日期
                _endTime = @"";
            }else{
                _endTime = dateStr;
            }
            [self.topView setTitle:dateStr withTag:7];

            break;
        }
            
        default:
            break;
    }
}

#pragma mark ====  获取员工列表

- (void)loadcompanysUsersList{
    
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"pageNo":@"1",
                          @"pageSize":@"5000",
                          @"":@""
                          };
    [HUD showLoading:nil];

    [[HttpClient sharedHttpClient] requestGET:[NSString stringWithFormat:@"/companys/%@/users",user.defutecompanyId] Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD cancel];
        NSLog(@"%@",returnValue);
        NSMutableArray *dataArr = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"companyUsers"]];
        self.customerSelecteView.SelectYype =1;
        self.customerSelecteView.dataArr = dataArr;
        [self.customerSelecteView showView];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];

    }];
    
    
}


#pragma mark ====== 获取客户列表
- (void)loadCustomerListWithTag:(NSInteger)tag{
    User *user = [[UserPL shareManager] getLoginUser];
    NSDictionary *dic = @{@"companyId":user.defutecompanyId,
                          @"pageNo":@"1",
                          @"pageSize":@"5000"
                          };
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"contact/company" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [HUD cancel];
        NSMutableArray *dataArr = [ComCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"contactCompanys"]];
        self.customerSelecteView.SelectYype =tag;
        self.customerSelecteView.dataArr = dataArr;
        [self.customerSelecteView showView];
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];
    }];
}

#pragma mark----获取销售统计
- (void)getSalestatistics{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:user.defutecompanyId forKey:@"companyId"];
 
    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        NSArray *arr = [Statics mj_objectArrayWithKeyValuesArray:returnValue[@"statistics"]];
        if (arr.count>0) {
            self.topView.statics = arr[0];
        }
    } andErrorBlock:^(NSString *msg) {
        
    }];
}

#pragma mark----获取销售统计详细-按面料
- (void)statisticsList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:user.defutecompanyId forKey:@"companyId"];
    if (_starTime.length>0) {
        [dic setObject:_starTime forKey:@"orderDateStart"];
    }
    if (_endTime.length>0) {
        [dic setObject:_endTime forKey:@"orderDateEnd"];
    }
    if (self.topView.numberTxt.text.length>0) {
        [dic setObject:self.topView.numberTxt.text forKey:@"key"];
        [dic setObject:@"0" forKey:@"searchType"];

    }
    [HUD showLoading:nil];
    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/sample" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [HUD cancel];
        _dataArr1 = [SaleSSample mj_objectArrayWithKeyValuesArray:returnValue[@"sellSamples"]];
        if (_dataArr1.count<=0) {
            [HUD show:@"未查询到数据"];
        }
        [self.ListTab reloadData];
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];
}
#pragma mark----获取销售统计详细-按客户
- (void)statisticscustomerList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:user.defutecompanyId forKey:@"companyId"];
    if (_starTime.length>0) {
        [dic setObject:_starTime forKey:@"orderDateStart"];
    }
    if (_endTime.length>0) {
        [dic setObject:_endTime forKey:@"orderDateEnd"];
    }
    if (_comCusModel) {
        [dic setObject:_comCusModel.name forKey:@"key"];
    }
    [HUD showLoading:nil];

    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/customer" Withdict:dic WithReturnBlock:^(id returnValue) {
         [HUD cancel];
        NSLog(@"%@",returnValue);
        _dataArr2 = [SaleSCustomer mj_objectArrayWithKeyValuesArray:returnValue[@"sellCustomers"]];
        if (_dataArr2.count<=0) {
            [HUD show:@"未查询到数据"];
        }
        [self.ListTab reloadData];
        
    } andErrorBlock:^(NSString *msg) {
         [HUD cancel];
    }];
}


#pragma mark---- 获取销售统计详细-按销售员
- (void)statisticssellerList{
    User *user  =[[UserPL shareManager] getLoginUser];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:user.defutecompanyId forKey:@"companyId"];
    if (_starTime.length>0) {
        [dic setObject:_starTime forKey:@"orderDateStart"];
    }
    if (_endTime.length>0) {
        [dic setObject:_endTime forKey:@"orderDateEnd"];
    }
    if (_companyUser) {
        [dic setObject:_companyUser.name forKey:@"key"];
    }
    [HUD showLoading:nil];

    [[HttpClient sharedHttpClient] requestGET:@"/sell/statistics/seller" Withdict:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [HUD cancel];

        _dataArr3 = [SaleSSeller mj_objectArrayWithKeyValuesArray:returnValue[@"sellSellers"]];
        if (_dataArr3.count<=0) {
            [HUD show:@"未查询到数据"];
        }
        [self.ListTab reloadData];
        
    } andErrorBlock:^(NSString *msg) {
        [HUD cancel];

    }];
}

#pragma mark---- tableview
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_index==0) {
        SaleSGoodsTopCell * cell= (SaleSGoodsTopCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SaleSGoodsTopCell" owner:self options:nil]  lastObject];
        
        return cell.contentView;
    }
    SaleSCustomerCell*cell= (SaleSCustomerCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SaleSCustomerCell" owner:self options:nil]  lastObject];
    if (_index ==1) {
        cell.nameLab.text = @"客户";
    }else{
        cell.nameLab.text = @"销售";
        
    }
    return  cell.contentView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_index==0) {
        return _dataArr1.count;
    }else if (_index==1){
        return _dataArr2.count;
    }
    return _dataArr3.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index==0) {
        return 50;
    }
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_index==0) {
        SaleSGoodsCell *cell = (SaleSGoodsCell *)[tableView dequeueReusableCellWithIdentifier:@"SaleSGoodsCellID"];
        if (cell == nil) {
            cell= (SaleSGoodsCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SaleSGoodsCell" owner:self options:nil]  lastObject];
        }
        cell.sampleModel = _dataArr1[indexPath.row];
        return cell;
        
        
    }
    SaleSCustomerListCell *cell = (SaleSCustomerListCell *)[tableView dequeueReusableCellWithIdentifier:@"SaleSCustomerListCellID"];
    if (cell == nil) {
        cell= (SaleSCustomerListCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"SaleSCustomerListCell" owner:self options:nil]  lastObject];
    }
    if (_index ==1) {
        cell.customerModel = _dataArr2[indexPath.row];
    }else{
        cell.sellerModel = _dataArr3[indexPath.row];
    }
    
    return cell;
}


#pragma mark---- get
-(SaleSTopView *)topView{
    
    if (!_topView ) {
        _topView  = [[SaleSTopView alloc]init];
    }
    return _topView;
    
}

-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 160, ScreenWidth-100, ScreenHeight-160-NaviHeight64) style:UITableViewStylePlain];
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

-(DatePickerView *)datepicker{
    if (!_datepicker) {
        _datepicker = [[DatePickerView alloc]init];
    }
    return _datepicker;
}
-(CustomerSelecteView *)customerSelecteView{
    
    if (!_customerSelecteView) {
        _customerSelecteView = [[CustomerSelecteView alloc]init];
    }
    return _customerSelecteView;
}
@end
