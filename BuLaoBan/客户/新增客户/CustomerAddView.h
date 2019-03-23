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
typedef void(^CustomerAddViewReturnBtnClick)(NSInteger tag,ComCustomerDetail *model);

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

/**
 0:保存  1：业务员  2：参与者
 */
@property (nonatomic, copy) CustomerAddViewReturnBtnClick returnBlock;

@property(nonatomic,strong)ComCustomerDetail *model;
@property(nonatomic,strong)NSMutableArray *parArr;   //参与者
@property(nonatomic,strong)NSMutableArray *comArr;   //业务员

/**
 类型   1参与者    2业务员
 */
@property(nonatomic,assign)NSInteger type;



- (NSDictionary *)getSetUPDic;
- (void)showTheView;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
