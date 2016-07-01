//
//  ZZWBasicViewController.m
//  ZZWMusicPlayer
//
//  Created by zzw on 16/6/2.
//  Copyright © 2016年 zzw. All rights reserved.
//

#import "ZZWBasicViewController.h"

@interface ZZWBasicViewController ()

@end



@implementation ZZWBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

////重写set方法创建播放栏
//- (void)setShowPlaybutton:(BOOL)ShowPlaybutton {
//    
//    if (ShowPlaybutton) {
//        
//        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, ZScreenHeight-60-.5, ZScreenWidth, .5)];
//        lable.backgroundColor = [UIColor colorWithWhite:0.f alpha:.2f];
//        [self.view addSubview:lable];
//        
//        UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, ZScreenHeight-60, ZScreenWidth, 60)];
//        baseView.backgroundColor = [UIColor whiteColor];
//        
//        
//        
//        [self.view.window addSubview:baseView];
//    
//    }else {
//        
//    }
//    
//}

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
