//
//  SaleVcModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SellOrderDeliverDetail;
NS_ASSUME_NONNULL_BEGIN

@interface SaleVcModel : NSObject

//com
@property (nonatomic, copy) NSString *comName;  //客户名称
@property (nonatomic, copy) NSString *comId;    //客户ID
@property (nonatomic, copy) NSString *type;     //订单类型【0:剪样 1:大货】

//sample
@property (nonatomic, strong) NSMutableArray *sampleList;    //样品列表


- (void)getDataWithSellOrderDeliverDetail:(SellOrderDeliverDetail *)detailModel;

@end

NS_ASSUME_NONNULL_END
