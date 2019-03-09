//
//  SettingCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/5.
//  Copyright © 2019 XX. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

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
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(16, 0, 120, 50) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _rightIma = [[UIImageView alloc]initWithFrame:CGRectMake(276, 19, 8, 13)];
    _rightIma.image = [UIImage imageNamed:@"right"];
    [self.contentView addSubview:_rightIma];
    
    _lineView = [BaseViewFactory viewWithFrame:CGRectMake(0, 49, 300, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:_lineView];
}

@end
