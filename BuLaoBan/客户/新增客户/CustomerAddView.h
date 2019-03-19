//
//  CustomerAddView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/19.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComCustomerDetail;
NS_ASSUME_NONNULL_BEGIN

@interface CustomerAddView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIView *sideView;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *comNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *linkManTxt;
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *mailTxt;
@property (weak, nonatomic) IBOutlet UITextField *adressTxt;
@property (weak, nonatomic) IBOutlet UITextField *moneyTxt;
@property (weak, nonatomic) IBOutlet UITextField *memoTxt;

@property (nonatomic, strong) YLButton *salerBtn;
@property (nonatomic, strong) YLButton *spartakeBtn;

@property(nonatomic,strong)ComCustomerDetail *model;

@end

NS_ASSUME_NONNULL_END
