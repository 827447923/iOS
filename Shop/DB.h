//
//  DB.h
//  Shop
//
//  Created by 陈立豪 on 16/8/2.
//  Copyright © 2016年 陈立豪. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DB : NSObject
-(BOOL)LoginWithAccount:(NSString*) account Password:(NSString*)psw;
-(BOOL)registerWithAccount:(NSString*)account Password:(NSString*)psw;
@end
