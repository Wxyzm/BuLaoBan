//
//  ManSelectCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/20.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Participants;
@class CompanyUsers;
NS_ASSUME_NONNULL_BEGIN

@interface ManSelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *faceIma;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property(nonatomic,strong)Participants *participants; //参与者
@property(nonatomic,strong)CompanyUsers *companyUsers; //业务员


@end

NS_ASSUME_NONNULL_END
