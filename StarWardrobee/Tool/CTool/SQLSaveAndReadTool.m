//
//  SQLSaveAndReadTool.m
//  StarWardrobee
//
//  Created by Mac on 16/7/6.
//  Copyright © 2016年 Happy. All rights reserved.
//

#import "SQLSaveAndReadTool.h"
#import "FMDatabase.h"
#import "FMResultSet.h"

#import "CMainHeaderModel.h"
#import "CMainInternationModel.h"
#import "CMainWaterFallModel.h"
#import "CMatchCellModel.h"
#import "PersonModel.h"

static FMDatabase *__db;

@implementation SQLSaveAndReadTool

+ (void)createSQLSave {
    NSLog(@"%@",NSHomeDirectory());
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
    __db = [FMDatabase databaseWithPath:path];
    if ([__db open]) {
        NSString *creatTableSQL = @"create table if not exists mainTop(id integer primary key autoincrement,picUrl text not null,cellHeight integer,oldPrice integer,newPrice integer,title text,countryName text,countryPicUrl text,itemsCount integer,collectionCount integer,time text,kind text,messageCount integer,idTag integer not null);";
        [__db executeUpdate:creatTableSQL];
    }
}
+ (void)createTableWithTableName:(NSString *)name WithIDTag:(NSInteger)number AndArray:(NSMutableArray *)arr {
    if ([__db open]) {
        switch (number) {
            case 0:
            {
                for (int i = 0;i<arr.count;i++) {
                    CMainHeaderModel *model = [CMainHeaderModel new];
                    [__db executeUpdate:[NSString stringWithFormat:@"insert into mainTop (picUrl,idTag) values ('%@',%ld)",model.picUrl,number]];
                }

            }
                break;
            case 1: 
            {
                
            }
                break;    
            case 2: 
            {
                
            }
                break;
               
                
            default:
                break;
        }
    }
}
+ (NSMutableArray *)QuaryTAbleWithName:(NSString *)name WithIDTag:(NSInteger)number {
    NSMutableArray *arr = [NSMutableArray array];
    if ([__db open]) {
        FMResultSet *set = [__db executeQuery:[NSString stringWithFormat:@"select * form mainTop where idTag = %ld order by id",number]];
        switch (number) {
            case 0:
            {
                if ([set next]) {
                    CMainHeaderModel *model = [CMainHeaderModel new];
                    model.picUrl = [set stringForColumn:@"picUrl"];
                    [arr addObject:model];
                }
            }
                break;
            case 1:   
            {
                
            }
                break;
            case 2:   
            {
                
            }
                break;     
            case 3:   
            {
                
            }
                break;    
                
                
                
                
            default:
                break;
        }
           }
    return arr;   
}

@end
