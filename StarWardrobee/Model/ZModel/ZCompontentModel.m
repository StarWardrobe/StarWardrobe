//
//  ZCompontentModel.m
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZCompontentModel.h"

@implementation ZCompontentModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self =[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"comments"]) {
        self.comments = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ZCommentsModel *model =[ZCommentsModel ZCommentsModelWithDic:dic];
            [_comments addObject:model];
        }
    }else if ([key isEqualToString:@"user"]) {
        self.user =[ZUserModel ZUserModelWithDictionary:value];
    }else if([key isEqualToString:@"pics"]) {
        self.pics = [NSMutableArray array];
        for (NSString *pic in value) {
            [self.pics addObject:pic];
        }
    }else if([key isEqualToString:@"users"]){
        _users =[NSMutableArray array];
        for (NSDictionary *dic in value) {
            NSString *headerImageName = dic[@"userAvatar"];
            [_users addObject:headerImageName];
        }
    }else{
        [super setValue:value forKey:key];
    }
}

+ (instancetype)ZCompontentModelWithDic:(NSDictionary *)dic {
    return [[self alloc]initWithDic:dic];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
@end
