//
//  CHTTPAsk.m
//  StarWardrobee
//
//  Created by Mac on 16/7/2.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "CHTTPAsk.h"
#import "CMainHeaderModel.h"
#import "CMainWaterFallModel.h"
#import "CMatchCellModel.h"
#import "PersonModel.h"
#import "ZCompontentModel.h"

@implementation CHTTPAsk
+ (void)netHTTPForMainTopScrollArray:(void(^)(NSArray *arr))block {
    NSMutableArray *arr = [NSMutableArray array];
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/mall/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        for (NSDictionary *tempDic in itemsArr) {
            NSDictionary *comDic = tempDic[@"component"];
            CMainHeaderModel *model = [CMainHeaderModel new];
            model.picUrl = comDic[@"picUrl"];
            model.height = [comDic[@"height"] integerValue];
            model.width = [comDic[@"width"]integerValue];
            [arr addObject:model];
        }
        if (block) {
            block(arr);
        }
    }];
}
+ (void)netHttpForMAINTimeLimted:(void(^)(NSArray *arr))block {
    NSMutableArray *arr = [NSMutableArray array];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", nil];
    [manager POST:@"http://api-v2.mall.hichao.com/active/flash/list?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token="  parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *responseDic = dic[@"response"];
        NSDictionary *dataDic = responseDic[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        for (NSDictionary *tempDic in itemsArr) {
            NSDictionary *comDic = tempDic[@"component"];
            NSString *imgPicUrl = comDic[@"img_index"];
            [arr addObject:imgPicUrl];
        }
        if (block) {
            block(arr);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (block) {
            block(nil);
        }
    }];
    
}
+ (NSArray *)GetUrl {
    NSMutableArray *urlDataArray = [NSMutableArray array];
    for (int i = 1; i<7; i++) {
        NSString *str = [NSString stringWithFormat:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=%d&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=",i];
        [urlDataArray addObject:str];
    }
    return urlDataArray;
}
+ (void)netHTTPForMainInternationWithUrl:(NSString *)urlStr :(void(^)(NSMutableArray *arr))block {
    
        NSMutableArray *cellArray = [NSMutableArray array];
        [NetRequestClass netRequestGETWithRequestURL:urlStr WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
            NSDictionary *dataDic = responseObject[@"data"];
            
            NSArray *headerStrArr = dataDic[@"region_name"];
            NSString *headerStr = [[NSString alloc]init];
            for (NSDictionary *tempDic in headerStrArr) {
                NSDictionary *comDic = tempDic[@"component"];
                headerStr = comDic[@"picUrl"];
            
            }
            
            
            NSArray *ADArr = dataDic[@"region_brands"];
            NSMutableArray *ADDataArr = [NSMutableArray array];
            for (NSDictionary *tempDic in ADArr) {
                NSDictionary *comDic = tempDic[@"component"];
                NSString *ADStr = comDic[@"picUrl"];
                [ADDataArr addObject:ADStr];
            }
            
            
            NSArray *regionArr = dataDic[@"region_pictures"];
            NSMutableArray *contenArr = [NSMutableArray array];
            for (NSDictionary *tempDic in regionArr) {
                NSDictionary *comDic = tempDic[@"component"];
                NSString *ConStr = comDic[@"picUrl"];
                [contenArr addObject:ConStr];
            }
            
            NSArray *skusArr = dataDic[@"region_skus"];
            NSMutableArray *footerArr = [NSMutableArray array];
            for (NSDictionary *tempDic in skusArr) {
                NSDictionary *comDic = tempDic[@"component"];
                CMainInternationModel *model = [CMainInternationModel new];
                model.picUrl = comDic[@"picUrl"];
                model.OldPrice = [comDic[@"origin_price"] integerValue];
                model.newPrice = [comDic[@"price"]integerValue];
                model.title = comDic[@"title"];
                [footerArr addObject:model];
            }
            [cellArray addObject:headerStr];
            [cellArray addObject:ADDataArr];
            [cellArray addObject:contenArr];
            [cellArray addObject:footerArr];
            
            if (block) {
                block(cellArray);
            }
        }];
}

+ (void)netHTTPForFootTableViewWithChoose:(NSInteger)number FallBackArr:(void(^)(NSMutableArray *arr))block {
    NSArray *urlStr = @[@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=38,33,34&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=6t8NoQYMw_NMtAl6aAtqVFwHEiV1Ve_1ENnI7aOs3KQ",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=39,40&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=6t8NoQYMw_NMtAl6aAtqVFwHEiV1Ve_1ENnI7aOs3KQ",@"http://api-v2.mall.hichao.com/sku/list?more_items=1&type=selection&flag=&category_ids=49,45,48,46,44&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=6t8NoQYMw_NMtAl6aAtqVFwHEiV1Ve_1ENnI7aOs3KQ"];
    NSMutableArray *array = [NSMutableArray array];
    
    [NetRequestClass netRequestGETWithRequestURL:urlStr[number] WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemsArray = dataDic[@"items"];
        for (NSDictionary *tempDic in itemsArray) {
            CMainWaterFallModel *model = [CMainWaterFallModel new];
            model.height = [tempDic[@"height"] integerValue];
            model.width = [tempDic[@"width"] integerValue];
            NSDictionary *comDic = tempDic[@"component"];
            NSString *str = comDic[@"picUrl"];
            NSArray *StrAr = [str componentsSeparatedByString:@"?"];
            NSString *fistHttpStr = [NSString stringWithFormat:@"%@?",StrAr[0]];

            model.picUrl = fistHttpStr;
            
            model.countryName = comDic[@"country"];
            model.countryPicUrl = comDic[@"nationalFlag"];
            model.OldPrice = [comDic[@"origin_price"] integerValue];
            model.NewPrice = [comDic[@"price"] integerValue];
            model.title = comDic[@"description"];
            [array addObject:model];
        }
        if (block) {
            block(array);
        }
    }];
}

