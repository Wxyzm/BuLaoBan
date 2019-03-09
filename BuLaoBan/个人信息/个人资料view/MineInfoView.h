//
//  MineInfoView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/28.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class UserInfoModel;

@interface MineInfoView : UIView

@property (nonatomic, strong) UserInfoModel *infoModel;
@property (nonatomic, strong) NSDictionary *infoDic;

- (NSDictionary *)returnUpDic;
@end

NS_ASSUME_NONNULL_END
