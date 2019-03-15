//
//  PacklistCell.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PackListModel;

typedef void(^PacklistCellInsertBlock)(PackListModel *oldModel);
@interface PacklistCell : UITableViewCell

@property (nonatomic, strong) PackListModel      *packModel;
@property (nonatomic, strong) UITextField *dyelotTxt;   //缸号
@property (nonatomic, strong) UITextField *reelTxt;     //卷号
@property (nonatomic, strong) UITextField *meetTxt;     //米数
@property (nonatomic, copy) PacklistCellInsertBlock InsertBlock;     //

@end

NS_ASSUME_NONNULL_END
