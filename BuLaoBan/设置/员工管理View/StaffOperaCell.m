//
//  StaffOperaCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/4/26.
//  Copyright © 2019 XX. All rights reserved.
//

#import "StaffOperaCell.h"

@implementation StaffOperaCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 0, 300, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 43, 300, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
}

@end
