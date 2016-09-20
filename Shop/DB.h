//
//  DB.h
//  Shop
//
//  Created by 陈立豪 on 16/8/2.
//  Copyright © 2016年 陈立豪. All rights reserved.
//


#import <Foundation/Foundation.h>

@class FMDatabase,UIImage;
@interface DB : NSObject
@property(strong,nonatomic) FMDatabase *fmDB;

+(DB*)shareDB;
-(NSString*)dataFilePath:(NSString*)fileName;
-(BOOL)isTableExists:(NSString*)tableName;
-(BOOL)CreateProductTable:(int)id;
@end
