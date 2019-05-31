//
//  SellOrderDeliverDetail.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SellOrderDeliverDetail.h"
#import "DeliveDetails.h"
#import "PackListModel.h"
#import "SaleSamModel.h"

@implementation SellOrderDeliverDetail

-(instancetype)init{
    self = [super init];
    if (self) {
        
        if (!_sampleList) {
            _sampleList = [NSMutableArray arrayWithCapacity:0];
        }
    }
    return self;
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"details":@"DeliveDetails"};
}

- (void)getsampleListWithSellOrderDeliverDetail{
    [_sampleList removeAllObjects];
    for (int i = 0; i<self.details.count; i++)
    {
        DeliveDetails *deModel = self.details[i];
        SaleSamModel *saleModel = [[SaleSamModel alloc]init];
        saleModel.sampId = deModel.sampleId;
        saleModel.urlStr = deModel.samplePicKey;
        saleModel.name = deModel.name;
        saleModel.itemNo = deModel.itemNo;
        saleModel.color = deModel.colorName;
        saleModel.unitPrice = deModel.unitPrice;
        saleModel.pieces = deModel.packageNum;
        saleModel.salesVol = deModel.num;
        saleModel.unit = deModel.numUnit;
        saleModel.money = deModel.price;
        if (deModel.packingList.length>0)
        {
            NSDictionary *dic = [HttpClient valueWithJsonString:deModel.packingList];
            if (!dic) {
                return;
            }
            NSArray *deArr = [dic objectForKey:@"rowTr"];
            if (deArr.count<=0) {
                
            }else{
                for (int i = 0; i<deArr.count; i++)
                {
                    NSArray *strArr = deArr[i];
                    if (strArr.count==10)
                    {
                        PackListModel *model = [[PackListModel alloc]init];
                        model.dyelot = strArr[2];
                        model.reel = strArr[1];
                        model.meet = strArr[4];
                        [saleModel.packingList addObject:model];
                        PackListModel *model1 = [[PackListModel alloc]init];
                        model1.dyelot = strArr[7];
                        model1.reel = strArr[6];
                        model1.meet = strArr[9];
                        [saleModel.packingList addObject:model1];
                        
                    }
                    else if (strArr.count==8)
                    {
                        PackListModel *model = [[PackListModel alloc]init];
                        model.dyelot = strArr[1];
                        model.reel = strArr[0];
                        model.meet = strArr[3];
                        [saleModel.packingList addObject:model];
                        PackListModel *model1 = [[PackListModel alloc]init];
                        model1.dyelot = strArr[5];
                        model1.reel = strArr[4];
                        model1.meet = strArr[7];
                        [saleModel.packingList addObject:model1];
                    }
                }
            }
        }
        [_sampleList addObject:saleModel];
        
    }
}


@end
