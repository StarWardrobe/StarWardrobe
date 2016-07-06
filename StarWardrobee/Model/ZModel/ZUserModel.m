//
//  ZUserModel.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZUserModel.h"

@implementation ZUserModel
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
+ (instancetype)ZUserModelWithDictionary:(NSDictionary *)dic {

    return [[self alloc]initWithDictionary:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}
@end
