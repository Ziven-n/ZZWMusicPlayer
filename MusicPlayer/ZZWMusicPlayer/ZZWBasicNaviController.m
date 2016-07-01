//
//  ZZWBasicNaviController.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/2.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWBasicNaviController.h"

@interface ZZWBasicNaviController ()

@end

@implementation ZZWBasicNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setBackgroundColor:RGBA(115, 191, 126, 1)];
//    [self.navigationBar setBarTintColor:RGBA(10, 160, 100, 1)];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"player_slider_playback_left"] forBarMetrics:UIBarMetricsDefault];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
