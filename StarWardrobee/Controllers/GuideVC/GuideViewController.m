//
//  GuideViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "GuideViewController.h"
#include "CHTTPAsk.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)dealloc {
    self.block = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //请求出加载引导图片，然后延迟1，2秒，再触发跳转
//    [CHTTPAsk netHttpForGuidePictureWithBlock:^(NSMutableArray *arr) {
//        
//    }];
    
    //如果有返回数据的时候延时2秒眺望下一界面。
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(Ent) userInfo:nil repeats:NO];
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    
    //如果没有返回数据的时候直接跳转
    //[self Ent];
    
}
#pragma mark - 进入主界面
- (void)Ent {
    self.block();
}
- (void)enterRootVC:(DidSelectedEnter)newBlock {
    self.block = newBlock;
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
