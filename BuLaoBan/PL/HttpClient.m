//
//  HttpClient.m
//  ZhongFangTong
//
//  Created by apple on 2018/6/5.
//  Copyright © 2018年 XX. All rights reserved.
//

#import "HttpClient.h"
@implementation HttpClient

{
    NSOperationQueue *_queue;
    NSString         *_baseUrl;
}


#pragma mark   ========== init


+ (HttpClient *)sharedHttpClient
{
    static HttpClient *_sharedPHPHelper = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _sharedPHPHelper = [[self alloc] initWithBaseUrl:kbaseUrl];
    });
    
    return _sharedPHPHelper;
}


- (instancetype)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];
    if (self) {
        _baseUrl = baseUrl;
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

#pragma mark   ========== get  post

//获取request
- (void)setRequestWithInfo:(NSDictionary *)info url:(NSString *)urlStr method:(NSString *)method requset:(NSMutableURLRequest *)request
{
    NSURL *url;
    if ([method isEqualToString:@"GET"]) {
        if (info) {
            NSArray *keyArray = [info allKeys];
            NSMutableString *str = [NSMutableString string];
            [str appendString:@"?"];
            NSString *key = keyArray[0];
            [str appendString:[NSString stringWithFormat:@"%@=%@",key,[info objectForKey:key]]];
            for (int i = 1;i < keyArray.count;i++) {
                key = keyArray[i];
                if (key.length)
                    [str appendString:[NSString stringWithFormat:@"&%@=%@",key,[info objectForKey:key]]];
                
            }
            url = [NSURL URLWithString:[[NSString stringWithFormat:@"%@%@%@",_baseUrl,urlStr?urlStr:@"",str] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        } else {
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_baseUrl,urlStr?urlStr:@""]];
        }
    } else
    {
        NSString *URLWithString = [NSString stringWithFormat:@"%@%@",_baseUrl,urlStr?urlStr:@""];
        NSString *encodedString = (NSString *)
        
        CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  
                                                                  (CFStringRef)URLWithString,
                                                                  
                                                                  (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                  
                                                                  NULL,
                                                                  
                                                                  kCFStringEncodingUTF8));
        url = [NSURL URLWithString:[encodedString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    }
    
    [request setURL:url];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:NET_TIME_OUT];
    [request setHTTPMethod:method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [request setValue:@"" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"iPad_APP" forHTTPHeaderField:@"os"];
    [request setValue:@"3.6" forHTTPHeaderField:@"app-version"];
    [request setValue:@"12.1" forHTTPHeaderField:@"os-version"];
    User *user = [[UserPL shareManager] getLoginUser];
    if (user.authorization.length>0) {
        [request setValue:user.authorization forHTTPHeaderField:@"authorization"];

    }
    

    if ([method isEqualToString:@"POST"]) {
        NSArray *keyArray = [info allKeys];
        if (keyArray.count >0) {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
          //  NSString * sendStr= [GlobalMethod dictionaryToJson:info];
          //  NSData *data = [sendStr dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
            NSLog(@"%@",jsonString);
        }else{
            NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
            [request setHTTPBody:data];
        }
    }
}

#pragma mark   ========== Config

//get方式获取
- (void)requestGET:(NSString *)url
          Withdict:(NSDictionary *)dict
   WithReturnBlock:(ReturnBlock)returnBlock
     andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:dict url:url method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             NSDictionary *dic = [HttpClient valueWithJsonString:str];
             if ([dic[@"code"] intValue]==200) {
                 returnBlock(dic);
             }else{
                 [HUD show:dic[@"message"]];
                 errorBlock(dic[@"message"]);
             }
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [HUD show:@"网络错误"];
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}

//post方式获取
- (void)requestPOST:(NSString *)url
           Withdict:(NSDictionary *)dict
    WithReturnBlock:(ReturnBlock)returnBlock
      andErrorBlock:(ErrorBlock)errorBlock{
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:dict url:url method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [HUD showLoading:nil];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [HUD cancel];
             NSString *str = operation.responseString;
             NSDictionary *dic = [HttpClient valueWithJsonString:str];
             if ([dic[@"code"] intValue]==200) {
                 returnBlock(dic);
             }else{
                 [HUD show:dic[@"message"]];
                 errorBlock(dic[@"message"]);
             }
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [HUD cancel];
         [HUD show:@"网络错误"];
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}





//PUT 请求
- (void)requestPUTWithURLStr:(NSString *)urlStr
                    paramDic:(NSDictionary *)paramDic
             WithReturnBlock:(ReturnBlock)returnBlock
               andErrorBlock:(ErrorBlock)errorBlock{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",_baseUrl,urlStr?urlStr:@""]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setTimeoutInterval:NET_TIME_OUT];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"iPad_APP" forHTTPHeaderField:@"os"];
    [request setValue:@"3.6" forHTTPHeaderField:@"app-version"];
    [request setValue:@"12.1" forHTTPHeaderField:@"os-version"];
    User *user = [[UserPL shareManager] getLoginUser];
    if (user.authorization.length>0) {
        [request setValue:user.authorization forHTTPHeaderField:@"authorization"];
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDic options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //  NSString * sendStr= [GlobalMethod dictionaryToJson:info];
    //  NSData *data = [sendStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [HUD showLoading:nil];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        [HUD cancel];
        if (error) {
            [HUD show:@"网络错误"];
            errorBlock(@"网络错误");
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
              NSDictionary *resultDic = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                if ([resultDic[@"code"] intValue]==200) {
                    [HUD show:resultDic[@"message"]];
                    returnBlock(resultDic);
                }else{
                    [HUD show:resultDic[@"message"]];
                    errorBlock(resultDic[@"message"]);
                }
                
                returnBlock(resultDic);
            });
        }
    }] resume];
 
}


