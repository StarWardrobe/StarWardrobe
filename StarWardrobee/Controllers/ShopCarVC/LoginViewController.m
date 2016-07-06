//
//  LoginViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "LoginViewController.h"
#import "ShopViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createView];
    [self createMainView];
    
}
- (void)createView {
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 64)];
    view.backgroundColor =[UIColor grayColor];
    //view.alpha = 0.3;
    [self.view addSubview:view];
    
    for (NSInteger i=0; i<2; i++) {
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame =CGRectMake(10+(kMainBoundsW-50)*i, 17, 30, 30);
        btn.tag = 20+i;
        if (0==i) {
            [btn setBackgroundImage:[UIImage imageNamed:@"mx_search_item_arrow_left@2x"] forState:UIControlStateNormal];
        }else{
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitle:@"跳过" forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    UILabel *label = [[UILabel alloc]init];
    label.center = CGPointMake(kMainBoundsW/2, 32);
    label.bounds = CGRectMake(0, 0, 100, 30);
    label.text =@"用户信息";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
}
- (void)createMainView {
    for (NSInteger i=0; i<2; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 150+60*i, 30, 30)];
        [self.view addSubview:image];
        UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(50, 150+60*i, kMainBoundsW-100, 50)];
        [self.view addSubview:tf];
        if (0==i) {
            image.image =[UIImage imageNamed:@"icon_phone@2x"];
            tf.placeholder = @"请输入用户名";
        }else {
            image.image =[UIImage imageNamed:@"icon_titlebar_search_logo@2x"];
            tf.placeholder = @"密码";
        }
    }
    
    
}
- (void)buttonClick:(UIButton *)sender {
    if (20==sender.tag) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [self presentViewController:[ShopViewController new] animated:YES completion:nil];
    }
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
