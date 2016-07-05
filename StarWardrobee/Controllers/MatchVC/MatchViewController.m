//
//  MatchViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "MatchViewController.h"
#import "MatchContexViewController.h"
#import "PreferenceViewController.h"

typedef enum: NSInteger {
    headerButtonTag = 10,
} ViewTag;

@interface MatchViewController ()
{
     UILabel *label; 
    MatchContexViewController *matchVC;
    PreferenceViewController *perferenVC;
}

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTitleButton];
    [self createViewControl];
}
- (void)createViewControl {
    matchVC = [[MatchContexViewController alloc]init];
    perferenVC = [[PreferenceViewController alloc]init];
    [self  addChildViewController:matchVC];
    [self  addChildViewController:perferenVC];
    [self.view addSubview:matchVC.view];
    
    
    
}
- (void)createTitleButton {
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, kMainBoundsW/2, 44);
    NSArray *arr = @[@"搭配",@"专题"];
    self.navigationItem.titleView = bgView;
    for (int i = 0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(kMainBoundsW/4*i, 0, kMainBoundsW/4, 40);
        button.tag = headerButtonTag+i;
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(MatchbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:button];
    }
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, kMainBoundsW/4, 3)];
    label.backgroundColor = [UIColor redColor];
    [bgView addSubview:label];
}
- (void)MatchbuttonClick:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        label.center = CGPointMake(kMainBoundsW/4*(sender.tag-headerButtonTag)+kMainBoundsW/8, 41);
    } completion:^(BOOL finished) {
        //切换视图 
        if (sender.tag-headerButtonTag == 0) {
            [self transitionFromViewController:perferenVC toViewController:matchVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                
            } completion:^(BOOL finished) {
                [self addChildViewController:matchVC];
                [self.view addSubview:matchVC.view];
            }];
        }else {
            [self transitionFromViewController:matchVC toViewController:perferenVC duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                
            } completion:^(BOOL finished) {
                [self addChildViewController:perferenVC];
                [self.view addSubview:perferenVC.view];
            }];
        }
        
    }];
    
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
