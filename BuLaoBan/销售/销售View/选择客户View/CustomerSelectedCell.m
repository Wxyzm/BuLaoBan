//
//  CustomerSelectedCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/12.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerSelectedCell.h"
#import "ComCustomer.h"
@implementation CustomerSelectedCell
{
    UILabel *_nameLab;
    UILabel *_phoneLab;
    
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
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(12, 10, 174, 18) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _phoneLab= [BaseViewFactory labelWithFrame:CGRectMake(12, 34, 174, 16) textColor:UIColorFromRGB(0x858585) font:APPFONT13 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_phoneLab];
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 59, 300, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
    
}

-(void)setModel:(ComCustomer *)model{
    _model = model;
    _nameLab.text = model.name;
    _phoneLab.text = model.telephone;
}


@end
