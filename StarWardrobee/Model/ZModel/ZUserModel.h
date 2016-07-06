//
//  ZUserModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/4.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZUserModel : NSObject

@property (copy, nonatomic)NSString *datatime;
@property (copy, nonatomic)NSString *userAvatar;
@property (copy, nonatomic)NSString *username;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)ZUserModelWithDictionary:(NSDictionary *)dic;
@end
