//
//  UpImaPL.m
//  BuLaoBan
//
//  Created by souxiuyun on 2019/3/6.
//  Copyright © 2019 XX. All rights reserved.
//

#import "UpImaPL.h"

@implementation UpImaPL
/**
 上传图片
 
 @param imageArr 图片数组
 @param returnBlock 成功
 @param errorBlock 失败
 */
+ (void)UpImaPLupImgArr:(NSArray*)imageArr
            WithTypeDic:(NSDictionary *)typedic
        WithReturnBlock:(PLReturnValueBlock) returnBlock
          andErrorBlock:(PLErrorCodeBlock) errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"iPad_APP" forHTTPHeaderField:@"os"];
    [manager.requestSerializer setValue:@"3.6" forHTTPHeaderField:@"app-version"];
    [manager.requestSerializer setValue:@"12.1" forHTTPHeaderField:@"os-version"];
    User *user = [[UserPL shareManager] getLoginUser];
    if (user.authorization.length>0) {
        [manager.requestSerializer setValue:user.authorization forHTTPHeaderField:@"authorization"];
    }
    
    [HUD showLoading:nil];
    [manager POST:[NSString stringWithFormat:@"%@upload/pic",kbaseUrl] parameters:typedic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSInteger i = 0; i < imageArr.count; i ++) {
            UIImage *images = imageArr[i];
            NSData *picData = [self scaleImage:images toKb:500];
            [formData appendPartWithFileData:picData name:@"files" fileName:@"file.png" mimeType:@"image/png"];
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [HUD cancel];
        NSDictionary  *jsonDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
        
        if ([jsonDic[@"code"] intValue]==200) {
            returnBlock(jsonDic);
        }else{
            [HUD show:jsonDic[@"message"]];
            errorBlock(jsonDic[@"message"]);
        }   
        
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
         [HUD cancel];
        [HUD show:@"上传失败"];
        errorBlock(@"上传失败");
    }];
    
    
}




#pragma mark ===== 图片压缩至1m


/**
 压缩图片返回data
 @param image 传入图片
 @param kb 压缩至1M（1024kb）
 @return 压缩后的图片转化的base64编码
 */
+ (NSData *)scaleImage:(UIImage *)image toKb:(NSInteger)kb{
    
    kb*=400;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    NSLog(@"原始大小:%fkb",(float)[imageData length]/1024.0f);
    while ([imageData length] > kb && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    NSLog(@"当前大小:%fkb",(float)[imageData length]/1024.0f);
    //    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
}

@end
