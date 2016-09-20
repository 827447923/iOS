//
//  DB.m
//  Shop
//
//  Created by 陈立豪 on 16/8/2.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB.h"
#import "FMDatabase.h"
#import "StructInfo.h"
#import "User.h"

@interface DB()
//@property(strong,nonatomic) FMDatabase *fmDB;

@end

@implementation DB



- (instancetype)init
{
    self = [super init];
    if (self) {
        _fmDB = [FMDatabase databaseWithPath:[self dataFilePath:@"Shop.sqlite"]];
        if(![_fmDB open]){
            _fmDB = nil;
            NSAssert(0,@"Failed to open database");
        }
        
        //create User table
        NSString *createSQL = @"CREATE  TABLE  IF NOT EXISTS UserInfo (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ,  account  VARCHAR NOT NULL  UNIQUE ,  password  VARCHAR);";
        if(![_fmDB executeUpdate:createSQL]){
            NSAssert(0,@"Error creating table");
        }
        //create Product table
        NSString *productTableName = [NSString stringWithFormat:@"Product_%d",[User shareUser].id];
        if([self isTableExists:productTableName] == NO){
            if([self CreateProductTable:[User shareUser].id] == NO){
                NSAssert(0,@"Failed to create Product table");
            }
        }
    }
    return self;
}


//析构函数中关闭数据库
-(void)dealloc{
    [_fmDB close];
    _fmDB = nil;
}

+(DB*)shareDB{
    static DB* db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        db = [[DB alloc]init];
        
    });
    return db;
}
//数据库路径
-(NSString*)dataFilePath:(NSString*)fileName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

//判断表是否存在
-(BOOL)isTableExists:(NSString*)tableName
{
    NSString *query = [NSString stringWithFormat:@"select name from Shop where type = 'table' and name = '%@",tableName];
    FMResultSet *resultSet = [_fmDB executeQuery:query];
    if ([resultSet next]) {
        return YES;
    }else{
        return NO;
    }
}

//创建商品表
-(BOOL)CreateProductTable:(int)id
{
    NSString *sql = [NSString stringWithFormat: @"CREATE  TABLE  IF NOT EXISTS 'Product_%d' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' VARCHAR NOT NULL  UNIQUE , 'NO' VARCHAR UNIQUE , 'number' FLOAT DEFAULT 0, 'unit' VARCHAR DEFAULT '斤', 'purchasePrice' FLOAT DEFAULT 0, 'retailPrice' FLOAT DEFAULT 0, 'wholesalePrice' FLOAT DEFAULT 0, 'typeOfProduct' VARCHAR, 'description' VARCHAR, 'image' VARCHAR);",id];
    if([_fmDB executeUpdate:sql]){
        return YES;
    }else{
        return NO;
    }
}

























@end
