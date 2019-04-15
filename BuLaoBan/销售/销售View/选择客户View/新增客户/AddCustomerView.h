//
//  AddCustomerView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddCustomerViewReturnBlock)(NSInteger tag);

@interface AddCustomerView : UIView


@property (nonatomic,copy) AddCustomerViewReturnBlock returnBlock;


- (void)showinView:(UIView *)view;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
