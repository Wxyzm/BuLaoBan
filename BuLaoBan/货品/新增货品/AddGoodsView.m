//
//  AddGoodsView.m
//  BuLaoBan
//
//  Created by apple on 2019/2/11.
//  Copyright © 2019年 XX. All rights reserved.
//

#import "AddGoodsView.h"
#import "picModel.h"
#import "UpImaPL.h"
#import "HUPhotoBrowser.h"

@interface AddGoodsView ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TZImagePickerControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation AddGoodsView{
    
    UITextField *_nameTxt;    //货品名称
    UITextField *_specTxt;    //规格
    UITextField *_supplyTxt;    //供应

    UILabel *_unitLab;       //单位
    NSMutableArray *_photosArr; //照片
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(WhiteColorValue);
        _photosArr = [NSMutableArray arrayWithCapacity:0];
        [self setUP];
    }
    return self;
}

- (void)setUP{
    UILabel *topLab = [BaseViewFactory labelWithFrame:CGRectMake(0, 0, 600, 44) textColor:UIColorFromRGB(WhiteColorValue) font:APPFONT14 textAligment:NSTextAlignmentCenter andtext:@"新增货品"];
    topLab.backgroundColor = UIColorFromRGB(BlueColorValue);
    [self addSubview:topLab];
    
    UIButton *closeBtn = [BaseViewFactory setImagebuttonWithWidth:13 imagePath:@"window_close"];
    [closeBtn addTarget:self action:@selector(closeBtnCLock) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(563, 14, 23, 23);
    [self addSubview:closeBtn];
    
    
    
    UILabel *numLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 44, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:@"货品编号*"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"货品编号*"];
    [attStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xFC3030) range:NSMakeRange(4, 1)];
    numLab.attributedText = attStr;
    [self addSubview:numLab];
    
   
    
    _numberTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(150, 44, 430, 44) font:APPFONT13 placeholder:@"输入货品编号" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self];
    _numberTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_numberTxt];

    _nameTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(150, 88, 430, 44) font:APPFONT13 placeholder:@"输入货品名称" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self];
    _nameTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_nameTxt];
    
    _componentLab = [BaseViewFactory labelWithFrame:CGRectMake(150, 44*3, 430, 44) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@"选择"];
    [self addSubview:_componentLab];

    _widthLab = [BaseViewFactory labelWithFrame:CGRectMake(150, 44*4, 430, 44) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@"选择"];
    [self addSubview:_widthLab];
    
    _weightLab = [BaseViewFactory labelWithFrame:CGRectMake(150, 44*5, 430, 44) textColor:UIColorFromRGB(BlueColorValue) font:APPFONT13 textAligment:NSTextAlignmentRight andtext:@"选择"];
    [self addSubview:_weightLab];
    
    _specTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(150, 44*6, 430, 44) font:APPFONT13 placeholder:@"输入规格" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self];
    _specTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_specTxt];
    
    
    _supplyTxt = [BaseViewFactory textFieldWithFrame:CGRectMake(150, 44*7, 430, 44) font:APPFONT13 placeholder:@"输入供应商" textColor:UIColorFromRGB(BlackColorValue) placeholderColor:UIColorFromRGB(LitterBlackColorValue) delegate:self];
    _supplyTxt.textAlignment = NSTextAlignmentRight;
    [self addSubview:_supplyTxt];
    
    NSArray *titleArr = @[@"货品名称",@"成分",@"门幅",@"克重",@"规格",@"供应商",@"图片"];
    for (int i = 0; i<titleArr.count; i++) {
        UILabel *lab = [BaseViewFactory labelWithFrame:CGRectMake(20, 88 +44*i, 100, 44) textColor:UIColorFromRGB(BlackColorValue) font:APPFONT14 textAligment:NSTextAlignmentLeft andtext:titleArr[i]];
        [self addSubview:lab];
        
        UIView *line = [BaseViewFactory viewWithFrame:CGRectMake(20, 88 +44*i, 580, 1) color:UIColorFromRGB(LineColorValue)];
        [self addSubview:line];
        if (i==1||i==2||i==3) {
            UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            typeBtn.tag = i+1000;
            typeBtn.frame = CGRectMake(150,  88 +44*i, 450, 44);
            [typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:typeBtn];

        }
        
    }
    
    
     //configCollectionView
    [self configCollectionView];
    
    UILabel *showLab = [BaseViewFactory labelWithFrame:CGRectMake(20, 486, 400, 15) textColor:UIColorFromRGB(0x9b9b9b) font:APPFONT12 textAligment:NSTextAlignmentLeft andtext:@"最多可上传9张（.gif,.jpg,.jpeg,.png）"];
    [self addSubview:showLab];
    
    UIButton *saveBtn = [BaseViewFactory buttonWithFrame:CGRectMake(self.width/2-150, self.height-46, 300, 40) font:APPFONT14 title:@"保存" titleColor:UIColorFromRGB(WhiteColorValue) backColor:UIColorFromRGB(BlueColorValue)];
    saveBtn.layer.cornerRadius = 2;
    [saveBtn addTarget:self action:@selector(saveAllInfo) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];

    
}


