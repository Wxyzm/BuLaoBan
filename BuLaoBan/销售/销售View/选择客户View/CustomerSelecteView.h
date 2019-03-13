//
//  CustomerSelecteView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComCustomer;
NS_ASSUME_NONNULL_BEGIN

typedef void(^CustomerSelecteViewReturnBlock)(ComCustomer *comCusModel);
@interface CustomerSelecteView : UIView

/**
 类型：1是按销售，其余是按客户
 */
@property (nonatomic, assign) NSInteger    SelectYype;

@property (nonatomic, strong) NSMutableArray      *dataArr;
@property (nonatomic, copy) CustomerSelecteViewReturnBlock      returnBlock;

- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
