//
//  DB+Product.m
//  Shop
//
//  Created by 陈立豪 on 16/9/18.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB+Product.h"
#import "User.h"
#import "StructInfo.h"
#import "FMDatabase.h"


static NSInteger loadedProductNum = 0;

@implementation DB (Product)


//添加商品
-(BOOL)AddProduct:(Product*)product{
    //先判断Product表是否存在，不存在则创建，创建失败返回NO
    NSString *productTableName = [NSString stringWithFormat:@"Product_%d",[User shareUser].id];
    if([self isTableExists:productTableName] == NO){
        if([self CreateProductTable:[User shareUser].id] == NO){
            return NO;
        }
    }

    NSString *sql = [NSString stringWithFormat:@"insert into Product_%d (name,NO,number,unit,purchasePrice,retailPrice,wholesalePrice,typeOfProduct,description,image)"
                     "values ('%s','%s',%.2f,'%s',%.2f,%.2f,%.2f,'%s','%s','%s')",
                     [User shareUser].id,
                     [product.m_Name UTF8String],
                     [product.m_NO UTF8String],
                     product.m_Number,
                     [product.m_Unit UTF8String],
                     product.m_PurchasePrice,
                     product.m_RetailPrice,
                     product.m_WholesalePrice,
                     [product.m_Type UTF8String],
                     [product.m_Description UTF8String],
                     [product.m_ImagePath  UTF8String]];
    
    if(![self.fmDB executeUpdate:sql]){
        NSAssert(0,@"Error add product");
        return NO;
    }
    
    return YES;
}

//修改商品
-(BOOL)ModifyProduct:(Product*)product{
    NSString *sql = [NSString stringWithFormat:@"update Product_%d set name = %s,NO=%s,number=%.2f,unit=%s,purchasePrice=%.2f,retailPrice=%.2f,wholesalePrice=%.2f,typeOfProduct=%s,description=%s,image=%s",
                     [User shareUser].id,
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
    if(![self.fmDB executeQuery:sql]){
        NSAssert(0,@"Error updating product table");
        return NO;
    }
    
    
    return  YES;
}

//从数据库读取固定数量的Product
-(NSMutableArray*)QueryMoreProductsWithNumber:(NSInteger)num FirstLoad:(BOOL)firstLoad{
    if(firstLoad){
        loadedProductNum = 0;
    }
    NSMutableArray *products = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"select *from Product_%d  where id not in( select id  from Product_%d order by id limit 0,%ld) limit 0,%ld",[User shareUser].id,[User shareUser].id,loadedProductNum,num];
    
    FMResultSet *resultSet = [self.fmDB executeQuery:query];
    while ([resultSet next]) {
        Product *product = [[Product alloc]init];
        product.id = [resultSet intForColumn:@"id"];
        product.m_Name = [resultSet stringForColumn:@"name"];
        product.m_NO = [resultSet stringForColumn:@"NO"];
        product.m_Number = [resultSet doubleForColumn:@"number"];
        product.m_Unit = [resultSet stringForColumn:@"unit"];
        product.m_Type = [resultSet stringForColumn:@"typeOfProduct"];
        product.m_PurchasePrice = [resultSet doubleForColumn:@"purchasePrice"];
        product.m_RetailPrice = [resultSet doubleForColumn:@"retailPrice"];
        product.m_WholesalePrice = [resultSet doubleForColumn:@"wholesalePrice"];
        product.m_Description = [resultSet stringForColumn:@"description"];
        product.m_ImagePath = [resultSet stringForColumn:@"image"];
        [products addObject:product];
    }
    return products;
}

    




@end
