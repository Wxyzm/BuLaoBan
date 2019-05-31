//
//  GoodsDetailView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsDetailView.h"
#import "SampleDetail.h"
#import "picModel.h"
#import "HUPhotoBrowser.h"
@interface GoodsDetailView ()<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *picArr;

@end


@implementation GoodsDetailView{
    
    UILabel *_numblaLab;    //货品编号
    UILabel *_nameLab;      //名称
    UILabel *_componentLab; //成分
    UILabel *_widthLab;     //门幅
    UILabel *_weightLab;    //克重
    UILabel *_specLab;      //规格
    UILabel *_unitLab;      //单位
    UILabel *_supplyLab;      //供应商


}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(BackColorValue);
        _picArr = [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    return  self;
}

- (void)setUP{
    CGFloat viewWidth = ScreenWidth - 400;
    UIView *topview = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, viewWidth, 250) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:topview];
    
    _numblaLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 16, viewWidth-32, 28) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(20) textAligment:NSTextAlignmentLeft andtext:@"货品编号"];
    [self addSubview:_numblaLab];
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 56, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(16) textAligment:NSTextAlignmentLeft andtext:@"货品名称："];
    [self addSubview:_nameLab];
    
    _componentLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 88, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"成分："];
    [self addSubview:_componentLab];
    
    _widthLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 118, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"门幅："];
    [self addSubview:_widthLab];
    
    _weightLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 148, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"克重："];
    [self addSubview:_weightLab];
    
    _specLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 178, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"规格："];
    [self addSubview:_specLab];
    
    _supplyLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 208, viewWidth-32, 20) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(14) textAligment:NSTextAlignmentLeft andtext:@"供应商："];
    [self addSubview:_supplyLab];
    
    UIView *line =  [BaseViewFactory viewWithFrame:CGRectMake(0, 248, viewWidth, 10) color:UIColorFromRGB(BackColorValue)];
    [self addSubview:line];
    
    UIView *boomview = [BaseViewFactory viewWithFrame:CGRectMake(0, 258, viewWidth, 200) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:boomview];
    
   UILabel * showlab = [BaseViewFactory labelWithFrame:CGRectMake(16, 274, viewWidth-32, 22) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT(16) textAligment:NSTextAlignmentLeft andtext:@"货品图片"];
    [self addSubview:showlab];
    
    
    //configCollectionView
    [self configCollectionView];
    
}


/**
 configCollectionView
 */
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat  _margin = 16;
    CGFloat _itemWH = 100;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 266, ScreenWidth - 400, 132) collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self  addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [_collectionView reloadData];
}
#pragma mark ========== UICollectionViewdelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _picArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    cell.deleteBtn.hidden = YES;
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.row;
    picModel *model = _picArr[indexPath.row];
    cell.imageView.image = model.showImage;
    
    cell.contentView.backgroundColor = UIColorFromRGB(BackColorValue);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    //查看大图
    NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
    for (picModel *model in _picArr) {
        [imageArr addObject:model.showImage];
    }
    if (imageArr.count<=0) {
        return ;
    }
    UIImageView *imageView = [[UIImageView alloc]initWithImage:imageArr[indexPath.row]];
    [HUPhotoBrowser showFromImageView:imageView withImages:imageArr placeholderImage:nil atIndex:indexPath.row dismiss:nil];
    
}


-(void)setSampledetail:(SampleDetail *)sampledetail{
    _sampledetail = sampledetail;
    _numblaLab.text = sampledetail.itemNo;
    _nameLab.text = [NSString stringWithFormat:@"货品名称：%@",sampledetail.name];
    _componentLab.text = [NSString stringWithFormat:@"成分：%@",sampledetail.component];
    _widthLab.text = [NSString stringWithFormat:@"门幅：%@",sampledetail.width];
    _weightLab.text = [NSString stringWithFormat:@"克重：%@",sampledetail.weight];
    _specLab.text = [NSString stringWithFormat:@"规格：%@",sampledetail.specification];
    _unitLab.text = [NSString stringWithFormat:@"单位：%@",sampledetail.viceUnit];
    _supplyLab.text = [NSString stringWithFormat:@"供应商：%@",sampledetail.supply];

    [_picArr removeAllObjects];
    [self.collectionView reloadData];
    if (sampledetail.pics.count>0) {
        NSDictionary *dic = sampledetail.pics[0];
        NSArray *imageArr = [picModel mj_objectArrayWithKeyValuesArray:dic[@"pic"]];
        for (picModel *model in imageArr) {
            [_picArr addObject:model];
            [self getImageFromUrlModel:model];
        }
    }
    
    
}


- (void)getImageFromUrlModel:(picModel *)model{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //在此处处理耗时操作
        NSURL * url = [NSURL URLWithString:model.sampleDocKey];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            //在主线程刷新
            model.showImage = image;
            [self.collectionView reloadData];
        });
    });
}



@end
