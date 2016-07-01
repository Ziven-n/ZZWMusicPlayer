//
//  ZZWSearchModel.h
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/12.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWBasicModel.h"


@interface ZZWSearchModel : ZZWBasicModel

//主体参数:
//当前页数: current_page
//搜索字符: keyword
//资源总数: total_rows
//资源总页: total_page
//本页条数: page_size
//内容参数:
//文件名称: filename
//文件类型: extname
//M4A大小:  m4afilesize
//文件大小: filesize
//比特率: bitrate
//是否新歌: is_new
//持续时间: duration
//专辑名称: album_name
//歌手名称: singername
//歌曲HASH: hash
/*
{
    code = 0;
    data =     {
        "current_page" = 1;
        data =         (
                        {
                            "album_name" = SaiyanPride;
                            bitrate = 128;
                            duration = 206;
                            extname = mp3;
                            filename = "\U7f51\U7edc\U6b4c\U624b - S.S.S";
                            filesize = 3302004;
                            hash = 5ee40c24992531301412d3200416f88e;
                            isnew = 0;
                            m4afilesize = 849890;
                            othername = "";
                            singername = "\U7f51\U7edc\U6b4c\U624b";
                            songname = "S.S.S";
                        },
 
                        );
        keyword = SSS;
        "page_size" = 15;
        "total_page" = 8;
        "total_rows" = 108;
    };
    msg = "\U6570\U636e\U8bf7\U6c42\U6210\U529f";
    status = success;
}
*/


@property (nonatomic, copy) NSString *extname;                  //文件类型: extname

@property (nonatomic, copy) NSString *hashs;                    //歌曲HASH: hash

@property (nonatomic, assign) NSInteger filesize;               //文件大小: filesize

@property (nonatomic, assign) NSInteger isnew;                  //是否新歌: is_new

@property (nonatomic, assign) NSInteger m4afilesize;            //M4A大小:  m4afilesize

@property (nonatomic, copy) NSString *singername;               //歌手名称: singername

@property (nonatomic, assign) NSInteger duration;               //持续时间: duration

@property (nonatomic, copy) NSString *filename;                 //文件名称: filename

@property (nonatomic, copy) NSString *album_name;               //专辑名称: album_name

@property (nonatomic, assign) NSInteger bitrate;                //比特率: bitrate


/**
 *  获取搜索资源
 *
 *  @param text    搜索内容
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)getDataWithSearchParameters:(NSDictionary *)parameters
                      Success:(void(^)(NSArray *dataArray))success
                      Failure:(void(^)(NSError *error))failure;

@end
