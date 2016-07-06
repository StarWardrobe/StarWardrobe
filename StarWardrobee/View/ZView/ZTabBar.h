//
//  ZTabBar.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickBlock)(NSInteger index);
@interface ZTabBar : UIView
@property (strong, nonatomic)NSMutableArray *titles;

@property (copy, nonatomic)ButtonClickBlock clickBlock;

- (instancetype)initWithFrame:(CGRect)frame andTitles:(NSMutableArray *)titles withBlock:(ButtonClickBlock)myBlock;

@end
