//
//  ComCustomerDetail.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComCustomerDetail : NSObject

/**
 联系公司ID
 */
@property (nonatomic, copy) NSString *comId;

/**
 开户行
 */
@property (nonatomic, copy) NSString *accountsBank;


/**
 地址
 */
@property (nonatomic, copy) NSString *address;


/**
 区ID
 */
@property (nonatomic, copy) NSString *areaId;

/**
 区名称
 */
@property (nonatomic, copy) NSString *areaName;

/**
 营业执照图片对象
 */
@property (nonatomic, strong) NSMutableArray *businessLicensePic;


/**
 市ID
 */
@property (nonatomic, copy) NSString *cityId;

/**
 市名称
 */
@property (nonatomic, copy) NSString *cityName;

/**
 公司货币ID
 */
@property (nonatomic, copy) NSString *companyCurrencyId;

/**
 联系公司删改权限(0:无 1:有)
 */
@property (nonatomic, copy) NSString *contactUpdateDeleteAuthority;

/**
 创建人名字
 */
@property (nonatomic, copy) NSString *creatorName;

/**
 公司货币名称
 */
@property (nonatomic, copy) NSString *currencyName;

/**
 email
 */
@property (nonatomic, copy) NSString *email;

/**
 传真
 */
@property (nonatomic, copy) NSString *fax;

/**
 负责人
 */
@property (nonatomic, copy) NSString *manager;

/**
 联系公司名称
 */
@property (nonatomic, copy) NSString *name;

/**
 公司类型（1:供应商 2:客户 3: 其他）
 */
@property (nonatomic, copy) NSString *nature;

/**
 参与者组
 */
@property (nonatomic, strong) NSMutableArray *participantGroups;

/**
 参与者
 */
@property (nonatomic, strong) NSMutableArray *participants;

/**
 省ID
 */
@property (nonatomic, copy) NSString *provinceId;

/**
 省名称
 */
@property (nonatomic, copy) NSString *provinceName;

/**
 备注
 */
@property (nonatomic, copy) NSString *remark;

/**
 业务员ID
 */
@property (nonatomic, copy) NSString *salesman;

/**
 业务员名称
 */
@property (nonatomic, copy) NSString *salesmanName;

/**
 公司规模
 */
@property (nonatomic, copy) NSString *scale;

/**
shortName
 */
@property (nonatomic, copy) NSString *shortName;

/**
 固定电话
 */
@property (nonatomic, copy) NSString *telephone;



@property (nonatomic, strong) NSDictionary *defultparticipant;

@property (nonatomic, copy) NSString *ParticiUserName;
@property (nonatomic, copy) NSString *ParticiUserID;


/**
 欠款
 */
@property (nonatomic, copy) NSString *receivableAmount;




@end

NS_ASSUME_NONNULL_END
