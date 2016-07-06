//
//  ZHTTPManager.h
//  StarWardrobee
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHTTPManager : NSObject

+ (void)getRequestWithUrl:(NSString *)url andPragramer:(NSDictionary *)dic withResposeBlock:(ITFinishedBlock)block;
+ (void)postRequestWithUrl:(NSString *)url andPragramer:(NSDictionary *)dic withResposeBlock:(ITFinishedBlock)block;
@end