+ (void)netHTTPForMatchScrollViewCellWith:(NSString *)str GetArray:(void(^)(NSMutableArray *arr))block {
    NSMutableArray *array = [NSMutableArray array];
//    NSString *EcodeStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *EcodeStr = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSString *UrlStr =[NSString stringWithFormat:@"http://api-v2.mall.hichao.com/star/list?category=%@&lts=&pin=&flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=",EcodeStr];
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    manage.responseSerializer = [AFHTTPResponseSerializer serializer];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manage GET:UrlStr parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dataDic = dic[@"data"];
        NSArray *itemsArray = dataDic[@"items"];
        for (NSDictionary *tempDic in itemsArray) {
            
            CMatchCellModel *model = [CMatchCellModel new];
            
            model.width = [tempDic[@"width"] integerValue];
            model.height = [tempDic[@"height"] integerValue];
            NSDictionary *comDic = tempDic[@"component"];
            NSString *str = comDic[@"picUrl"];
            NSArray *StrAr = [str componentsSeparatedByString:@"?"];
            NSString *fistHttpStr = [NSString stringWithFormat:@"%@?",StrAr[0]];
            model.PicUrl = fistHttpStr;
            model.Description = comDic[@"description"];
            model.itemsCount = [comDic[@"itemsCount"] intValue];
            model.collectionCount = [comDic[@"collectionCount"] intValue];
            [array addObject:model];
            
        }
        if (block) {
            block(array);
        }

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (block) {
            block(nil);
        }
    }];

}

