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

@property (nonatomic, copy) NSString *sampId;    //样品ID
@property (nonatomic, copy) NSString *urlStr;    //样品图片
@property (nonatomic, copy) NSString *name;      //名称
@property (nonatomic, copy) NSString *itemNo;    //编号
@property (nonatomic, copy) NSString *color;     //颜色
@property (nonatomic, copy) NSString *unitPrice; //单价
@property (nonatomic, copy) NSString *pieces;    //匹数
@property (nonatomic, copy) NSString *salesVol;  //销货量
@property (nonatomic, copy) NSString *unit;      //单位
@property (nonatomic, copy) NSString *money;     //金额
@property (nonatomic, strong) NSMutableArray *packingList; //细码单


//输入总码数据则细码单无法输入，若输入细码单，则总码单是细码单算出来的
@property (nonatomic, assign) BOOL caninput;     //是否手动输入（米数。匹数等）
@property (nonatomic, assign) BOOL canselect;    //是否选择填写细码单




@end

NS_ASSUME_NONNULL_END
