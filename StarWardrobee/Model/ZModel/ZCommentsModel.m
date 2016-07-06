//
//  ZCommentsModel.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZCommentsModel.h"

@implementation ZCommentsModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)ZCommentsModelWithDic:(NSDictionary *)dic {
    return [[ZCommentsModel alloc]initWithDic:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
