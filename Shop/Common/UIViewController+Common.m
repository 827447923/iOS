//
//  UIViewController+Common.m
//  Shop
//
//  Created by 陈立豪 on 16/9/19.
//  Copyright © 2016年 陈立豪. All rights reserved.
//

#import "UIViewController+Common.h"
#import "User.h"
@implementation UIViewController (Common)

-(BOOL)saveImage:(UIImage*)image withName:(NSString*)name atPath:(NSString*)imageDir{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    NSString *fullImageDir = [documentDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[User shareUser].name,imageDir]];
    NSString *fullImagePath = [fullImageDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    NSFileManager *fileMamager = [NSFileManager defaultManager];
    if(![fileMamager fileExistsAtPath:fullImageDir]){
        [fileMamager createDirectoryAtPath:fullImageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }else{
        NSLog(@"failed to create directory:%@",fullImagePath);
    }
    if([UIImagePNGRepresentation(image)writeToFile:fullImagePath atomically:YES] == NO){
        return NO;
    }
    return  YES;
}

@end
