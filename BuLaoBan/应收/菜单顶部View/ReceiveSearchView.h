//
//  ReceiveSearchView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ReceiveSearchViewBlock)(NSInteger tag,CGRect frame);

@interface ReceiveSearchView : UIView

/**
 0:开始日期 1:结束日期 2:选择客户 3：选择业务员  4：查询  5：重置
 */
@property (nonatomic , copy) ReceiveSearchViewBlock returnBlock;         //

/**
 设置按钮标题

 @param tag 0:开始日期 1:结束日期 2:客户 3：业务员
 */
- (void)setTitle:(NSString *)title withTag:(NSInteger)tag;
/**
 重置标题

 @param tag 0:开始日期 1:结束日期 2:客户 3：业务员
 */
- (void)clearBtnTitleWithTag:(NSInteger)tag;


@end

NS_ASSUME_NONNULL_END
