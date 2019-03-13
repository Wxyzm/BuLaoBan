//
//  CustomerSelecteView.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/7.
//  Copyright © 2019 XX. All rights reserved.
//

#import "CustomerSelecteView.h"
#import "ComCustomer.h"
#import "CustomerSelectedCell.h"

@interface CustomerSelecteView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UIButton      *backButton;

@property (nonatomic, strong) UIView      *sideView;

@property (nonatomic, strong) BaseTableView *ListTab;               //列表

@end

@implementation CustomerSelecteView{
    
    NSMutableArray *_dataSource;
    NSMutableArray * _titleAray;
    NSMutableArray * _sortAray;

    UITextField *_searchTxt;
    BOOL        _isShow;
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor clearColor];
        _dataSource = [NSMutableArray arrayWithCapacity:0];
        _titleAray = [NSMutableArray arrayWithCapacity:0];
        _sortAray= [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    return self;
}

- (void)setUP{
    [self addSubview:self.backButton];
    _sideView = [BaseViewFactory viewWithFrame:CGRectMake(ScreenWidth, 0, 300, ScreenHeight) color:UIColorFromRGB(WhiteColorValue)];
    [self addSubview:_sideView];
    [self addtopView];
    [self addSearChTxt];
    [_sideView addSubview:self.ListTab];

    
    
}

#pragma mark ========= 添加搜索
- (void)addtopView{
    UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(16, 20, 100, 44)
                                         textColor:UIColorFromRGB(BlackColorValue)
                                              font:APPFONT17
                                      textAligment:NSTextAlignmentLeft
                                           andtext:@"客户列表"];
    [_sideView addSubview:lab];
    UIButton *addBtn = [BaseViewFactory buttonWithFrame:CGRectMake(216, 20, 84, 44)
                                                   font:APPFONT15 title:@"新增客户"
                                             titleColor:UIColorFromRGB(BlueColorValue)
                                              backColor:UIColorFromRGB(WhiteColorValue)];
    [_sideView addSubview:addBtn];
}
- (void)addSearChTxt{
    UIView *bgView = [BaseViewFactory viewWithFrame:CGRectMake(0, 64, 300, 56) color:UIColorFromRGB(0xdcdcdc)];
    [_sideView addSubview:bgView];
    
    _searchTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(10, 10, 280, 36) font:APPFONT14 placeholder:@"输入客户名称/电话" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(0x858585) delegate:self];
    _searchTxt.leftViewMode = UITextFieldViewModeAlways;
    _searchTxt.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _searchTxt.leftView = [BaseViewFactory viewWithFrame:CGRectMake(0, 0, 12, 36) color:UIColorFromRGB(WhiteColorValue)];
    [bgView addSubview:_searchTxt];
    [_searchTxt addTarget:self
                   action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
#pragma mark ========= dataArr
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self sortWithArr:_dataArr];
    [self.ListTab reloadData];
    
}



#pragma mark ========= tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataSource[section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleAray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *toBeReturned = [[NSMutableArray alloc]init];
    for (int i = 0; i<_titleAray.count; i++) {
        NSString *str = _titleAray[i];
        //转化为大写
        str = [str uppercaseString];
        [toBeReturned addObject:str];
        
    }
    return toBeReturned;
}
#pragma mark - UITableViewDataSource
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    view.backgroundColor = UIColorFromRGB(BackColorValue);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 20)];
    NSString *str = _titleAray[section];
    //转化为大写
    str = [str uppercaseString];
    label.text = str;
    [view addSubview:label];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    CustomerSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CustomerSelectedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    ComCustomer *model = _dataSource[indexPath.section][indexPath.row];
    cell.model = model;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ComCustomer *model = _dataSource[indexPath.section][indexPath.row];
    WeakSelf(self);
    if (weakself.returnBlock) {
        weakself.returnBlock(model);
    }
    [self dismiss];
}


#pragma mark ====== textfieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length<=0) {
        [self sortWithArr:_dataArr];
        [self.ListTab reloadData];
        return;
    }
    [_sortAray removeAllObjects];
    for (int i =0; i<_dataArr.count; i++) {
        ComCustomer *model = _dataArr[i];
        if ([model.telephone containsString:textField.text]||[model.name containsString:textField.text]) {
            [_sortAray addObject:model];
        }
    }
    [self sortWithArr:_sortAray];
    [self.ListTab reloadData];
}
#pragma mark ====== 对数组排序
- (void)sortWithArr:(NSMutableArray *)dataArr{
    for (ComCustomer *model in dataArr) {
        NSMutableString *mutableString = [NSMutableString stringWithString:model.name];
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
        CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
        model.pinyin = mutableString;
    }
    //NSSortDescriptor 指定用于对象数组排序的对象的属性
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES]];
    //对person进行排序
    [dataArr sortUsingDescriptors:sortDescriptors];
    
    _titleAray = [NSMutableArray array];
    [_titleAray removeAllObjects];
    [_dataSource removeAllObjects];
    //删除多余的字符
    for (int i = 0; i < dataArr.count; i++) {
        ComCustomer *model = dataArr[i];
        NSString *str = [model.pinyin substringToIndex:1];
        if (![_titleAray containsObject:str]) {
            [_titleAray addObject:str];
        }
    }
    //将中文数据进行二维的数组的拆分
    for (int i = 0; i< _titleAray.count; i++) {
        NSString *str = _titleAray[i];
        NSMutableArray *sortArray = [NSMutableArray array];
        for (ComCustomer *model in dataArr) {
            if ([model.pinyin hasPrefix:str]) {
                [sortArray addObject:model];
            }
        }
        [_dataSource addObject:sortArray];
    }
    
}



#pragma - mark public method
- (void)showView
{
    
    _sideView.frame =CGRectMake(ScreenWidth, 0, 300, ScreenHeight);
    _searchTxt.text = @"";
    AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
    [app.splitViewController.view addSubview:self];
    _isShow = YES;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth-300, 0, 300, ScreenHeight);
    }];
    
    
}

- (void)dismiss
{
    if (!_isShow) return;
    _isShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        _sideView.frame =CGRectMake(ScreenWidth, 0, 300, ScreenHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        _backButton.alpha = 0.3;
    }];
}



#pragma mark ========= get

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [[UIButton alloc] initWithFrame:self.bounds];
        _backButton.backgroundColor = [UIColor blackColor];
        _backButton.alpha = 0.3;
        [_backButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
-(BaseTableView *)ListTab{
    if (!_ListTab) {
        _ListTab = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 120, 300, ScreenHeight-120) style:UITableViewStylePlain];
        _ListTab.delegate = self;
        _ListTab.dataSource = self;
        _ListTab.backgroundColor = UIColorFromRGB(BackColorValue);
        _ListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _ListTab.sectionIndexBackgroundColor = [UIColor clearColor];

        if (@available(iOS 11.0, *)) {
            _ListTab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
        }
    }
    return _ListTab;
}




@end
