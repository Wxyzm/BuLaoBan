//
//  AccountEditView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Accounts;

NS_ASSUME_NONNULL_BEGIN

typedef void(^AccountEditViewReturnBlock)(NSInteger tag,Accounts *account);

@interface AccountEditView : UIView

@property (nonatomic, copy) AccountEditViewReturnBlock returnBlock;

@property (nonatomic,strong) Accounts *account;

@property (nonatomic,copy) NSString *comId;   //公司id
@property (nonatomic,copy) NSString *companyCurrencyId;   //货币Id


@end

NS_ASSUME_NONNULL_END
