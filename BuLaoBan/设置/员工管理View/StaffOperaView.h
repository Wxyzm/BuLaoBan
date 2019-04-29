//
//  StaffOperaView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/25.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyUsers;
NS_ASSUME_NONNULL_BEGIN

@interface StaffOperaView : UIView

@property (nonatomic,strong) CompanyUsers *model;;

- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
