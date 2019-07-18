//
//  CustomerAddReceOpenView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddReceOpenView : UIView

@property (nonatomic,strong) UILabel  *titleLab;

@property (nonatomic,strong) NSMutableArray  *dataArr;

@property (nonatomic,copy) NSString  *nature;
/**
 0 新增 1 编辑
 */
@property (nonatomic,assign) NSInteger  type;
/**
 要修改的ID
 */
@property (nonatomic,copy) NSString  *comID;


- (void)showTheView;
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
