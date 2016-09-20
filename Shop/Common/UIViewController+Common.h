//
//  UIViewController+Common.h
//  Shop
//
//  Created by 陈立豪 on 16/9/19.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Common)
-(BOOL)saveImage:(UIImage*)image withName:(NSString*)name atPath:(NSString*)imageDir;
@end
