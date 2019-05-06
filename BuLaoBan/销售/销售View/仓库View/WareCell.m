//
//  WareCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/5/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import "WareCell.h"
#import "Warehouses.h"

@implementation WareCell{
    UILabel *_nameLab;
    UILabel *_desLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUP];
        
    }
    
    return self;
}

- (void)setUP{
    
    _nameLab = [BaseViewFactory labelWithFrame:CGRectMake(15, 12, 570, 16) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT16 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_nameLab];
    
    _desLab = [BaseViewFactory labelWithFrame:CGRectMake(15, 40, 570, 16) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@""];
    [self.contentView addSubview:_desLab];
    
    UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(0, 59, 600, 1) color:UIColorFromRGB(LineColorValue)];
    [self.contentView addSubview:line];
}

-(void)setWareModel:(Warehouses *)wareModel{
    _wareModel = wareModel;
    _nameLab.text = wareModel.warehouseName;
    _desLab.text = wareModel.desc;
}


@end
