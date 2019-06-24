//
//  PacKListDataManager.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/14.
//  Copyright © 2019 XX. All rights reserved.
//

#import "PacKListDataManager.h"
#import "PackListModel.h"

@implementation PacKListDataManager
@synthesize dataArr = _dataArr;

-(instancetype)init{
    self = [super init];
    if (self) {
        _pageSize = 40;
        _MaxpageNum = 5;
        self.dataArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
#pragma mark ====== public menthod
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

//插入一条新数据于oldmodel之后
-(void)insertOndDataaftermodel:(PackListModel *)oldmodel{
    //对数据从新排序展示
    PackListModel *model = [[PackListModel alloc]init];
//    model.meet = oldmodel.meet;
    model.dyelot = oldmodel.dyelot;
    model.pinyin = oldmodel.pinyin;
    model.keyboardshodReturn = 0;
    for (NSMutableArray *arr  in self.dataArr) {
        if ([arr containsObject:oldmodel]) {
            NSInteger row = [arr indexOfObject:oldmodel];
            [arr insertObject:model atIndex:row+1];
        }
    }
    [self sortWithArr];
}

//对数组排序
- (void )sortWithArr{
    //总数据数组
    NSMutableArray *dataArr = [self returnAllDatas];
    [self sortWithdatasArr:dataArr];
}

- (void )sortWithdatasArr:(NSMutableArray *)inputArr{
    for (PackListModel *model in inputArr) {
        NSMutableString *mutableString = [NSMutableString stringWithString:model.dyelot];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
        model.pinyin = mutableString;
    }
    //NSSortDescriptor 指定用于对象数组排序的对象的属性
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //对person进行排序
    [inputArr sortUsingDescriptors:sortDescriptors];
    NSMutableArray * titleAray = [NSMutableArray array];
    NSMutableArray * dataSource = [NSMutableArray array];
    [titleAray removeAllObjects];
    [dataSource removeAllObjects];
    //删除多余的字符
    for (int i = 0; i < inputArr.count; i++) {
        PackListModel *model = inputArr[i];
        //  NSString *str = [model.pinyin substringToIndex:1];
        if (![titleAray containsObject:model.pinyin]) {
            [titleAray addObject:model.pinyin];
        }
    }
    //将中文数据进行二维的数组的拆分
    //空数组后排放置
    NSMutableArray *emptyArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i< titleAray.count; i++) {
        NSString *str = titleAray[i];
        NSMutableArray *sortArray = [NSMutableArray array];
        for (PackListModel *model in inputArr) {
            if ([model.pinyin isEqualToString: str]) {
                [sortArray addObject:model];
            }
        }
        if ([str isEqualToString:@""]) {
            //空数组后排放置 按照米数排序
            NSArray *comArr  = [sortArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
                PackListModel  *model1 = (PackListModel*)obj1;
                PackListModel  *model2 = (PackListModel*)obj2;
                return [model2.meet compare:model1.meet]; //降序
            }];
            //设置卷号
            for (int j = 0; j<comArr.count; j++) {
                PackListModel *model = comArr[j];
                if (model.meet.length>0) {
                    model.reel = [NSString stringWithFormat:@"%d",j+1];
                }
            }
            [emptyArr addObjectsFromArray:comArr];
        }else{
            //设置卷号
            for (int j = 0; j<sortArray.count; j++) {
                PackListModel *model = sortArray[j];
                model.reel = [NSString stringWithFormat:@"%d",j+1];
            }
            [dataSource addObject:sortArray];
        }
    }
    if (emptyArr.count>0) {
        [dataSource addObject:emptyArr];
    }
    //将总数据放入一个数组
    NSMutableArray *totolArr = [NSMutableArray arrayWithCapacity:0];
    for (NSMutableArray *subArr in dataSource) {
        [totolArr addObjectsFromArray:subArr];
    }
    NSArray *rearr = [self splitArray:totolArr withSubSize:_pageSize];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:rearr];
}

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

#pragma mark -- 获取总计数据数组
- (NSMutableArray *)returnAllDatas{
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
    for (NSMutableArray *arr in self.dataArr) {
        [dataArr addObjectsFromArray:arr];
    }
    return dataArr;
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

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
}

-(NSMutableArray *)dataArr{
    return _dataArr;
}





@end
