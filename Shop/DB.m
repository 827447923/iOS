//
//  DB.m
//  Shop
//
//  Created by 陈立豪 on 16/8/2.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB.h"
#import <sqlite3.h>
#import "StructInfo.h"

extern int global_user_id;


@interface DB()

@property(assign,nonatomic) sqlite3 *database;

@end

@implementation DB

- (instancetype)init
{
    self = [super init];
    if (self) {
        if(sqlite3_open([[self dataFilePath]UTF8String],&_database)!=SQLITE_OK){
            sqlite3_close(_database);
            NSAssert(0,@"Failed to open database");
        }
        
        NSString *createSQL = @"CREATE  TABLE  IF NOT EXISTS UserInfo (id INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE ,  account  VARCHAR NOT NULL  UNIQUE ,  password  VARCHAR);";
        char *errorMsg;
        if(sqlite3_exec(_database,[createSQL UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK){
            sqlite3_close(_database);
            NSAssert(0,@"Error creating table:%s",errorMsg);
        }
    }
    return self;
}


//析构函数中关闭数据库
-(void)dealloc{
    sqlite3_close(_database);
}

//数据库路径
-(NSString*)dataFilePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Shop.sqlite"];
}

//判断表是否存在
-(BOOL)isTableExists:(NSString*)tableName
{
    sqlite3_stmt *statement;
    NSString *query = [NSString stringWithFormat:@"select name from Shop where type = 'table' and name = '%@",tableName];
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        int result = sqlite3_step(statement);
        sqlite3_finalize(statement);
        if(result == SQLITE_ROW){
            return YES;
        }else{
        return NO;
        }
    }else{
        sqlite3_close(_database);
        return NO;
    }
}

//创建商品表
-(BOOL)CreateProductTable:(int)id
{
    NSString *sql = [NSString stringWithFormat: @"CREATE  TABLE  IF NOT EXISTS 'Product_%d' ('id' INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , 'name' VARCHAR NOT NULL  UNIQUE , 'NO' VARCHAR UNIQUE , 'number' FLOAT DEFAULT 0, 'unit' VARCHAR DEFAULT '斤', 'purchasePrice' FLOAT DEFAULT 0, 'retailPrice' FLOAT DEFAULT 0, 'wholesalePrice' FLOAT DEFAULT 0, 'typeOfProduct' VARCHAR, 'description' VARCHAR, 'image' VARCHAR);",id];
    char *error;
    if(sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &error) == SQLITE_OK){
        return YES;
    }else{
        return NO;
    }
}

//登录查询
-(BOOL)LoginWithAccount:(NSString*) account Password:(NSString*)psw{
    char *query = "SELECT id FROM UserInfo WHERE account = ? AND password = ?;";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database,query,-1,&statement,nil)==SQLITE_OK){
        sqlite3_bind_text(statement,1,[account UTF8String],-1,NULL);
        sqlite3_bind_text(statement,2,[psw UTF8String],-1,NULL);
    }
    if (sqlite3_step(statement)==SQLITE_ROW) {
        global_user_id = (int)sqlite3_column_int(statement,0);
        sqlite3_finalize(statement);
        return YES;
    }
    sqlite3_finalize(statement);
    return NO;
}


//注册
-(BOOL)registerWithAccount:(NSString*)account Password:(NSString*)psw{
    char *query = "insert into UserInfo (account,password) values (?,?);";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database, query, -1, &statement, nil)==SQLITE_OK){
        sqlite3_bind_text(statement, 1, [account UTF8String],-1,NULL);
        sqlite3_bind_text(statement, 2, [psw UTF8String], -1, NULL);
    }
    if(sqlite3_step(statement)!=SQLITE_DONE){
        sqlite3_finalize(statement);
        return NO;
    }
    else{
        sqlite3_finalize(statement);
        return YES;
    }
}

//添加商品
-(BOOL)AddProduct:(Product*)product{
    //先判断Product表是否存在，不存在则创建，创建失败返回NO
    NSString *productTableName = [NSString stringWithFormat:@"Product_%d",global_user_id];
    if([self isTableExists:productTableName] == NO){
        if([self CreateProductTable:global_user_id] == NO){
            return NO;
        }
    }
    NSString *sql = [NSString stringWithFormat:@"insert into Product_%d (name,NO,number,unit,purchasePrice,retailPrice,wholesalePrice,typeOfProduct,description,image)"
                     "values (%s,%s,%.2f,%s,%.2f,%.2f,%.2f,%s,%s,%s)",
                     global_user_id,
                     [product.m_Name UTF8String],
                     [product.m_NO UTF8String],
                     product.m_Number,
                     [product.m_Unit UTF8String],
                     product.m_PurchasePrice,
                     product.m_RetailPrice,
                     product.m_WholesalePrice,
                     [product.m_Type UTF8String],
                     [product.m_Description UTF8String],
                     [product.m_ImagePath UTF8String]];
    char *errorMsg;
    if(sqlite3_exec(_database, [sql UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK){
        sqlite3_close(_database);
        NSAssert(0,@"Error creating table:%s",errorMsg);
    }
    
    return YES;
}





















@end
