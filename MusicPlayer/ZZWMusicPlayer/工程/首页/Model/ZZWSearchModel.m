//
//  ZZWSearchModel.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/12.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWSearchModel.h"


@implementation ZZWSearchModel


+ (void)getDataWithSearchParameters:(NSDictionary *)parameters
                            Success:(void(^)(NSArray *dataArray))success
                            Failure:(void(^)(NSError *error))failure {

    [ZZWRequestManager requestWithGet:YES type:ZZWRequestTypeOfsearchMusic parameter:parameters success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"failed"]) {
        
            success(nil);
            
        }else {
            
            NSArray *dataArray = (NSArray *)[[responseObject objectForKey:@"data"] objectForKey:@"data"];
            
            success(dataArray);
        }
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
}


@end
