//
//  SampleSearchResultCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/13.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SampleSearchResultCell.h"
@implementation SampleSearchResultCell{
    UIImageView *_faceIma;
    UILabel *_numberLab;
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
    
    _numberLab = [BaseViewFactory labelWithFrame:CGRectMake(62, 7, 280, 15) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_numberLab];
    _nameLab= [BaseViewFactory labelWithFrame:CGRectMake(62, 29, 280, 15) textColor:UIColorFromRGB(0x666666) font:APPFONT(10) textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(62, 59, 238, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
    
}


-(void)setSamModel:(Sample *)samModel{
    _samModel = samModel;
    [_faceIma sd_setImageWithURL:[NSURL URLWithString:samModel.samplePicKey] placeholderImage:nil];
    _numberLab.text  = samModel.itemNo;
    _nameLab.text = samModel.name;
}


@end
