//
//  CustomerAddManView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/7/4.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CompanyUsers;
@class Participants;
NS_ASSUME_NONNULL_BEGIN
@protocol CustomerAddManViewDelegate <NSObject>

- (void)didselectedsaleManListWithModel:(CompanyUsers *)saleManModel;

- (void)didselectedparManListWithModel:(Participants *)parManModel;

- (void)didselectedCloseBtn;

@end

@interface CustomerAddManView : UIView

@property (nonatomic,strong) NSMutableArray *saleManArr;

@property (nonatomic,strong) NSMutableArray *parManArr;

@property (nonatomic,weak) id<CustomerAddManViewDelegate> delegate;



@end

NS_ASSUME_NONNULL_END
