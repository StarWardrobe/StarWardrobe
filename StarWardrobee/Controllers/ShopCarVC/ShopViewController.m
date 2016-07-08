//
//  ShopViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopTableViewCell.h"
#import "LoginViewController.h"
static NSString *cellID = @"cell";
@interface ShopViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self presentViewController:[LoginViewController new] animated:YES completion:nil];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    [self createTopView];
    
    [self createTableView];
    
    [self createBottomView];
    
}
#pragma mark - 创建topView
- (void)createTopView {
    self.title = @"购物车";
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(EditeButtonClick:)];
    
    
}
- (void)createTableView {
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMainBoundsW, kMainBoundsH) style:UITableViewStylePlain];
    myTableView.delegate =self;
    myTableView.dataSource =self;
    [self.view addSubview:myTableView];
    
    [myTableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}
#pragma mark - 创建底面的View
- (void)createBottomView {
    
    UIView *bgView =[[UIView alloc]initWithFrame:CGRectMake(0, kMainBoundsH-CGRectGetMinY(self.tabBarController.view.frame), kMainBoundsW, 50)];
    bgView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    allBtn.frame =CGRectMake(10, 10, 30, 30);
    [allBtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
    [bgView addSubview:allBtn];
    
    UILabel *allLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 40, 30)];
    allLabel.text = @"全选";
    [bgView addSubview:allLabel];
    
    UIButton *acountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    acountBtn.frame = CGRectMake(kMainBoundsW-100, 0, 100, 50);
    acountBtn.backgroundColor =[UIColor purpleColor];
    [acountBtn setTitle:@"结算" forState:UIControlStateNormal];
    [acountBtn addTarget:self action:@selector(PayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:acountBtn];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(acountBtn.frame)-100, 0, 100, 30)];
    priceLabel.text = @"￥0.0";
    priceLabel.textColor = [UIColor magentaColor];
    [bgView addSubview:priceLabel];
    
    UILabel *allPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(priceLabel.frame)-50, 0, 50, 30)];
    allPriceLabel.text =@"总价";
    [bgView addSubview:allPriceLabel];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    [cell.circleBtn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView =[UIView new];
    bgView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:bgView];
    
    //    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, kMainBoundsW, 30)];
    //    [bgView addSubview:lable];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(20, 5, 30, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"icon_my_edit_sex_option@2x"] forState:UIControlStateNormal];
    [bgView addSubview:btn];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 5, kMainBoundsW-50, 30)];
    nameLabel.text = @"这是店名";
    [bgView addSubview:nameLabel];
    
    return bgView;
    
    
}
#pragma mark - button点击事件
- (void)EditeButtonClick:(UIButton *)sender {
    
}
- (void)PayButtonClick:(UIButton *)sender {
    
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
