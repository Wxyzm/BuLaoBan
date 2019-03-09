//
//  CompView.h
//  BuLaoBan
//
//  Created by apple on 2019/2/12.
//  Copyright © 2019年 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Component;

NS_ASSUME_NONNULL_BEGIN

@interface CompView : UIView

@property (nonatomic, strong) UILabel *comNameLab;

@property (nonatomic, strong) UITextField *valueTxt;

@property (nonatomic, strong) Component *component;

@end

NS_ASSUME_NONNULL_END
