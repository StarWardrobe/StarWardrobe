//
//  PersonModel.h
//  StarWardrobee
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *time;
@property(copy,nonatomic)NSString *kind;
@property(copy,nonatomic)NSString *picUrl;
@property(assign,nonatomic)NSInteger messageCount;
@property(assign,nonatomic)NSInteger concernCount;
@property(assign,nonatomic)NSInteger seeCount;
@end
