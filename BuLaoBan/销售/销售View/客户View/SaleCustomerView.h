//
//  SaleCustomerView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/19.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SaleCustomerViewBtnBlock)(NSInteger tag);


@interface SaleCustomerView : UIView

@property (nonatomic, strong) YLButton *customerBtn;      //选择客户

@property (nonatomic, strong) YLButton *kindBtn;          //类型

//@property (nonatomic, strong) YLButton *wareBtn;          //仓库，扣减库存时显示


@property (nonatomic, strong) YLButton *scanBtn;          //扫码选货

/**
 0:选择客户   1：选择类型    2：扫码  3：选择仓库
 */
@property (nonatomic, copy) SaleCustomerViewBtnBlock returnBlock;

//- (void)wareBtnIsshow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
