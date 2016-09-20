//
//  User.m
//  Shop
//
//  Created by 陈立豪 on 16/9/13.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "User.h"


@implementation User


+(User*)shareUser{
    static User* user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc]init];
    });
    return user;
}

@end
