//
//  CustomerSelecteView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerSelecteView : UIView

@property (nonatomic, strong) NSMutableArray      *dataArr;

- (void)showView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
