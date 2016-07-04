//
//  CHTTPAsk.h
//  StarWardrobee
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHTTPAsk : NSObject

+ (void)netHTTPForMainTopScrollArray:(void(^)(NSArray *arr))block;

+ (void)netHttpForMAINTimeLimted:(void(^)(NSArray *arr))block;

+ (void)netHTTPForMainInternationWithUrl:(NSString *)urlStr :(void(^)(NSMutableArray *arr))block;
+ (NSArray *)GetUrl;

+ (void)netHTTPForFootTableViewWithChoose:(NSInteger)number FallBackArr:(void(^)(NSMutableArray *arr))block;

@end
