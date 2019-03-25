//
//  Accounts.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/25.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Accounts : NSObject

/**
 账户ID
 */
@property (nonatomic, copy) NSString *companyAccountId;
/**
 账户名称
 */
@property (nonatomic, copy) NSString *accountName;
/**
账号
 */
@property (nonatomic, copy) NSString *accountNumber;
/**
 公司货币ID
 */
@property (nonatomic, copy) NSString *companyCurrencyId;
/**
 货币名称
 */
@property (nonatomic, copy) NSString *currencyName;
/**
 类型（1：现金2：银行3：网络支付平台）
 */
@property (nonatomic, copy) NSString *type;


@end

NS_ASSUME_NONNULL_END