+ (void)netHTTPForSpecialTitleGetArray:(void(^)(NSMutableArray *arr))block {
    NSMutableArray *array = [NSMutableArray array];
    
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/mix_topics?flag=&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemsArray = dataDic[@"items"];
        
        
        for (NSDictionary *Dic in itemsArray) {
            
            PersonModel *model = [PersonModel new];
            NSDictionary *tempDic = Dic[@"component"];
    
            model.title = tempDic[@"title"];
            model.kind = tempDic[@"category"];
            NSString *day = tempDic[@"day"];
            NSString *month = tempDic[@"month"];
            NSString *year = tempDic[@"year"];
            NSString *timeSend = [NSString stringWithFormat:@"%@.%@.%@",year,month,day];
            model.time = timeSend;
            
            NSString *str = tempDic[@"picUrl"];
            NSArray *StrAr = [str componentsSeparatedByString:@"?"];
            NSString *fistHttpStr = [NSString stringWithFormat:@"%@?",StrAr[0]];
            model.picUrl = fistHttpStr;
            
            model.messageCount = [tempDic[@"commentCount"] integerValue];
            model.seeCount = [tempDic[@"v"] integerValue];
            model.concernCount = [tempDic[@"collectionCount"] integerValue];
            [array addObject:model];
        }
        if (block) {
            block(array);
        }    
    }];
}

+ (void)netHttpForGuidePictureWithBlock:(void(^)(NSMutableArray *arr))block {
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/mall/region/new?region_id=1&gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
        
        NSLog(@"????????%@",responseObject);
    }];
}
+ (void)netHTTPForCommunityWithIndex:(NSInteger)number GetBlock:(void(^)(NSMutableArray *arr))block {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *nameArr = @[@"热门",@"关注",@"红人"];
    NSArray *idArr = @[@"5",@"6",@"2"];
    
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/forum/timeline?" WithParameter:@{@"nav_id":idArr[number],@"nav_name":nameArr[number],@"flag=":@"",@"user_id":@"",@"gc":@"appstore",@"gf":@"iphone",@"gn":@"mxyc_ip",@"gv":@"6.6",@"gi":@"DA51E858-FC0D-4ACA-94C8-EC43CA9AC969",@"gs":@"640x1136",@"gos":@"8.4",@"access_token":@""} WithReturnValeuBlock:^(id responseObject, NSError *error) {
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemsArr = dataDic[@"items"];
        if (number == 0) {
            for (NSDictionary *temp in itemsArr) {
                NSDictionary *comDic =temp[@"component"];
                ZCompontentModel *model =[ZCompontentModel ZCompontentModelWithDic:comDic];
                [array addObject:model];
            }
        }else {
            for (int i=0; i<itemsArr.count; i++) {
                if (0==i) {
                    NSDictionary *temp = itemsArr[0][@"component"];
                    NSArray *foucusArr = temp[@"focus_users"];
                    NSMutableArray *starArr = [NSMutableArray array];
                    for (NSDictionary *t in foucusArr) {
                        NSDictionary *commDic = t[@"component"];
                        ZCompontentModel *model =  [ZCompontentModel ZCompontentModelWithDic:commDic];
                        [starArr addObject:model];
                    }
                    [array addObject:starArr];
                }else {
                    NSDictionary *bigDic = itemsArr[i][@"component"];
                    ZCompontentModel *BigModel =[ZCompontentModel ZCompontentModelWithDic:bigDic];
                    [array addObject:BigModel];
                }
            }
        }
        if (block) {
            block(array);
        }
    }];
}

+ (void)netHTTPForHeaderCommunityWithBlock:(void(^)(NSMutableArray *arr))block {
    NSMutableArray *array = [NSMutableArray array];
    [NetRequestClass netRequestGETWithRequestURL:@"http://api-v2.mall.hichao.com/forum/banner?gc=appstore&gf=iphone&gn=mxyc_ip&gv=6.6.3&gi=DA51E858-FC0D-4ACA-94C8-EC43CA9AC969&gs=640x1136&gos=8.4&access_token=" WithParameter:nil WithReturnValeuBlock:^(id responseObject, NSError *error) {
        
        NSDictionary *dataDic = responseObject[@"data"];
        NSArray *itemArr = dataDic[@"items"];
        for (NSDictionary *temp in itemArr) {
            NSDictionary *commpontDic =temp[@"component"];
            NSString *picUrl = commpontDic[@"picUrl"];
            [array addObject:picUrl];
        }
        if (block) {
            block(array);
        }
    }];
}



@end
