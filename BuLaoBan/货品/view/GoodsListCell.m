//
//  GoodsListCell.m
//  BuLaoBan
//
//  Created by apple on 2019/2/10.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "GoodsListCell.h"

@implementation GoodsListCell{
    UIImageView *_faceIma;
    UILabel  *_numLab;
    UILabel *_nameLab;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    
    _faceIma =[[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 40, 40)];
    _faceIma.backgroundColor = UIColorFromRGB(BackColorValue);
    [self.contentView addSubview:_faceIma];
    
    _numLab = [BaseViewFactory labelWithFrame:CGRectMake(62, 11, 226, 18) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"货品编号"];
    [self.contentView addSubview:_numLab];
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(62, 35, 226, 16) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@"货品名称"];
    [self.contentView addSubview:_nameLab];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(10, 0, 290, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];

}

-(void)setSample:(Sample *)sample{
    _sample = sample;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:sample.samplePicKey] placeholderImage:nil];
    _nameLab.text = sample.name;
    _numLab.text = sample.itemNo;
    if (sample.isSelected) {
        self.contentView.backgroundColor = UIColorFromRGB(0xeff6f9);
    }else{
        self.contentView.backgroundColor = UIColorFromRGB(WhiteColorValue);

    }
    
}



@end
