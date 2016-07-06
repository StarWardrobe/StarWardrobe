//
//  ZCompontentModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCommentsModel.h"
#import "ZUserModel.h"
@interface ZCompontentModel : NSObject
@property (copy, nonatomic)NSString *picUrl;
@property (copy, nonatomic)NSString *title;
@property (assign,nonatomic)NSInteger commentCount;
@property (strong, nonatomic)NSMutableArray *comments;
@property (copy, nonatomic)NSString *content;
@property (strong, nonatomic)NSMutableArray *pics;
@property (strong, nonatomic)NSMutableArray *tags;
@property (strong, nonatomic)ZUserModel *user;
@property (strong, nonatomic)NSMutableArray *users;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)ZCompontentModelWithDic:(NSDictionary *)dic;
@end
