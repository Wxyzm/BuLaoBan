//
//  ReceivablesView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceivablesView : UIView
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextField *MoneyTxt;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

/**
 欠款
 */
@property (weak, nonatomic) IBOutlet UILabel *arreLab;


@property (nonatomic, strong) YLButton *accountBtn;

@end

NS_ASSUME_NONNULL_END
