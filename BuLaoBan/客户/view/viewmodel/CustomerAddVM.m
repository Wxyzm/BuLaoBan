//
//  CustomerAddVM.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerAddVM.h"
#import "CustomerAddTypeModel.h"
#import "ComCustomerDetail.h"

@implementation CustomerAddVM

-(instancetype)init{
    
    self = [super init];
    if (self) {
        _listArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
#pragma mark ======== 重新设置详情
- (void)reSetDataWithReceiveAble:(BOOL)isReceive{
    [_listArr removeAllObjects];
    NSArray *mustArr = @[@"客户名称",@"业务员"];
    NSArray *selectArr = @[@"业务员",@"参与者"];
    NSArray *titleArr = @[@"客户名称",@"联系人",@"联系电话",@"邮箱",@"地址",@"期初欠款",@"业务员",@"参与者",@"备注"];
    NSArray *upArr = @[@"name",@"manager",@"telephone",@"email",@"address",@"receivableAmount",@"salesman",@"",@"remark"];

    for (int i = 0; i<titleArr.count; i++) {
        NSString *title = titleArr[i];
        CustomerAddTypeModel *model = [[CustomerAddTypeModel alloc]init];
        model.title = title;
        model.upStr = upArr[i];
        if ([mustArr containsObject:title]) {
            model.isMustInput = YES;
        }
        if ([selectArr containsObject:title]) {
            model.cellType = 2;
        }else{
            model.cellType = 1;
        }
        if (isReceive) {
            //开启
            if (![title isEqualToString:@"期初欠款"]) {
                [_listArr addObject:model];
            }
        }else{
            //未开启
            [_listArr addObject:model];
        }
    }
}


#pragma mark ======== 设置详情
-(void)setComCustomerDetailModel:(ComCustomerDetail *)demodel andisReceive:(BOOL)isReceive{
    _model = demodel;
    [self reSetDataWithReceiveAble:isReceive];
    NSArray *valueArr;
    NSString *spartakeStr = @"";
    NSString *spartakeId= @"";

    if (demodel.participants.count>0) {
        NSDictionary *dic =demodel.participants[0];
        spartakeStr = [dic objectForKey:@"userName"];
        spartakeId = [dic objectForKey:@"userId"];

    }
    if (isReceive) {
        //开启
          valueArr = @[demodel.name,demodel.manager,demodel.telephone,demodel.email,demodel.address,demodel.salesmanName,spartakeStr,demodel.remark];
    }else{
        valueArr = @[demodel.name,demodel.manager,demodel.telephone,demodel.email,demodel.address,demodel.receivableAmount,demodel.salesmanName,spartakeStr,demodel.remark];
    }
    for (int i = 0; i<_listArr.count; i++) {
        CustomerAddTypeModel *model = _listArr[i];
        if (valueArr.count>i) {
            model.showvalue = valueArr[i];
        }
        if ([model.title isEqualToString:@"业务员"]) {
            model.valueId = demodel.salesman;
        }
        if ([model.title isEqualToString:@"参与者"]) {
            model.valueId = spartakeId;
        }
    }
}






@end
