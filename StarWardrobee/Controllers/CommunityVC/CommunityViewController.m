//
//  CommunityViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CommunityViewController.h"

//#import "ZHTTPManager.h"
#import "ZCompontentModel.h"


#import "CommuityTableViewCell.h"
#import "RefreshTool.h"
//#import "ZZCarouselControl.h"

#import "CHTTPAsk.h"


typedef enum : NSInteger {
    buttonTag=10,
}Tags;



@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{

    NSInteger selectIndex;
    
    UIScrollView *TopScrollView;
    UIScrollView *mainScrollView;
    UITableView *myTableView;
    UIView *ButtonView;
}
@property (strong, nonatomic)NSMutableArray *TopScrollArr;
@property (strong, nonatomic)NSMutableArray *dataArr;


@end

@implementation CommunityViewController

- (NSMutableArray *)TopScrollArr {
    if (!_TopScrollArr) {
        _TopScrollArr = [NSMutableArray array];
    }
    return _TopScrollArr;
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    self.title = @"社区";
    [self createMainScrollView];
    [self getData];
    
    
}
- (void)TransBack {
    static int a=0;
    a++;
    int b = a%self.TopScrollArr.count;
    [UIView animateWithDuration:0.8 animations:^{
       TopScrollView.contentOffset = CGPointMake(kMainBoundsW*b, 0); 
    } completion:nil];
}
- (void)createMainScrollView {
    mainScrollView = [[UIScrollView alloc]initWithFrame:kMainBounds];
    mainScrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    
    TopScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, kMainBoundsH*2/5-50)];
    [mainScrollView addSubview:TopScrollView];
    NSArray *arr = @[@"热门",@"关注",@"红人"];
    ButtonView = [[UIView alloc]initWithFrame:CGRectMake(0,  kMainBoundsH*2/5-50, kMainBoundsW, 50)];
    ButtonView.backgroundColor = [UIColor redColor];
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(5+(kMainBoundsW-10)/3*i, 0, (kMainBoundsW-10)/3, 50);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = buttonTag+i;
        [button addTarget:self action:@selector(ChooseKinds:) forControlEvents:UIControlEventTouchUpInside];
        [ButtonView addSubview:button];
    }
    [mainScrollView addSubview:ButtonView];
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kMainBoundsH*2/5, kMainBoundsW, kMainBoundsH-64) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.scrollEnabled = NO;
    
    [mainScrollView addSubview:myTableView];
    
  
    [myTableView registerClass:[CommuityTableViewCell class] forCellReuseIdentifier:@"cell"];
    
     
}
- (void)ChooseKinds:(UIButton *)sender {
    myTableView.contentOffset = CGPointMake(0, 0);
//    mainScrollView.contentOffset = CGPointMake(0, kMainBoundsH*2/5);
    
    selectIndex = sender.tag-buttonTag;
    [CHTTPAsk netHTTPForCommunityWithIndex:sender.tag-buttonTag GetBlock:^(NSMutableArray *arr) {
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:arr]; 
        
        mainScrollView.contentSize = CGSizeMake(0, kMainBoundsH*2/5+465*arr.count);
        [myTableView reloadData];
    }];
    
//    [myTableView.mj_header endRefreshing];

}
- (void)getData {
    [CHTTPAsk netHTTPForCommunityWithIndex:0 GetBlock:^(NSMutableArray *arr) {
        [self.dataArr removeAllObjects];
        [self.dataArr addObjectsFromArray:arr];  
        
        mainScrollView.contentSize = CGSizeMake(0, kMainBoundsH*2/5+465*arr.count);
        [myTableView reloadData];
        
    }];
        
    
    
    [CHTTPAsk netHTTPForHeaderCommunityWithBlock:^(NSMutableArray *arr) {
        [self.TopScrollArr addObjectsFromArray:arr];
        TopScrollView.contentSize = CGSizeMake(kMainBoundsW*arr.count, 0);
        TopScrollView.pagingEnabled = YES;
        for (int i = 0; i<arr.count; i++) {
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kMainBoundsW*i, 0, kMainBoundsW, TopScrollView.frame.size.height)];
            [image sd_setImageWithURL:[NSURL URLWithString:arr[i]]placeholderImage:[UIImage imageNamed:@"mascot_1"]];
            [TopScrollView addSubview:image];
        }
        
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(TransBack) userInfo:nil repeats:YES];  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (selectIndex == 0) {
        return 1;
    }else {
        return 2;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (selectIndex == 0) {
        return self.dataArr.count;
    }else {
        if (section == 0) {
            return 1;
        }else {
            return self.dataArr.count-1;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CommuityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell deleteAllSubviews];
    if (selectIndex == 0) {
        ZCompontentModel *model = self.dataArr[indexPath.row];
        cell.model = model;
    }else {
        NSArray *starArr = self.dataArr[0];
        if (indexPath.section == 0) {
            //小scroll
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, 365)];
            scrollView.pagingEnabled = YES;
            scrollView.contentSize = CGSizeMake(kMainBoundsW*starArr.count, 365);
            [cell.contentView addSubview:scrollView];
            
            for (int i=0; i<starArr.count; i++) {
                ZCompontentModel *model = starArr[i];
                UIImageView *imageView =[[UIImageView alloc]init];
                imageView.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*i, 100);
                imageView.bounds = CGRectMake(0, 0, 100, 100);
                imageView.layer.cornerRadius = 50;
                imageView.layer.masksToBounds = YES;
                [imageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]placeholderImage:[UIImage imageNamed:@"mascot_1"]];
                UILabel *label = [[UILabel alloc]init];
                label.center = CGPointMake(kMainBoundsW/2+kMainBoundsW*i, 200);
                label.bounds = CGRectMake(0, 0, 200, 30);
                label.text = model.title;
                label.textAlignment = NSTextAlignmentCenter;
                [scrollView addSubview:imageView];
                [scrollView addSubview:label];
            }

        }else {
            ZCompontentModel *model = self.dataArr[indexPath.row+1];
            cell.model = model; 
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 465;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
        //滑动
        if (mainScrollView.contentOffset.y<kMainBoundsH*2/5-114) {
            ButtonView.frame = CGRectMake(0, kMainBoundsH*2/5-50, kMainBoundsW, 50);
            myTableView.frame =CGRectMake(0, kMainBoundsH*2/5, kMainBoundsW, kMainBoundsH-64);
            myTableView.contentOffset = CGPointMake(0, 0);
        }else {
            myTableView.center =CGPointMake(self.view.center.x, kMainBoundsH*2/5+144+mainScrollView.contentOffset.y);
            ButtonView.center = CGPointMake(ButtonView.center.x, mainScrollView.contentOffset.y+kMainBoundsH*2/5-185); 
            myTableView.contentOffset =CGPointMake(0, mainScrollView.contentOffset.y-kMainBoundsH*2/5+114);
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
