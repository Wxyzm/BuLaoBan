//
//  SettleVcModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/16.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettleVcModel : NSObject

//com
@property (nonatomic, copy) NSString *comName;     //客户名称
@property (nonatomic, copy) NSString *comId;       //客户ID
@property (nonatomic, copy) NSString *type;        //订单类型【0:剪样 1:大货】

@property (nonatomic, copy) NSString *date;        //业务日期
@property (nonatomic, copy) NSString *sellerId;    //业务员Id
@property (nonatomic, copy) NSString *sellerName;  //业务员姓名

@property (nonatomic, assign) NSInteger styleNum;     //总款式
@property (nonatomic, assign) NSInteger pieceNum;     //总匹数
@property (nonatomic, assign) float meetNum;      //总米数
@property (nonatomic, assign) float goofsMoney;   //合计金额

@property (nonatomic, copy) NSString *otherMoney;   //其他费用
@property (nonatomic, copy) NSString *totolMoney;   //总计金额

@property (nonatomic, copy) NSString *memo;         //备注

@property (nonatomic, copy) NSString *needAcc;       //本单应收
@property (nonatomic, copy) NSString *haveAcc;       //本单已收
@property (nonatomic, copy) NSString *oweAcc;        //本单欠款
@property (nonatomic, copy) NSString *actualAcc;     //实收金额

@property (nonatomic, copy) NSString *paytype;       //结算账户





@end

NS_ASSUME_NONNULL_END
