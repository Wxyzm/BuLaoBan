//
//  DatePickerView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/11.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PGDatePicker;
NS_ASSUME_NONNULL_BEGIN

@interface DatePickerView : UIView
@property (nonatomic, strong) PGDatePicker      *datePicker;



- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
