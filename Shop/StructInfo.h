//
//  Product.h
//  Shop
//
//  Created by 陈立豪 on 16/8/6.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject{
    NSString *m_Name;
    NSString *m_NO;
    float m_Number;
    NSString *m_Unit;
    NSString *m_Type;
    float m_PurchasePrice;
    float m_RetailPrice;
    float m_WholesalePrice;
    NSString *m_Description;
    NSString *m_ImagePath;
}

@end
