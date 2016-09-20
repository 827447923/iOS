//
//  DB+Login.m
//  Shop
//
//  Created by 陈立豪 on 16/9/13.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB+Login.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "User.h"
@implementation DB (Login)

//登录查询
-(BOOL)LoginWithAccount:(NSString*) account Password:(NSString*)psw{
    NSString *query = @"SELECT id,account FROM UserInfo WHERE account = ? AND password = ?;";
    FMResultSet *reslut = [self.fmDB executeQuery:query,account,psw];
    if ([reslut next]) {
        [User shareUser].id  = [reslut intForColumn:@"id"];
        [User shareUser].name = [reslut stringForColumn:@"account"];
        [[NSUserDefaults standardUserDefaults]setValue:account forKey:@"account"];
        
        //create folder
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDir = [paths objectAtIndex:0];
        NSString *privateFolder = [documentDir stringByAppendingPathComponent:[User shareUser].name];
        if (![[NSFileManager defaultManager]fileExistsAtPath:privateFolder]) {
            [[NSFileManager defaultManager]createDirectoryAtPath:privateFolder withIntermediateDirectories:YES attributes:nil error:nil];
        }
        return YES;
    }
    return NO;
}


//注册
-(BOOL)registerWithAccount:(NSString*)account Password:(NSString*)psw{
    NSString *query = @"insert into UserInfo (account,password) values (?,?);";
    FMResultSet *result = [self.fmDB executeQuery:query,account,psw];
    if([result next]){
        return NO;
    }
    else{
        return YES;
    }
}


@end
