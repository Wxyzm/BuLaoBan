//
//  DatePickerView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PGDatePicker;
typedef void(^DatePickerViewReturnBlock)(NSInteger dateType,NSString *dateStr);

NS_ASSUME_NONNULL_BEGIN

@interface DatePickerView : UIView

@property (nonatomic, strong) PGDatePicker      *datePicker;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *dateLab;
@property (nonatomic, strong) UIButton          *downBtn;
/**
  1：开始时间   2：结束时间
 */
@property (nonatomic, assign) NSInteger      dateType;

/**
  1：开始时间   2：结束时间
 */
@property (nonatomic, copy) DatePickerViewReturnBlock      returnBlock;


- (void)showViewWithFrame:(CGRect)frame;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
