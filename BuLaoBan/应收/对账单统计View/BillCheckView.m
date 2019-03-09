//
//  BillCheckView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/27.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "BillCheckView.h"

@implementation BillCheckView{
    
    UILabel *_totalLab;    //总计
    UILabel *_acceptedLab; //已收
    UILabel *_surplusLab;  //剩余

}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUp];
    }
    return self;
}

- (void)setUp{
    CGFloat Width = (ScreenWidth -400)/3;
    
    _totalLab =  [BaseViewFactory labelWithFrame:CGRectMake(0, 29, Width, 20) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"¥ 12000.00"];
    [self addSubview:_totalLab];
    
    _acceptedLab =  [BaseViewFactory labelWithFrame:CGRectMake(Width, 29, Width, 20) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"¥ 4000.00"];
    [self addSubview:_acceptedLab];
    _surplusLab =  [BaseViewFactory labelWithFrame:CGRectMake(Width*2, 29, Width, 20) textColor:UIColorFromRGB(RedColorValue) font:APPFONT16 textAligment:NSTextAlignmentCenter andtext:@"¥ 8000.00"];
    [self addSubview:_surplusLab];
    
    NSArray *titleArr = @[@"应收金额",@"已收金额",@"应收余额"];
    for (int i = 0; i<3; i++) {
        UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(Width *i, 9, Width, 15) textColor:UIColorFromRGB(0x858585) font:APPFONT12 textAligment:NSTextAlignmentCenter andtext:titleArr[i]];
        [self addSubview:topLab];
        if (i!=0) {
            UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(Width *i-0.5, 15, 1, 30) color:UIColorFromRGB(LineColorValue)];
            [self addSubview:line];

        }
    }
   
}




@end