/**
 configCollectionView
 */
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat  _margin = 16;
    CGFloat _itemWH = 60;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 386, 600, 92) collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColorFromRGB(WhiteColorValue);
    _collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self  addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    [_collectionView reloadData];
}

#pragma mark ========== 选择属性
- (void)typeBtnClick:(UIButton *)btn{
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(btn.tag-1000);
    }
 
}

- (void)closeBtnCLock{
    WeakSelf(self);
    if (weakself.choseBlock) {
        weakself.choseBlock(0);
    }
}
#pragma mark ========== 删除照片
- (void)deleteBtnClik:(UIButton *)btn{
    
    
}

#pragma mark ========== set
-(void)setSampleModel:(SampleDetail *)sampleModel{
    _sampleModel = sampleModel;
    if (_sampleModel.itemNo.length>0) {
        if (_isCopy) {
            //复制新增
            _numberTxt.userInteractionEnabled = YES;

        }else{
            //编辑时无法改变
            _numberTxt.userInteractionEnabled = NO;
        }
    }else{
        //新增时可以改变
        _numberTxt.userInteractionEnabled = YES;
    }
    _numberTxt.text = sampleModel.itemNo.length>0?sampleModel.itemNo:@"";
    _nameTxt.text = sampleModel.name.length>0?sampleModel.name:@"";
    _componentLab.text = sampleModel.component.length>0?sampleModel.component:@"选择";
    _widthLab.text = sampleModel.width.length>0?sampleModel.width:@"选择";
    _weightLab.text = sampleModel.weight.length>0?sampleModel.weight:@"选择";
    _specTxt.text = sampleModel.specification.length>0?sampleModel.specification:@"";
    _unitLab.text = sampleModel.primaryUnit.length>0?sampleModel.primaryUnit:@"";
    _supplyTxt.text = sampleModel.supply.length>0?sampleModel.supply:@"";

    [_photosArr removeAllObjects];
    [self.collectionView reloadData];
    if (sampleModel.pics.count>0) {
        NSDictionary *dic = sampleModel.pics[0];
        NSArray *imageArr = [picModel mj_objectArrayWithKeyValuesArray:dic[@"pic"]];
        for (picModel *model in imageArr) {
            [_photosArr addObject:model];
            [self getImageFromUrlModel:model];
        }
    }
    
}
- (void)getImageFromUrlModel:(picModel *)model{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //在此处处理耗时操作
        NSURL * url = [NSURL URLWithString:model.sampleDocKey];
        NSData * data = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            //在主线程刷新
            model.showImage = image;
            [self.collectionView reloadData];
        });
    });
}

#pragma mark ========== 保存
- (void)saveAllInfo
{
    if (_numberTxt.text.length<=0) {
        [HUD show:@"请输入货品编号"];
        return;
    }
    
        NSDictionary *paDic;
        if (_sampleModel.sampleId.length>0) {
            paDic = @{@"bizType":@"11",
                        @"bizId":_sampleModel.sampleId
                        };
        }else{
            User *tuser = [[UserPL shareManager] getLoginUser];
            paDic =@{@"bizType":@"10",
                     @"bizId":tuser.defutecompanyId
                     };
        }
        
        NSMutableArray *upArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *upmdoelArr = [NSMutableArray arrayWithCapacity:0];
        for (picModel *model in _photosArr) {
            if (model.sampleDocKey.length<=0) {
                [upArr addObject:model.showImage];
                [upmdoelArr addObject:model];
            }
        }
        if (upArr.count<=0) {
            if (_sampleModel.sampleId.length<=0) {
                //新增
                [self addNewSampleWithPicArr:_photosArr];

            }else{
                if (_isCopy) {
                    //复制新增
                    [self addNewSampleWithPicArr:_photosArr];
                    return;
                }
                //编辑
                    [self changeSampleWithPicArr:_photosArr];
                
                }
            return;
        }
        [UpImaPL UpImaPLupImgArr:upArr WithTypeDic:paDic WithReturnBlock:^(id returnValue) {
            NSArray *picIdsArr = returnValue[@"picIds"];
            NSArray *picKeysArr = returnValue[@"picKeys"];
            for (int i = 0; i<upmdoelArr.count; i++) {
                picModel *model = upmdoelArr[i];
                if (i<picIdsArr.count) {
                    model.docId =picIdsArr[i];
                }
                if (i<picKeysArr.count) {
                    model.sampleDocKey = picKeysArr[i];
                }
            }
            if (_sampleModel.sampleId.length<=0) {
                //新增
                [self addNewSampleWithPicArr:_photosArr];
            }else{
                if (_isCopy) {
                    //复制新增
                    [self addNewSampleWithPicArr:_photosArr];
                    return;
                }
                //编辑
                [self changeSampleWithPicArr:_photosArr];
            }
            
        } andErrorBlock:^(NSString *msg) {
            
        }];
    
}
/*
 UITextField *_numberTxt;  //货品编号
 UITextField *_nameTxt;    //货品名称
 UITextField *_specTxt;    //规格
 UILabel *_componentLab;  //成分
 UILabel *_widthLab;      //门幅
 UILabel *_weightLab;     //克重
 UILabel *_unitLab;       //单位
 NSMutableArray *_photosArr; //照片
 _sampleModel = sampleModel;
 _numberTxt.text = sampleModel.itemNo.length>0?sampleModel.itemNo:@"";
 _nameTxt.text = sampleModel.name.length>0?sampleModel.name:@"";
 _componentLab.text = sampleModel.component.length>0?sampleModel.component:@"选择";
 _widthLab.text = sampleModel.width.length>0?sampleModel.width:@"选择";
 _weightLab.text = sampleModel.weight.length>0?sampleModel.weight:@"选择";
 _specTxt.text = sampleModel.specification.length>0?sampleModel.specification:@"";
 _unitLab.text = sampleModel.primaryUnit.length>0?sampleModel.primaryUnit:@"";
 */
