//
//  ReceiveBaseView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/23.
//  Copyright © 2019 XX. All rights reserved.
//

#import "ReceiveBaseView.h"
#import "ReceivablesView.h"
#import "AccountListView.h"
#import "AccountEditView.h"

@interface ReceiveBaseView ()

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) ReceivablesView  *receView;
@property (nonatomic, strong) AccountListView  *listView;
@property (nonatomic, strong) AccountEditView  *editView;

@end


@implementation ReceiveBaseView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [self addSubview:self.backButton];
    [self addSubview:self.receView];
    [self addSubview:self.listView];
    [self addSubview:self.editView];
}
#pragma mark ========= menthod

- (void)dismiss{
    
    
    
}

- (void)showInView{
    
    
    
    
}

#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor clearColor];
        _backButton.alpha = 0.3;
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

-(ReceivablesView *)receView{
    
    if (!_receView) {
        _receView = [[[NSBundle mainBundle] loadNibNamed:@"ReceivablesView" owner:self options:nil] lastObject];
        
    }
    
    return _receView;
}

-(AccountListView *)listView{
    if (!_listView) {
        _listView = [[AccountListView alloc]initWithFrame:CGRectZero];
        _listView.hidden = YES;
    }
    return _listView;
}

-(AccountEditView *)editView{
    if (!_editView) {
        _editView = [[AccountEditView alloc]initWithFrame:CGRectZero];
        _editView.hidden = YES;
    }
    return _editView;
}


@end
