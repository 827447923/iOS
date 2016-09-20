//
//  ProductSumaryTableCell.h
//  Shop
//
//  Created by 陈立豪 on 16/9/19.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSumaryTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *retailPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchasePriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
