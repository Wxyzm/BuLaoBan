//
//  StaffCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyUsers;
NS_ASSUME_NONNULL_BEGIN
typedef void(^StaffCellSettingBlock)(CompanyUsers *model);
@interface StaffCell : UITableViewCell

@property (nonatomic,strong) CompanyUsers *model;;

@property (nonatomic,copy) StaffCellSettingBlock SettingBlock;


@end

NS_ASSUME_NONNULL_END
