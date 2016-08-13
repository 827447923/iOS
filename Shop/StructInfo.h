//
//  StructInfo.h
//  Shop
//
//  Created by 陈立豪 on 16/8/6.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import <Foundation/Foundation.h>


#ifndef StructInfo_h
#define StructInfo_h



@interface Product : NSObject{}
    @property (strong,nonatomic)NSString *m_Name;
    @property (strong,nonatomic)NSString *m_NO;
    @property (assign,nonatomic)float m_Number;
    @property (strong,nonatomic)NSString *m_Unit;
    @property (strong,nonatomic)NSString *m_Type;
    @property (assign,nonatomic)float m_PurchasePrice;
    @property (assign,nonatomic)float m_RetailPrice;
    @property (assign,nonatomic)float m_WholesalePrice;
    @property (strong,nonatomic)NSString *m_Description;
    @property (strong,nonatomic)NSString *m_ImagePath;


@end


#endif /* StructInfo_h */
