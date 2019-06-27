//
//  ComModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/27.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComModel : NSObject

@property (nonatomic,copy) NSString *companyId;
@property (nonatomic,copy) NSString *companyInfoAuthority;
@property (nonatomic,copy) NSString *companyUserAuthority;
@property (nonatomic,copy) NSString *deleteAuthority;
@property (nonatomic,copy) NSString *distributionProcess;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *foreignCurrency;
@property (nonatomic,copy) NSString *manageAuthority;
@property (nonatomic,copy) NSString *multiUnit;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *payAuthority;
@property (nonatomic,copy) NSString *payStatus;
@property (nonatomic,copy) NSString *roleId;
@property (nonatomic,copy) NSString *sellInventoryReduce;
@property (nonatomic,copy) NSString *type;



@end

NS_ASSUME_NONNULL_END