#pragma mark ==========修改样品
- (void)changeSampleWithPicArr:(NSArray *)picUrlArr{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:_sampleModel.companyId forKey:@"companyId"];
    NSMutableDictionary *attrdic = [[NSMutableDictionary alloc]init];
    if (_numberTxt.text.length>0) {
        [attrdic setValue:_numberTxt.text forKey:@"1"];
    }else{
        [attrdic setValue:@"" forKey:@"1"];
    }
    if (_nameTxt.text.length>0) {
        [attrdic setValue:_nameTxt.text forKey:@"2"];
    }else{
        [attrdic setValue:@"" forKey:@"2"];
    }
    if (_componentLab.text.length>0&&![_componentLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_componentLab.text forKey:@"3"];
    }else{
        [attrdic setValue:@"" forKey:@"3"];
    }
    if (_widthLab.text.length>0&&![_widthLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_widthLab.text forKey:@"4"];
    }else{
        [attrdic setValue:@"" forKey:@"4"];
    }
    if (_weightLab.text.length>0&&![_weightLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_weightLab.text forKey:@"5"];
    }else{
        [attrdic setValue:@"" forKey:@"5"];
    }
    if (_specTxt.text.length>0) {
        [attrdic setValue:_specTxt.text forKey:@"6"];
    }else{
        [attrdic setValue:@"" forKey:@"6"];
    }
    if (_supplyTxt.text.length>0) {
        [attrdic setValue:_supplyTxt.text forKey:@"21"];
    }
    [dic setValue:attrdic forKey:@"customAttribute"];
    if (picUrlArr.count>0) {
        NSMutableArray *urlArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<picUrlArr.count; i++) {
            picModel *model = picUrlArr[i];
            [urlArr addObject:model.docId];
        }
        NSString *urlstr = [urlArr componentsJoinedByString:@","];
        NSDictionary *urldic = @{@"roleType":@"0",@"picIds":urlstr};
        NSArray *arr = @[urldic];
        [dic setValue:arr forKey:@"pics"];
    }
    [[HttpClient sharedHttpClient] requestPUTWithURLStr:[NSString stringWithFormat:@"/samples/%@",_sampleModel.sampleId] paramDic:dic WithReturnBlock:^(id returnValue) {
        NSLog(@"%@",returnValue);
        [HUD show:@"修改成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDetail" object:nil userInfo:dic];

        WeakSelf(self);
        weakself.choseBlock(0);
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
   
}
#pragma mark ==========新增样品
- (void)addNewSampleWithPicArr:(NSArray *)picUrlArr{
    User *tuser = [[UserPL shareManager] getLoginUser];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:tuser.defutecompanyId forKey:@"companyId"];
    NSMutableDictionary *attrdic = [[NSMutableDictionary alloc]init];
    if (_numberTxt.text.length>0) {
        [attrdic setValue:_numberTxt.text forKey:@"1"];
    }else{
        [attrdic setValue:@"" forKey:@"1"];
    }
    if (_nameTxt.text.length>0) {
        [attrdic setValue:_nameTxt.text forKey:@"2"];
    }else{
        [attrdic setValue:@"" forKey:@"2"];
    }
    if (_componentLab.text.length>0&&![_componentLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_componentLab.text forKey:@"3"];
    }else{
        [attrdic setValue:@"" forKey:@"3"];
    }
    if (_widthLab.text.length>0&&![_widthLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_widthLab.text forKey:@"4"];
    }else{
        [attrdic setValue:@"" forKey:@"4"];
    }
    if (_weightLab.text.length>0&&![_weightLab.text isEqualToString:@"选择"]) {
        [attrdic setValue:_weightLab.text forKey:@"5"];
    }else{
        [attrdic setValue:@"" forKey:@"5"];
    }
    if (_specTxt.text.length>0) {
        [attrdic setValue:_specTxt.text forKey:@"6"];
    }else{
        [attrdic setValue:@"" forKey:@"6"];
    }
    if (_supplyTxt.text.length>0) {
        [attrdic setValue:_supplyTxt.text forKey:@"21"];
    }
    [dic setValue:attrdic forKey:@"customAttribute"];

    if (picUrlArr.count>0) {
        NSMutableArray *urlArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<picUrlArr.count; i++) {
            picModel *model = picUrlArr[i];
            [urlArr addObject:model.docId];
        }
        NSString *urlstr = [urlArr componentsJoinedByString:@","];
        NSDictionary *urldic = @{@"roleType":@"0",@"picIds":urlstr};
        NSArray *arr = @[urldic];
        [dic setValue:arr forKey:@"pics"];
    }
    [[HttpClient sharedHttpClient] requestPOST:@"/samples" Withdict:dic WithReturnBlock:^(id returnValue) {
        [HUD show:@"新增成功"];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshList" object:nil userInfo:dic];
        WeakSelf(self);
        weakself.choseBlock(0);
      
        
        
    } andErrorBlock:^(NSString *msg) {
        
    }];
    
}



