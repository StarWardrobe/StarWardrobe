//
//  ZHTTPManager.m
//  StarWardrobee
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "ZHTTPManager.h"

@implementation ZHTTPManager
+ (void)getRequestWithUrl:(NSString *)url andPragramer:(NSDictionary *)dic withResposeBlock:(ITFinishedBlock)block {
   AFHTTPRequestOperationManager *manager =[self createAFHttpManger];
    [manager GET:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        block(responseObject,nil);
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        block(nil,error);
    }];



}
+ (void)postRequestWithUrl:(NSString *)url andPragramer:(NSDictionary *)dic withResposeBlock:(ITFinishedBlock)block {
    
    AFHTTPRequestOperationManager *manager =[self createAFHttpManger];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        if (block) {
             block(responseObject,nil);
        }       
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];

}
+ (AFHTTPRequestOperationManager *)createAFHttpManger {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/plain", nil];
    return manager;
}
@end
