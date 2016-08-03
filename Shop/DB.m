//
//  DB.m
//  Shop
//
//  Created by 陈立豪 on 16/8/2.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB.h"
#import <sqlite3.h>

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
    return [documentsDirectory stringByAppendingString:@"Shop.sqlite"];
}

//登录查询
-(BOOL)LoginWithAccount:(NSString*) account Password:(NSString*)psw{
    char *query = "SELECT * FROM UserInfo WHERE account = ? AND password = ?;";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(_database,query,-1,&statement,nil)==SQLITE_OK){
        sqlite3_bind_text(statement,1,[account UTF8String],-1,NULL);
        sqlite3_bind_text(statement,2,[psw UTF8String],-1,NULL);
    }
    if (sqlite3_step(statement)==SQLITE_ROW) {
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

@end
