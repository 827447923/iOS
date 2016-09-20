//
//  ProductSumaryTableCell.m
//  Shop
//
//  Created by 陈立豪 on 16/9/19.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "ProductSumaryTableCell.h"

@interface ProductSumaryTableCell ()


@end


@implementation ProductSumaryTableCell
//-(instancetype)init{
//    self = [super init];
//    [self configureCell];
//    return self;
//}
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    [self configureCell];
//    return self;
//}

-(void)configureCell{
    _nameLabel = [self viewWithTag:1];
    _typeLabel = [self viewWithTag:2];
    _numberLabel = [self viewWithTag:3];
    _retailPriceLabel = [self viewWithTag:4];
    _purchasePriceLabel = [self viewWithTag:5];
    _productImageView = [self viewWithTag:6];
}
@end
