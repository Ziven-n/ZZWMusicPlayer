//
//  ZZWRequestManager.h
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/7.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求类型
 */
typedef enum :NSUInteger {
    
    ZZWRequestTypeOfgetmusicPlace,                      //播放地址
    ZZWRequestTypeOfgetLyrics,                          //歌词列表
    ZZWRequestTypeOfgetSingerMessage,                   //歌手信息
    ZZWRequestTypeOfsearchMusic                         //资源搜索
    
}ZZWRequestType;

@interface ZZWRequestManager : NSObject


/**
 *  请求网络
 *
 *  @param isGET       是否是GET请求
 *  @param requestType 请求类型，是哪个网络请求
 *  @param parameters  传入参数
 *  @param success     请求成功回调
 *  @param failure     请求失败回调
 */
+ (void)requestWithGet:(BOOL)isGET
               type:(ZZWRequestType)requestType
          parameter:(NSDictionary *)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;


@end
