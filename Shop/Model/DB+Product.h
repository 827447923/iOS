//
//  DB+Product.h
//  Shop
//
//  Created by 陈立豪 on 16/9/18.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB.h"
@class Product;

@interface DB (Product)
-(BOOL)AddProduct:(Product*)product;
-(BOOL)ModifyProduct:(Product*)product;
-(NSMutableArray*)QueryMoreProductsWithNumber:(NSInteger)num FirstLoad:(BOOL)firstLoad;
@end
