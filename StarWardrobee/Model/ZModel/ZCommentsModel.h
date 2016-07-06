//
//  ZCommentsModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCommentsModel : NSObject
@property (copy, nonatomic)NSString *content;
@property (copy, nonatomic)NSString *username;
- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)ZCommentsModelWithDic:(NSDictionary *)dic;
@end
