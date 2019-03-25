//
//  ReceivablesView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComCustomer;
@class Accounts;
NS_ASSUME_NONNULL_BEGIN

typedef void(^ReceivablesViewReturnBlock)(NSInteger tag);
@interface ReceivablesView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextField *MoneyTxt;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

/**
 欠款
 */
@property (weak, nonatomic) IBOutlet UILabel *arreLab;

//客户model
@property (nonatomic,strong) ComCustomer *commodel;
//客户账户
@property (nonatomic,strong) Accounts *account;


@property (nonatomic, strong) YLButton *accountBtn;
@property (nonatomic, copy) ReceivablesViewReturnBlock returnBlock;




@end

NS_ASSUME_NONNULL_END
