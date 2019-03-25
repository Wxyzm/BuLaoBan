//
//  ReceiveBaseView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/23.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComCustomer;

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveBaseView : UIView
@property (nonatomic,strong) ComCustomer *commodel;   //用户信息

@property (nonatomic,strong) NSMutableArray *listArr; //账户列表

- (void)dismiss;
- (void)showInView;

@end

NS_ASSUME_NONNULL_END
