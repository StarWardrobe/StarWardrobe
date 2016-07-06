//
//  PreferenceViewController.m
//  StarWardrobee
//
//  Created by Mac on 16/7/3.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "PreferenceViewController.h"
#import "CHTTPAsk.h"
#import "PersonTableViewCell.h"

@interface PreferenceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)NSMutableArray *dataArray;

@end

@implementation PreferenceViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return  _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    [self createMyTableView];
}
- (void)createMyTableView {
    UITableView *myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kMainBoundsW, kMainBoundsH-64) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tag = 20;
    [self.view addSubview:myTableView];
    [myTableView registerClass:[PersonTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [CHTTPAsk netHTTPForSpecialTitleGetArray:^(NSMutableArray *arr) {
        [self.dataArray addObjectsFromArray:arr];
        [myTableView reloadData];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kMainBoundsH/2+10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PersonModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
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
