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
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.bounds = CGRectMake(0, 0, 200, 44);
    button.center = self.view.center;
    [button setTitle:@"欢迎进入明星衣橱" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)enterRootVC:(DidSelectedEnter)newBlock {
    self.block = newBlock;
}

#pragma mark - 进入主界面
- (void)enter:(UIButton *)sender {
    self.block();
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