#pragma mark ========== UICollectionViewdelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photosArr.count+1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    if (indexPath.row == _photosArr.count) {
        cell.imageView.image = [UIImage imageNamed:@"upload-photo"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        picModel *model = _photosArr[indexPath.row];
        cell.imageView.image = model.showImage;
        cell.deleteBtn.hidden = NO;
    }
    cell.gifLable.hidden = YES;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
        if (indexPath.row ==_photosArr.count) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择",@"取消", nil];
            UIWindow   *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            alertWindow.rootViewController = [[UIViewController alloc] init];
            alertWindow.windowLevel = UIWindowLevelAlert + 1;
            [alertWindow makeKeyAndVisible];
            [sheet showInView:alertWindow.rootViewController.view];
        }else{
            //查看大图
            NSMutableArray *imageArr = [NSMutableArray arrayWithCapacity:0];
            for (picModel *model in _photosArr) {
                [imageArr addObject:model.showImage];
            }
            if (imageArr.count<=0) {
                return ;
            }
            UIImageView *imageView = [[UIImageView alloc]initWithImage:imageArr[indexPath.row]];
            [HUPhotoBrowser showFromImageView:imageView withImages:imageArr placeholderImage:nil atIndex:indexPath.row dismiss:nil];
        }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }else if (buttonIndex == 2) {
        
    }
}
- (void)takePhoto {
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        
        AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
        [app.splitViewController presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
    
}
#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:5 delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    imagePickerVc.navigationBar.barTintColor = UIColorFromRGB(BlueColorValue);
    imagePickerVc.oKButtonTitleColorDisabled = UIColorFromRGB(BlueColorValue);
    imagePickerVc.oKButtonTitleColorNormal = UIColorFromRGB(BlueColorValue);
    imagePickerVc.navigationBar.translucent = NO;
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop =NO;
    imagePickerVc.circleCropRadius = 100;
    
    //imagePickerVc.allowPreview = NO;
#pragma mark - 到这里为止
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        AppDelegate *app = (AppDelegate *)[[UIApplication  sharedApplication] delegate];
        [app.splitViewController presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        // tzImagePickerVc.sortAscendingByModificationDate = self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}
- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    if (_photosArr.count>=9) {
        [HUD show:@"最多添加9张图片"];
        return;
    }
    
    picModel *model  = [[picModel alloc]init];
    model.showImage = image;
    [_photosArr addObject:model];
    [_collectionView reloadData];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}

// The picker should dismiss itself; when it dismissed these handle will be called.
// If isOriginalPhoto is YES, user picked the original photo.
// You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
// The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    for (UIImage *image in photos) {
        if (_photosArr.count>=9) {
            [HUD show:@"最多添加9张图片"];
            return;
        }
        picModel *model  = [[picModel alloc]init];
        model.showImage = image;
        [_photosArr addObject:model];
        
    }
    [_collectionView reloadData];
    
    
    // 1.打印图片名字
    [self printAssetsName:assets];
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma mark ========== get

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        
        // set appearance / 改变相册选择页的导航栏外观
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


@end
