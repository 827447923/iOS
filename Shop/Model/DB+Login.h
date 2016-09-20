//
//  DB+Login.h
//  Shop
//
//  Created by 陈立豪 on 16/9/13.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "DB.h"

@interface DB (Login)
-(BOOL)LoginWithAccount:(NSString*) account Password:(NSString*)psw;
-(BOOL)registerWithAccount:(NSString*)account Password:(NSString*)psw;
@end
