//
//  User.h
//  Shop
//
//  Created by 陈立豪 on 16/9/13.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (assign,nonatomic) int id;
@property (copy,nonatomic) NSString *name;

+(User*)shareUser;
@end
