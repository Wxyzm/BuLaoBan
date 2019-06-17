//
//  PacKListDataManager.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PackListModel;
NS_ASSUME_NONNULL_BEGIN

@interface PacKListDataManager : NSObject

@property(nonatomic, assign) NSInteger pageSize;    //一页数据，默认是20
@property(nonatomic, assign) NSInteger MaxpageNum;  //默认最多五页
@property(nonatomic, strong) NSMutableArray *dataArr;  //传入数据

//新增一页空数据
- (void)addOnepageNewDatas;
// 删除1页  index:对应页数
-(void)deleteOnepageDatasWithIndex:(NSInteger)index;
//插入一条新数据于oldmodel之后
-(void)insertOndDataaftermodel:(PackListModel *)oldmodel;
//对数组排序
- (void )sortWithArr;
- (void )sortWithdatasArr:(NSMutableArray *)inputArr;
//卷号数量合计
- (NSInteger )getReelTotal;
//米数数量合计
- (float )getMeetTotal;
//获取数组中有效的数据
- (NSMutableArray *)getValidDatas;
/**
 *  将数组拆分成固定长度的子数组
 *  @param array 需要拆分的数组
 *  @param subSize 指定长度
 */
- (NSArray*)splitArray: (NSArray*)array withSubSize : (int)subSize;

@end

NS_ASSUME_NONNULL_END
