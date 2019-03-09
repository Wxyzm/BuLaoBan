//
//  BillTopCellCell.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/9.
//  Copyright © 2019 XX. All rights reserved.
//

#import "BillTopCellCell.h"
#import "BillTopView.h"

@implementation BillTopCellCell

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
    BillTopView *topView = [[BillTopView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-100, 40)];
    [self.contentView addSubview:topView];
    
    
}

@end
