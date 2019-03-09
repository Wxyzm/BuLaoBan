//
//  ComCustomer.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComCustomer : UIView

/**
 联系公司ID
 */
@property (nonatomic, copy) NSString *comId;

/**
 公司类型（1:供应商 2:客户 3: 其他）
 */
@property (nonatomic, copy) NSString *nature;

/**
 联系公司名称
 */
@property (nonatomic, copy) NSString *name;

/**
 电话
 */
@property (nonatomic, copy) NSString *telephone;

/**
 传真
 */
@property (nonatomic, copy) NSString *fax;

/**
  省名称
 */
@property (nonatomic, copy) NSString *provinceName;

/**
市名称
 */
@property (nonatomic, copy) NSString *cityName;

/**
 区名称
 */
@property (nonatomic, copy) NSString *areaName;


/**
 地址
 */
@property (nonatomic, copy) NSString *address;

/**
 开户行
 */
@property (nonatomic, copy) NSString *accountsBank;

/**
 业务员ID
 */
@property (nonatomic, copy) NSString *salesman;

/**
 业务员名称
 */
@property (nonatomic, copy) NSString *salesmanName;

/**
 联系人数量
 */
@property (nonatomic, copy) NSString *contactUserNum;


/**
 联系人数组
 */
@property (nonatomic, strong) NSMutableArray *contactUser;


/**
 公司货币ID
 */
@property (nonatomic, copy) NSString *companyCurrencyId;


/**
 公司货币名称
 */
@property (nonatomic, copy) NSString *currencyName;

/**
 email
 */
@property (nonatomic, copy) NSString *email;



@property (nonatomic, assign) BOOL isSelected;


@property (nonatomic, copy) NSString *pinyin;

@end



NS_ASSUME_NONNULL_END
