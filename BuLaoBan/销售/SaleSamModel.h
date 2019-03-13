//
//  SaleSamModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleSamModel : NSObject

@property (nonatomic, copy) NSString *urlStr;    //样品图片
@property (nonatomic, copy) NSString *name;      //名称
@property (nonatomic, copy) NSString *itemNo;    //编号
@property (nonatomic, copy) NSString *color;     //颜色
@property (nonatomic, copy) NSString *unitPrice; //单价
@property (nonatomic, copy) NSString *pieces;    //匹数
@property (nonatomic, copy) NSString *salesVol;  //销货量
@property (nonatomic, copy) NSString *unit;      //单位
@property (nonatomic, copy) NSString *money;     //金额




@property (nonatomic, strong) NSArray *packingList; //细码单


@end

NS_ASSUME_NONNULL_END
