//
//  AccountListCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Accounts;

typedef void(^AccountListCellReturnBlock)(Accounts *account);

@interface AccountListCell : UITableViewCell

@property (nonatomic, strong) UILabel *accnameLab;
@property (nonatomic, strong) UILabel *accNumLab;
@property (nonatomic, strong) UILabel *accKindLab;
@property (nonatomic, strong) Accounts *account;

@property (nonatomic, copy) AccountListCellReturnBlock returnBlock;



@end

NS_ASSUME_NONNULL_END