//Delete 请求
- (void)requestDeleteWithURLStr:(NSString *)urlStr
                       paramDic:(NSDictionary *)paramDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    //请求图片,请求网页时需要加入这句,因为AFN默认的请求的是json
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
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
    
    [manager DELETE:[NSString stringWithFormat:@"%@%@",_baseUrl,urlStr] parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *resultDic = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:nil];
        if ([resultDic[@"code"] intValue]==200) {
            [HUD show:@"删除成功"];
            returnBlock(resultDic);
        }else{
            [HUD show:resultDic[@"message"]];
            errorBlock(resultDic[@"message"]);
        }
        
        returnBlock(resultDic);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (error) {
            [HUD show:@"网络错误"];
            errorBlock(@"网络错误");
        }
    }];
   
}


//json解析
+ (id)valueWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    
    id value = [NSJSONSerialization JSONObjectWithData:jsonData
                                               options:NSJSONReadingMutableContainers
                                                 error:&err];
    if(err) {
        return nil;
    }
    
    return [GlobalMethod deleteEmpty:value];
}

#pragma mark   ==========////////  登录注册   ////////==========
/**
 用户登录
 */
- (void)accountLoginWithDic:(NSDictionary *)upDic
            WithReturnBlock:(ReturnBlock)returnBlock
              andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/user/account/login" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
    
    
    
}

/**
 退出登录
 */
- (void)accountLoginoutWithDic:(NSDictionary *)upDic
               WithReturnBlock:(ReturnBlock)returnBlock
                 andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/user/account/logout" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
    
}

/**
 生成手机验证码
 */
- (void)accountCheckCodeWithDic:(NSDictionary *)upDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/user/account/checkCode" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
    
}

/**
 获取图片验证码
 
 */
- (void)accountImageCheckCodeWithDic:(NSDictionary *)upDic
                     WithReturnBlock:(ReturnBlock)returnBlock
                       andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:nil url:@"/user/account/imageCheckCode" method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
    
}

/**
 用户注册
 */
- (void)accountRegisterWithDic:(NSDictionary *)upDic
               WithReturnBlock:(ReturnBlock)returnBlock
                 andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/user/account/register" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
    
}


#pragma mark   ==========获取默认公司ID公司名称
/**
 获取默认公司ID公司名称
 */
- (void)accountGetComIdAndComNameWithReturnBlock:(ReturnBlock)returnBlock
                                   andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:nil url:@"/user/account/settings" method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}
#pragma mark   ==========////////  Sample   ////////==========
#pragma mark   ==========修改样品
#pragma mark   ==========删除样品
#pragma mark   ==========新增样品
/**
 新增样品
 */
- (void)sampleSamplesAddWithDic:(NSDictionary *)upDic
                WithReturnBlock:(ReturnBlock)returnBlock
                  andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/samples" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}

#pragma mark   ==========样品搜索
/**
 样品搜索
 */
- (void)sampleSamplesSearchWithDic:(NSDictionary *)upDic
                   WithReturnBlock:(ReturnBlock)returnBlock
                     andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/samples/search" method:@"POST" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}

#pragma mark   ==========移动图片
#pragma mark   ==========获取样品列表
/**
 获取样品列表
 */
- (void)sampleSamplesRegisterWithDic:(NSDictionary *)upDic
                     WithReturnBlock:(ReturnBlock)returnBlock
                       andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:upDic url:@"/samples" method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}

#pragma mark   ==========获取样品详情
/**
 获取样品详情
 */
- (void)sampleSamplesDetailWithsampleId:(NSString *)sampleId
                        WithReturnBlock:(ReturnBlock)returnBlock
                          andErrorBlock:(ErrorBlock)errorBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:nil url:[NSString stringWithFormat:@"/samples/%@",sampleId] method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}

#pragma mark   ==========转为正式样品

#pragma mark   ==========////////  User_Profile - 个人设置   ////////==========
#pragma mark   ==========User_Profile - 获取用户个人资料
/**
 获取用户个人资料
 */
- (void)profileGetUserAccountInfoWithReturnBlock:(ReturnBlock)returnBlock
                                   andErrorBlock:(ErrorBlock)errorBlock{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [self setRequestWithInfo:nil url:@"/user/account" method:@"GET" requset:request];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             NSString *str = operation.responseString;
             returnBlock(str);
         });
     }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         errorBlock(@"网络错误");
     }];
    
    [_queue addOperation:operation];
}









@end
