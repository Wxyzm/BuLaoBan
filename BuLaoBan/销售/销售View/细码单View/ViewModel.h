//
//  ViewModel.h
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/18.
//  Copyright © 2019 XX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

@property(nonatomic, assign) NSInteger pageSize;    //一页数据，默认是40
@property(nonatomic, assign) NSInteger MaxpageNum;  //默认最多五页
@property(nonatomic, strong) NSMutableArray *dataArr;  //传入数据

//新增一页空数据
- (void)addOnepageNewDatas;
// 删除1页  index:对应页数
-(void)deleteOnepageDatasWithIndex:(NSInteger)index;
//卷号数量合计
- (NSInteger )getReelTotal;
//米数数量合计
- (float )getMeetTotal;
//获取数组中有效的数据
- (NSMutableArray *)getValidDatas;
//卷号排序
- (void)reelSort;
//通过数组添加数据
- (void)addModelsFrameArr:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
