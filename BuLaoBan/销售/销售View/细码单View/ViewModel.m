//
//  ViewModel.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/6/18.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ViewModel.h"
#import "PackListModel.h"
#import "SaleSamModel.h"
#import "DeliveDetails.h"

@implementation ViewModel
@synthesize dataArr = _dataArr;


-(instancetype)init{
    self = [super init];
    if (self) {
        _pageSize = 20;
        _MaxpageNum = 5;
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
#pragma mark ====== 新增删除一页数据
- (void)addModelsFrameArr:(NSMutableArray *)arr{
    NSArray *rearr = [self splitArray:arr withSubSize:(int)_pageSize];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:rearr];
    [self reelSort];
}
//新增一页空数据
- (void)addOnepageNewDatas{
    if (self.dataArr.count>=_MaxpageNum) {
        [HUD show:[NSString stringWithFormat:@"最多添加%ld组表格",(long)_MaxpageNum]];
        return;
    }
    NSMutableArray *emptyArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<_pageSize; i++) {
        PackListModel *model = [[PackListModel alloc]init];
        [emptyArr addObject:model];
    }
    [self.dataArr addObject:emptyArr];
}
//删除一页
-(void)deleteOnepageDatasWithIndex:(NSInteger)index{
    if (self.dataArr.count==1) {
        [HUD show:@"至少需要一组表格"];
        return;
    }
    if (self.dataArr.count<=index) {
        return;
    }
    [self.dataArr removeObjectAtIndex:index];
}

#pragma mark ====== 卷号排序

- (void)reelSort{
    NSArray *allArr = [self returnAllDatas];
    NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
    for (PackListModel *model in allArr) {
        if (model.dyelot.length>0&&![nameArr containsObject:model.dyelot]) {
            [nameArr addObject:model.dyelot];
        }
    }
     for (int i = 0; i< nameArr.count; i++) {
         NSString *name = nameArr[i];
         NSMutableArray *sortArray = [NSMutableArray array];
         for (PackListModel *model in allArr) {
             if ([model.dyelot isEqualToString: name]) {
                 [sortArray addObject:model];
             }
         }
         //设置卷号
         for (int j = 0; j<sortArray.count; j++) {
             PackListModel *model = sortArray[j];
             model.reel = [NSString stringWithFormat:@"%d",j+1];

         }
     }
}


#pragma mark ====== 合计

//卷号数量合计
- (NSInteger )getReelTotal{
    NSInteger a = 0;
    NSMutableArray *dataArr = [self returnAllDatas];
    for (PackListModel *model in dataArr) {
        if (model.reel.length>0) {
            a+=1;
        }
    }
    return a;
}
//米数数量合计
- (float )getMeetTotal{
    float a = 0.00;
    NSMutableArray *dataArr = [self returnAllDatas];
    for (PackListModel *model in dataArr) {
        if ([model.meet floatValue]>0) {
            a+=[model.meet floatValue];
        }
    }
    return a;
}
#pragma mark -- 获取总计数据数组
- (NSMutableArray *)returnAllDatas{
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
    for (NSMutableArray *arr in self.dataArr) {
        [dataArr addObjectsFromArray:arr];
    }
    return dataArr;
}

- (NSMutableArray *)getValidDatas{
    NSMutableArray *validArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *dataArr = [self returnAllDatas];
    for (PackListModel *model in dataArr) {
        if (model.reel.length>0) {
            [validArr addObject:model];
        }
    }
    return validArr;
}



#pragma mark -- getset
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
}

-(NSMutableArray *)dataArr{
    return _dataArr;
}

#pragma mark -- 将数组拆分成固定长度
/**
 *  将数组拆分成固定长度的子数组
 *  @param array 需要拆分的数组
 *  @param subSize 指定长度
 */
- (NSMutableArray*)splitArray: (NSMutableArray*)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count% subSize ==0? (array.count/ subSize) : (array.count/ subSize +1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray*arr = [[NSMutableArray alloc]init];
    //利用总个数进行循环，将指定长度的元素加入数组
    for(int i =0; i < count; i ++) {
        //数组下标
        int index =i* subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray*arr1= [[NSMutableArray alloc]init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while(j < subSize*(i +1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j +=1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 mutableCopy]];
    }
    return[arr mutableCopy];
}


@end
