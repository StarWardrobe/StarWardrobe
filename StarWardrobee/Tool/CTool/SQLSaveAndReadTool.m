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

static FMDatabase *__db;

@implementation SQLSaveAndReadTool

+ (void)createSQLSave {
    NSLog(@"%@",NSHomeDirectory());
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data.sqlite"];
    __db = [FMDatabase databaseWithPath:path];
    if ([__db open]) {
        NSString *creatTableSQL = @"create table if not exists student(id integer primary key autoincrement,name text not null,age integer default 22);";
        [__db executeUpdate:creatTableSQL];
    }
}
+ (void)createTableWithTableName:(NSString *)name AndArray:(NSMutableArray *)arr {
    
    
    
    
}
+ (NSMutableArray *)QuaryTAbleWithName:(NSString *)name {
   
    return 0;   
}

@end
