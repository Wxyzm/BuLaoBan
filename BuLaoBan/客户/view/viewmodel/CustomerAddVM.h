//
//  CustomerAddVM.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComCustomerDetail;

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddVM : NSObject

@property (nonatomic,strong) NSMutableArray *listArr;

@property(nonatomic,strong)ComCustomerDetail *model;

/**
 是否开启应收重置数据
 */
- (void)reSetDataWithReceiveAble:(BOOL)isReceive;

- (void)setComCustomerDetailModel:(ComCustomerDetail*)demodel andisReceive:(BOOL)isReceive;




@end

NS_ASSUME_NONNULL_END
