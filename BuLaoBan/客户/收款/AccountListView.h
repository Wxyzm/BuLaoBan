//
//  AccountListView.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/22.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Accounts;
NS_ASSUME_NONNULL_BEGIN

typedef void(^AccountListViewReturnBlock)(NSInteger tag,Accounts *account);


@interface AccountListView : UIView

@property (nonatomic,strong) NSMutableArray *dataArr;;

@property (nonatomic, copy) AccountListViewReturnBlock returnBlock;


@end

NS_ASSUME_NONNULL_END
