//
//  ZZWRequestManager.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWRequestManager.h"
#import "AFNetworking.h"

#define zBaseURL @"http://apis.baidu.com/geekery/music/"

/**
 *  获取播放地址(const写在NSString前表示指针本身不可修改，写在后面表示指针指向的内容不可修改，两种写法都是为了使定义的字符串只可读不可写)
 */
static  NSString *const getmusicPlace = @"playinfo";
/**
 *  获取歌词列表
 */
static NSString *const getLyrics = @"krc";
/**
 *  获取歌手信息
 */
static NSString *const getSingerMessage = @"singer";
/**
 *  音乐资源搜索
 */
static NSString *const searchMusic = @"query";


@implementation ZZWRequestManager


+ (void)requestWithGet:(BOOL)isGET
               type:(ZZWRequestType)requestType
          parameter:(NSDictionary *)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure {
    
    NSString *requestStr = nil;
    
    switch (requestType) {
        case ZZWRequestTypeOfgetmusicPlace:
            
            requestStr = getmusicPlace;
            
            break;
        case ZZWRequestTypeOfgetLyrics:
            
            requestStr = getLyrics;
            
            break;
        case ZZWRequestTypeOfgetSingerMessage:
            
            requestStr = getSingerMessage;
            
            break;
        case ZZWRequestTypeOfsearchMusic:
            
            requestStr = searchMusic;
            
            break;
            
        default:
            break;
    }
    
    //拼接 URL
    NSString *urlString = [NSString stringWithFormat:@"%@%@", zBaseURL, requestStr];
    
    NSMutableDictionary *mParams = parameters.mutableCopy;
    if (mParams == nil) {
        mParams = [NSMutableDictionary dictionary];
    }
    
    //创建SessionManager对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //接收数据添加@"text/html"类型
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //设置请求头
    [manager.requestSerializer setValue:@"8e16ba4f0894ec96f497fa897f4d5a72" forHTTPHeaderField:@"apikey"];
    
    if (isGET) {
        [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            ZLog(@"网络请求成功啦!");
            success(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ZLog(@"网络请求失败--原因是-->%@",error);
            failure(error);
        }];
    }else {
        [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            ZLog(@"网络请求成功啦!");
            success(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            ZLog(@"网络请求失败--原因是-->%@",error);
            failure(error);
        }];
        
    }
}


@end
